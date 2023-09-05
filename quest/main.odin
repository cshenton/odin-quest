package quest

import c "core:c/libc"
import "core:fmt"
import "core:math"
import la "core:math/linalg"
import "core:runtime"
import gl "vendor:OpenGL"

import egl "./egl"
import glue "./android/glue"
import "./android"
import xr "./openxr"

HAND_COUNT :: 2
MAX_VIEWS :: 4
MAX_SWAPCHAIN_LENGTH :: 3

App :: struct {
        // Native app glue
        app: ^glue.App,
        is_window_init: bool,

        // EGL state required to initialise OpenXR
        egl_display: egl.Display,
        egl_config: egl.Config,
        egl_context: egl.Context,
        egl_surface: egl.Surface,

        // OpenXR driver state
        instance: xr.Instance,
        system: xr.SystemId,
        session: xr.Session,

        // Views
        view_count: u32,
        view_configs: [MAX_VIEWS]xr.ViewConfigurationView,

        // Spaces
        stage_space: xr.Space,
        hand_spaces: [HAND_COUNT]xr.Space,

        // OpenXR paths (interned query strings)
        touch_controller_path: xr.Path,
        hand_paths: [HAND_COUNT]xr.Path,
        squeeze_value_paths: [HAND_COUNT]xr.Path,
        trigger_value_paths: [HAND_COUNT]xr.Path,
        pose_paths: [HAND_COUNT]xr.Path,
        haptic_paths: [HAND_COUNT]xr.Path,
        menu_click_paths: [HAND_COUNT]xr.Path,

        // Action Set and Actions
        action_set: xr.ActionSet,
        grab_action: xr.Action,
        trigger_action: xr.Action,
        trigger_click_action: xr.Action,
        pose_action: xr.Action,
        vibrate_action: xr.Action,
        menu_action: xr.Action,

        // Swapchains
        swapchain_widths: [MAX_VIEWS]i32,
        swapchain_heights: [MAX_VIEWS]i32,
        swapchain_lengths: [MAX_VIEWS]u32,
        swapchains: [MAX_VIEWS]xr.Swapchain,
	swapchain_images: [MAX_VIEWS][MAX_SWAPCHAIN_LENGTH]xr.SwapchainImageOpenGLESKHR,

        // OpenGL state
        box_program: u32,
        background_program: u32,
        framebuffer: u32,
        depth_targets: [MAX_VIEWS]u32,

        // Current Controller Inputs
        hand_locations: [HAND_COUNT]xr.SpaceLocation,
        trigger_states: [HAND_COUNT]xr.ActionStateFloat,
        trigger_click_states: [HAND_COUNT]xr.ActionStateBoolean,

        // Session State
        session_state: xr.SessionState,
        frame_state: xr.FrameState,
        should_render: bool,
        is_running: bool,
        is_session_running: bool,

        // Frame Submission
        view_submit_count: u32,
        projection_layer: xr.CompositionLayerProjection,
        projection_layer_views: [MAX_VIEWS]xr.CompositionLayerProjectionView,
}

app_android_handle_cmd :: proc "c" (app: ^glue.App, cmd: glue.App_Cmd) {
        a := cast(^App)app.userData

        #partial switch cmd {
        case .Destroy: {
                // Handle application shutdown
                // ANativeActivity_finish(app.activity);
                // TODO: call app_shutdown
        }
        case .Init_Window: {
                if !a.is_window_init {
                        a.is_window_init = true;
                        // printf( "Got start event\n" );
                }
                // TODO: else, handle resume
        }
        case .Term_Window: break // Turns up when focus is lost
        case .Save_State: break
        case .Resume: break
        }
}

app_set_callbacks_and_wait :: proc(a: ^App, ga: ^glue.App) {
        a.app = ga
        ga.userData = a
        ga.onAppCmd = app_android_handle_cmd

        events: i32
        for !a.is_window_init {
                source: ^glue.Poll_Source
                if android.ALooper_pollAll(0, nil, &events, cast(^rawptr)&source) >= 0 {
                        if source != nil {
                                source.process(ga, source)
                        }
                }
        }
        c.printf("Window Initialized\n")
}

// Initialise EGL resources and context, needed later to pass to OpenXR
app_init_egl :: proc(a: ^App) {
        // Display
        a.egl_display = egl.GetDisplay(egl.DEFAULT_DISPLAY)
        assert(a.egl_display != egl.NO_DISPLAY)
        egl_major, egl_minor: i32
        egl_init_success := egl.Initialize(a.egl_display, &egl_major, &egl_minor)
        assert(bool(egl_init_success))

        c.printf("Some Function Pointers %p, %p, %p\n", egl.GetDisplay, egl.QueryString, egl.ChooseConfig)

        c.printf("EGL Version: \"%s\"\n", egl.QueryString(a.egl_display, egl.VERSION))
        c.printf("EGL Vendor: \"%s\"\n", egl.QueryString(a.egl_display, egl.VENDOR))
        c.printf("EGL Extensions: \"%s\"\n", egl.QueryString(a.egl_display, egl.EXTENSIONS))

        // Config
        num_config: i32
        config_attribute_list := [?]i32{
                egl.RED_SIZE, 8,
                egl.GREEN_SIZE, 8,
                egl.BLUE_SIZE, 8,
                egl.ALPHA_SIZE, 8,
                egl.BUFFER_SIZE, 32,
                egl.STENCIL_SIZE, 0,
                egl.DEPTH_SIZE, 16, // Maybe 32?
                //EGL_SAMPLES, 1,
                egl.RENDERABLE_TYPE, egl.OPENGL_ES3_BIT,
                egl.NONE,
        }
        egl.ChooseConfig(a.egl_display, &config_attribute_list[0], &a.egl_config, 1, &num_config)
        c.printf("Config: %d\n", num_config)

        // Context
        c.printf("Creating Context\n")
        context_attribute_list := [?]i32{
                egl.CONTEXT_CLIENT_VERSION, 2,
                egl.NONE,
        }
        a.egl_context = egl.CreateContext(a.egl_display, a.egl_config, egl.NO_CONTEXT, &context_attribute_list[0])
        assert(a.egl_context != egl.NO_CONTEXT)
        c.printf("Context Created %p\n", a.egl_context)

        // Surface
        assert(a.app.window != nil)
        // win_width := ANativeWindow_getWidth(a.app.window)
        // win_height := ANativeWindow_getHeight(a.app.window)
        // c.printf("Width/Height: %dx%d\n", win_width, win_height)
        window_attribute_list := [?]i32{ egl.NONE }
        a.egl_surface = egl.CreateWindowSurface(a.egl_display, a.egl_config, a.app.window, &window_attribute_list[0])
        c.printf("Got Surface: %p\n", a.egl_surface)
        assert(a.egl_surface != egl.NO_SURFACE)

        // Make Current
        egl_make_current_success := egl.MakeCurrent(a.egl_display, a.egl_surface, a.egl_surface, a.egl_context)
        assert(bool(egl_make_current_success))

        // Load function pointers as high as available
        gl.load_up_to(4, 6, egl.gl_set_proc_address)

        // Make some OpenGL calls
        c.printf("GL Vendor: \"%s\"\n", gl.GetString(gl.VENDOR))
        c.printf("GL Renderer: \"%s\"\n", gl.GetString(gl.RENDERER))
        c.printf("GL Version: \"%s\"\n", gl.GetString(gl.VERSION))
        c.printf("GL Extensions: \"%s\"\n", gl.GetString(gl.EXTENSIONS))
}


// Initialise the loader, ensure we have the extensions we need, and create the OpenXR instance
app_init_xr_create_instance :: proc(a: ^App) {
        result: xr.Result

        // Loader
        loader_func: xr.ProcInitializeLoaderKHR
	result = xr.GetInstanceProcAddr(nil, "xrInitializeLoaderKHR", cast(^xr.ProcVoidFunction)&loader_func)
        c.printf("Got Initialize Loader Proc\n")
        assert(xr.succeeded(result))
	init_data := xr.LoaderInitInfoAndroidKHR {
                sType = .LOADER_INIT_INFO_ANDROID_KHR,
                applicationVM = a.app.activity.vm,
                applicationContext = a.app.activity.clazz,
        }
	result = loader_func(cast(^xr.LoaderInitInfoBaseHeaderKHR)&init_data)
        assert(xr.succeeded(result))
        xr.load_base_procs()

        // Enumerate Extensions
        extension_properties: [128]xr.ExtensionProperties
	extension_count := u32(0)
	result = xr.EnumerateInstanceExtensionProperties(nil, 0, &extension_count, nil)
        assert(xr.succeeded(result))
        assert(extension_count <= 128)
        for i in 0 ..< extension_count {
                extension_properties[i].sType = .EXTENSION_PROPERTIES
                extension_properties[i].next = nil
        }
        result = xr.EnumerateInstanceExtensionProperties(nil, extension_count, &extension_count, &extension_properties[0])
        assert(xr.succeeded(result))
        c.printf("OpenXR Extension Count: %d\n", extension_count)
        for i in 0 ..< extension_count {
                c.printf("        %s\n", &extension_properties[i].extensionName[0])
        }

        // Check for GLES Extension
	is_gles_supported := false
        for i in 0 ..< extension_count {
		if "XR_KHR_opengl_es_enable" == cstring(&extension_properties[i].extensionName[0]) {
			is_gles_supported = true
		}
	}
        assert(is_gles_supported)
        c.printf("OpenXR OpenGL ES extension found\n")

        // Create Instance
	enabledExtensions := [?]cstring{"XR_KHR_opengl_es_enable"}
        application_info := xr.ApplicationInfo{
                applicationName = xr.make_string("questxrexample", 128),
                engineName = xr.make_string("No Engine", 128),
                applicationVersion = 1,
                engineVersion = 1,
                apiVersion = xr.CURRENT_API_VERSION,
        }
        instance_desc := xr.InstanceCreateInfo{
                sType = .INSTANCE_CREATE_INFO,
                enabledExtensionCount = 1,
                enabledExtensionNames = &enabledExtensions[0],
                applicationInfo = application_info,
        }
	result = xr.CreateInstance(&instance_desc, &a.instance)
        assert(xr.succeeded(result))
        xr.load_instance_procs(a.instance)

        // Instance Properties
        instance_props := xr.InstanceProperties{ sType = .INSTANCE_PROPERTIES }
        result = xr.GetInstanceProperties(a.instance, &instance_props)
        c.printf("Hello Pal, Instance Properties Got\n")
        assert(xr.succeeded(result))
        c.printf("Runtime Name: %s\n", &instance_props.runtimeName[0])
        c.printf("Runtime Name: %s\n", &instance_props.runtimeName[0])
        // c.printf("Runtime Version: %d.%d.%d\n",
        //         xr.VERSION_MAJOR(instance_props.runtimeVersion),
        //         xr.VERSION_MINOR(instance_props.runtimeVersion),
        //         xr.VERSION_PATCH(instance_props.runtimeVersion))

        // Enumerate API Layers
        layer_props: [64]xr.ApiLayerProperties
        layer_count := u32(0)
        result = xr.EnumerateApiLayerProperties(0, &layer_count, nil)
        assert(xr.succeeded(result))
        for i in 0 ..< layer_count {
                layer_props[i].sType = .API_LAYER_PROPERTIES
                layer_props[i].next = nil
        }
        result = xr.EnumerateApiLayerProperties(layer_count, &layer_count, &layer_props[0])
        assert(xr.succeeded(result))
        c.printf("OpenXR API Layers: %d\n", layer_count)
        for i in 0 ..< layer_count {
                c.printf("        %s, %s\n", &layer_props[i].layerName[0], &layer_props[i].description[0])
        }
}

// Get the system and print its properties
app_init_xr_get_system :: proc (a: ^App) {
        system_desc := xr.SystemGetInfo{
                sType = .SYSTEM_GET_INFO,
                formFactor = .HEAD_MOUNTED_DISPLAY,
        }
	result := xr.GetSystem(a.instance, &system_desc, &a.system)
        assert(xr.succeeded(result))

        system_props := xr.SystemProperties{ sType = .SYSTEM_PROPERTIES }
        result = xr.GetSystemProperties(a.instance, a.system, &system_props)
        assert(xr.succeeded(result))

        c.printf("System properties for system \"%s\":\n", &system_props.systemName[0])
        c.printf("	maxLayerCount: %d\n", system_props.graphicsProperties.maxLayerCount)
        c.printf("	maxSwapChainImageHeight: %d\n", system_props.graphicsProperties.maxSwapchainImageHeight)
        c.printf("	maxSwapChainImageWidth: %d\n", system_props.graphicsProperties.maxSwapchainImageWidth)
        c.printf("	Orientation Tracking: %s\n", system_props.trackingProperties.orientationTracking ? "true" : "false")
        c.printf("	Position Tracking: %s\n", system_props.trackingProperties.positionTracking ? "true" : "false")
}

// Enumerate the views (perspectives we need to render) and print their properties
app_init_xr_enum_views :: proc(a: ^App) {
        result: xr.Result

        // Enumerate View Configs
        result = xr.EnumerateViewConfigurationViews(a.instance, a.system, .PRIMARY_STEREO, 0, &a.view_count, nil)
        assert(xr.succeeded(result))
        assert(a.view_count <= MAX_VIEWS)
        for i in 0 ..< a.view_count {
                a.view_configs[i].sType = .VIEW_CONFIGURATION_VIEW
                a.view_configs[i].next = nil
        }
        result = xr.EnumerateViewConfigurationViews(a.instance, a.system, .PRIMARY_STEREO, a.view_count, &a.view_count, &a.view_configs[0])
        assert(xr.succeeded(result))
        c.printf("%d view_configs:\n", a.view_count)
        for i in 0 ..< a.view_count {
                c.printf("	view_configs[%d]:\n", i)
                c.printf("		recommendedImageRectWidth: %d\n", a.view_configs[i].recommendedImageRectWidth)
                c.printf("		maxImageRectWidth: %d\n", a.view_configs[i].maxImageRectWidth)
                c.printf("		recommendedImageRectHeight: %d\n", a.view_configs[i].recommendedImageRectHeight)
                c.printf("		maxImageRectHeight: %d\n", a.view_configs[i].maxImageRectHeight)
                c.printf("		recommendedSwapchainSampleCount: %d\n", a.view_configs[i].recommendedSwapchainSampleCount)
                c.printf("		maxSwapchainSampleCount: %d\n", a.view_configs[i].maxSwapchainSampleCount)
        }
}

// Create the session, passing in our EGL information
app_init_xr_create_session :: proc(a: ^App) {
        result: xr.Result

        // Create the session
	gles_reqs_func: xr.ProcGetOpenGLESGraphicsRequirementsKHR
	xr.GetInstanceProcAddr(a.instance, "xrGetOpenGLESGraphicsRequirementsKHR", cast(^xr.ProcVoidFunction)&gles_reqs_func)
	xr_gles_reqs := xr.GraphicsRequirementsOpenGLESKHR { sType = .GRAPHICS_REQUIREMENTS_OPENGL_ES_KHR }
	result = gles_reqs_func(a.instance, a.system, &xr_gles_reqs)
        assert(xr.succeeded(result))
	egl_version := xr.MAKE_VERSION(3, 2, 0)
        assert(egl_version >= xr_gles_reqs.minApiVersionSupported && egl_version <= xr_gles_reqs.maxApiVersionSupported)

	gl_binding := xr.GraphicsBindingOpenGLESAndroidKHR{
                sType = .GRAPHICS_BINDING_OPENGL_ES_ANDROID_KHR,
                display  = a.egl_display,
                config = a.egl_config,
                ccontext = a.egl_context,
        }
        session_desc := xr.SessionCreateInfo{
                sType = .SESSION_CREATE_INFO,
                next = &gl_binding,
                systemId = a.system,
        }
	result = xr.CreateSession(a.instance, &session_desc, &a.session)
        assert(xr.succeeded(result))
}

// Create the reference space, and print available spaces
app_init_xr_create_stage_space :: proc(a: ^App) {
        result: xr.Result

        // Create Space
        reference_spaces_count: u32
        reference_spaces: [64]xr.ReferenceSpaceType
        result = xr.EnumerateReferenceSpaces(a.session, 0, &reference_spaces_count, nil)
        assert(xr.succeeded(result) && reference_spaces_count <= 64)
        for i in 0 ..< reference_spaces_count {
                reference_spaces[i] = .VIEW
        }
        result = xr.EnumerateReferenceSpaces(a.session, reference_spaces_count,
                &reference_spaces_count, &reference_spaces[0])
        assert(xr.succeeded(result))
        c.printf("Reference Spaces:\n")
        for i in 0 ..< reference_spaces_count {
                #partial switch (reference_spaces[i]) {
                case .VIEW: c.printf("\t.VIEW\n")
                case .LOCAL: c.printf("\t.LOCAL\n")
                case .STAGE: c.printf("\t.STAGE\n")
                case: c.printf("\t.%d\n", reference_spaces[i])
                }
        }

	identity_pose := xr.Posef{ {0.0, 0.0, 0.0, 1.0}, {0.0, 0.0, 0.0} }
        space_desc := xr.ReferenceSpaceCreateInfo{
                sType = .REFERENCE_SPACE_CREATE_INFO,
                next = nil,
                referenceSpaceType = .STAGE,
                poseInReferenceSpace = identity_pose,
        }
	result = xr.CreateReferenceSpace(a.session, &space_desc, &a.stage_space)
        assert(xr.succeeded(result))
}


// Create the action set, actions, interaction profile, and attach the action set to the session
app_init_xr_create_actions :: proc(a: ^App) {
        result: xr.Result

        c.printf("Creating Actions\n")

        // Create Action Set
	action_set_desc := xr.ActionSetCreateInfo{
                sType = .ACTION_SET_CREATE_INFO,
                actionSetName = xr.make_string("gameplay", xr.MAX_ACTION_SET_NAME_SIZE),
                localizedActionSetName = xr.make_string("Gameplay", xr.MAX_LOCALIZED_ACTION_SET_NAME_SIZE),
        }
	result = xr.CreateActionSet(a.instance, &action_set_desc, &a.action_set)
        assert(xr.succeeded(result))

        // Create sub-action paths
	xr.StringToPath(a.instance, "/user/hand/left", &a.hand_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right", &a.hand_paths[1])
	xr.StringToPath(a.instance, "/user/hand/left/input/squeeze/value",  &a.squeeze_value_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right/input/squeeze/value", &a.squeeze_value_paths[1])
	xr.StringToPath(a.instance, "/user/hand/left/input/trigger/value",  &a.trigger_value_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right/input/trigger/value", &a.trigger_value_paths[1])
	xr.StringToPath(a.instance, "/user/hand/left/input/grip/pose", &a.pose_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right/input/grip/pose", &a.pose_paths[1])
	xr.StringToPath(a.instance, "/user/hand/left/output/haptic", &a.haptic_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right/output/haptic", &a.haptic_paths[1])
	xr.StringToPath(a.instance, "/user/hand/left/input/menu/click", &a.menu_click_paths[0])
	xr.StringToPath(a.instance, "/user/hand/right/input/menu/click", &a.menu_click_paths[1])

        // Create Actions
        grab_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .FLOAT_INPUT,
                actionName = xr.make_string("grab_object", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Grab Object", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &grab_desc, &a.grab_action)
        assert(xr.succeeded(result))

        trigger_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .FLOAT_INPUT,
                actionName = xr.make_string("trigger", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Trigger", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &trigger_desc, &a.trigger_action)
        assert(xr.succeeded(result))

        click_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .BOOLEAN_INPUT,
                actionName = xr.make_string("trigger_click", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Trigger Click", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &click_desc, &a.trigger_click_action)
        assert(xr.succeeded(result))

        pose_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .POSE_INPUT,
                actionName = xr.make_string("hand_pose", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Hand Pose", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &pose_desc, &a.pose_action)
        assert(xr.succeeded(result))

        vibrate_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .VIBRATION_OUTPUT,
                actionName = xr.make_string("vibrate_hand", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Vibrate Hand", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &vibrate_desc, &a.vibrate_action)
        assert(xr.succeeded(result))

        menu_desc := xr.ActionCreateInfo{
                sType = .ACTION_CREATE_INFO,
                actionType = .BOOLEAN_INPUT,
                actionName = xr.make_string("quit_session", xr.MAX_ACTION_NAME_SIZE),
                localizedActionName = xr.make_string("Menu Button", xr.MAX_LOCALIZED_ACTION_NAME_SIZE),
                countSubactionPaths = 2,
                subactionPaths = &a.hand_paths[0],
        }
	result = xr.CreateAction(a.action_set, &menu_desc, &a.menu_action)
        assert(xr.succeeded(result))

        // Oculus Touch Controller Interaction Profile
        xr.StringToPath(a.instance, "/interaction_profiles/oculus/touch_controller", &a.touch_controller_path)
        bindings := [?]xr.ActionSuggestedBinding{
                {a.grab_action, a.squeeze_value_paths[0]},
                {a.grab_action, a.squeeze_value_paths[1]},
                {a.trigger_action, a.trigger_value_paths[0]},
                {a.trigger_action, a.trigger_value_paths[1]},
                {a.trigger_click_action, a.trigger_value_paths[0]},
                {a.trigger_click_action, a.trigger_value_paths[1]},
                {a.pose_action, a.pose_paths[0]},
                {a.pose_action, a.pose_paths[1]},
                {a.menu_action, a.menu_click_paths[0]},
                {a.vibrate_action, a.haptic_paths[0]},
                {a.vibrate_action, a.haptic_paths[1]},
        }
        suggested_bindings := xr.InteractionProfileSuggestedBinding{
                sType = .INTERACTION_PROFILE_SUGGESTED_BINDING,
                interactionProfile = a.touch_controller_path,
                suggestedBindings = &bindings[0],
                countSuggestedBindings = len(bindings),
        }
        result = xr.SuggestInteractionProfileBindings(a.instance, &suggested_bindings)
        assert(xr.succeeded(result))

        // Hand Spaces
	action_space_desc := xr.ActionSpaceCreateInfo{
                sType = .ACTION_SPACE_CREATE_INFO,
                action = a.pose_action,
                poseInActionSpace = {{0.0, 0.0, 0.0, 1.0}, {0.0, 0.0, 0.0}},
                subactionPath = a.hand_paths[0],
        }
	result = xr.CreateActionSpace(a.session, &action_space_desc, &a.hand_spaces[0])
        assert(xr.succeeded(result))
	action_space_desc.subactionPath = a.hand_paths[1]
	result = xr.CreateActionSpace(a.session, &action_space_desc, &a.hand_spaces[1])
        assert(xr.succeeded(result))

        // Attach Action Set
	session_actions_desc := xr.SessionActionSetsAttachInfo{
                sType = .SESSION_ACTION_SETS_ATTACH_INFO,
                countActionSets = 1,
                actionSets = &a.action_set,
        }
	result = xr.AttachSessionActionSets(a.session, &session_actions_desc)
        assert(xr.succeeded(result))
}


// Choose a swapchain format, and create a swapchain per view
app_init_xr_create_swapchains :: proc(a: ^App) {
        result: xr.Result

        // Choose Swapchain Format
        swapchain_format_count: u32
        result = xr.EnumerateSwapchainFormats(a.session, 0, &swapchain_format_count, nil)
        assert(xr.succeeded(result))
        assert(swapchain_format_count <= 128)
        swapchain_formats: [128]i64
        result = xr.EnumerateSwapchainFormats(a.session, swapchain_format_count, &swapchain_format_count, &swapchain_formats[0])
        assert(xr.succeeded(result))
        is_default := true
        selected_format := i64(0)
        for i in 0 ..< swapchain_format_count {
                if swapchain_formats[i] == gl.SRGB8_ALPHA8 {
                        is_default = false
                        selected_format = swapchain_formats[i]
                }
                if swapchain_formats[i] == gl.SRGB8 && is_default {
                        is_default = false
                        selected_format = swapchain_formats[i]
                }
        }

        for i in 0 ..< a.view_count {
                // Create Swapchain
                swapchain_desc := xr.SwapchainCreateInfo{
                        sType = .SWAPCHAIN_CREATE_INFO,
                        usageFlags = {.SAMPLED, .COLOR_ATTACHMENT},
                        format = selected_format,
                        sampleCount = 1,
                        width = a.view_configs[i].recommendedImageRectWidth,
                        height = a.view_configs[i].recommendedImageRectHeight,
                        faceCount = 1,
                        arraySize = 1,
                        mipCount = 1,
                }
		result = xr.CreateSwapchain(a.session, &swapchain_desc, &a.swapchains[i])
                assert(xr.succeeded(result))
                a.swapchain_widths[i] = i32(swapchain_desc.width)
                a.swapchain_heights[i] = i32(swapchain_desc.height)

                // Enumerate Swapchain Images
                result = xr.EnumerateSwapchainImages(a.swapchains[i], 0, &a.swapchain_lengths[i], nil)
                assert(xr.succeeded(result) && a.swapchain_lengths[i] <= MAX_SWAPCHAIN_LENGTH)
		for j in 0 ..< a.swapchain_lengths[i] {
			a.swapchain_images[i][j].sType = .SWAPCHAIN_IMAGE_OPENGL_ES_KHR
			a.swapchain_images[i][j].next = nil
		}
                image_header := cast(^xr.SwapchainImageBaseHeader)(&a.swapchain_images[i][0])
		result = xr.EnumerateSwapchainImages(a.swapchains[i], a.swapchain_lengths[i], &a.swapchain_lengths[i], image_header)
                assert(xr.succeeded(result))
	}

        c.printf("Swapchains:\n")
        for i in 0 ..< a.view_count {
                c.printf("        width: %d\n", a.swapchain_widths[i])
                c.printf("        height: %d\n", a.swapchain_heights[i])
                c.printf("        length: %d\n", a.swapchain_lengths[i])
        }
}

// Create a framebuffer, and a depth buffer per view
app_init_opengl_framebuffers :: proc(a: ^App) {
        gl.GenFramebuffers(1, &a.framebuffer)

        for i in 0 ..< a.view_count {
                width := a.swapchain_widths[i]
                height := a.swapchain_heights[i]

                gl.GenTextures(1, &a.depth_targets[i])
                gl.BindTexture(gl.TEXTURE_2D, a.depth_targets[i])
                gl.TexImage2D(gl.TEXTURE_2D, 0, gl.DEPTH24_STENCIL8, width, height, 0, gl.DEPTH_STENCIL, gl.UNSIGNED_INT_24_8, nil)
                gl.FramebufferTexture2D(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.TEXTURE_2D, a.depth_targets[i], 0)
        }
}

app_compile_shader :: proc(vert_src, frag_src: cstring) -> (program: u32) {
        vert_src := vert_src
        frag_src := frag_src

        // Box Program
        vert_shd := gl.CreateShader(gl.VERTEX_SHADER)
        gl.ShaderSource(vert_shd, 1, &vert_src, nil)
        gl.CompileShader(vert_shd)

        success: i32
        gl.GetShaderiv(vert_shd, gl.COMPILE_STATUS, &success)
        if success == 0 {
                info_log: [512]u8
                gl.GetShaderInfoLog(vert_shd, 512, nil, &info_log[0])
                c.printf("Vertex shader compilation failed:\n %s\n", cstring(&info_log[0]))
        }

        frag_shd := gl.CreateShader(gl.FRAGMENT_SHADER)
        gl.ShaderSource(frag_shd, 1, &frag_src, nil)
        gl.CompileShader(frag_shd)

        gl.GetShaderiv(frag_shd, gl.COMPILE_STATUS, &success)
        if success == 0 {
                info_log: [512]u8
                gl.GetShaderInfoLog(frag_shd, 512, nil, &info_log[0])
                c.printf("Fragment shader compilation failed:\n %s\n", cstring(&info_log[0]))
        }

        program = gl.CreateProgram()
        gl.AttachShader(program, vert_shd)
        gl.AttachShader(program, frag_shd)
        gl.LinkProgram(program)

        gl.GetProgramiv(program, gl.LINK_STATUS, &success)
        if success == 0 {
                info_log: [512]u8
                gl.GetProgramInfoLog(program, 512, nil, &info_log[0])
                c.printf("Program Linking failed:\n %s\n", cstring(&info_log[0]))
        }

        gl.DeleteShader(vert_shd)
        gl.DeleteShader(frag_shd)

        return
}

// Compile the OpenGL shaders into programs
app_init_opengl_shaders :: proc(a: ^App) {
        gl.Enable(gl.DEPTH_TEST)

        a.box_program = app_compile_shader(BOX_VERT_SRC, BOX_FRAG_SRC)
        a.background_program = app_compile_shader(BACKGROUND_VERT_SRC, BACKGROUND_FRAG_SRC)
}

// Initialises the application state
app_init :: proc(a: ^App, ga: ^glue.App) {
        app_set_callbacks_and_wait(a, ga)
        app_init_egl(a)
        app_init_xr_create_instance(a)
        app_init_xr_get_system(a)
        app_init_xr_enum_views(a)
        app_init_xr_create_session(a)
        app_init_xr_create_stage_space(a)
        app_init_xr_create_actions(a)
        app_init_xr_create_swapchains(a)
        app_init_opengl_framebuffers(a)
        app_init_opengl_shaders(a)
}

// Begin the OpenXR session
app_update_begin_session :: proc(a: ^App) {
        c.printf("Beginning Session")
        begin_desc := xr.SessionBeginInfo{
                sType = .SESSION_BEGIN_INFO,
                primaryViewConfigurationType = .PRIMARY_STEREO,
        }
        result := xr.BeginSession(a.session, &begin_desc)
        assert(xr.succeeded(result))
        a.is_session_running = true
}

// Handle session state changes
app_update_session_state_change :: proc(a: ^App, state: xr.SessionState) {
        a.session_state = state
        #partial switch (a.session_state) {
        case .IDLE: c.printf(".IDLE\n")
        case .READY: c.printf(".READY\n"); app_update_begin_session(a)
        case .SYNCHRONIZED: c.printf(".SYNCHRONIZED\n")
        case .VISIBLE: c.printf(".VISIBLE\n")
        case .FOCUSED: c.printf(".FOCUSED\n")
        case .STOPPING: {
                c.printf(".STOPPING\n")
                result := xr.EndSession(a.session)
                assert(xr.succeeded(result))
                a.is_session_running = false
        }
        case .LOSS_PENDING: c.printf(".LOSS_PENDING\n")
        case .EXITING: c.printf(".EXITING\n")
        case: c.printf(".??? %d\n", i32(a.session_state))
        }
}

// Pump the android and OpenXR event loops
app_update_pump_events :: proc(a: ^App) {
        // // Pump Android Event Loop
        events: i32
        source: ^glue.Poll_Source
        for android.ALooper_pollAll(0, nil, &events, cast(^rawptr)&source) >= 0 {
                if source != nil {
                        source.process(a.app, source)
                }
        }

        // Pump OpenXR Event Loop
        is_remaining_events := true
        for is_remaining_events {
                event_data := xr.EventDataBuffer{ sType = .EVENT_DATA_BUFFER }
                result := xr.PollEvent(a.instance, &event_data)
                assert(xr.succeeded(result))
                if (result != .SUCCESS) {
                        is_remaining_events = false
                        continue
                }

                #partial switch event_data.sType {
                case .EVENT_DATA_INSTANCE_LOSS_PENDING:
                        c.printf("Event: .EVENT_DATA_INSTANCE_LOSS_PENDING\n")
                        // TODO: Handle, or prefer to handle loss pending in session state?
                case .EVENT_DATA_SESSION_STATE_CHANGED: {
                        c.printf("Event: .EVENT_DATA_SESSION_STATE_CHANGED -> ")
                        ssc := cast(^xr.EventDataSessionStateChanged)&event_data
                        app_update_session_state_change(a, ssc.state)
                }
                case .EVENT_DATA_REFERENCE_SPACE_CHANGE_PENDING:
                        c.printf("Event: .EVENT_DATA_REFERENCE_SPACE_CHANGE_PENDING\n")
                        // TODO: Handle Reference Spaces changes
                case .EVENT_DATA_EVENTS_LOST:
                        c.printf("Event: .EVENT_DATA_EVENTS_LOST\n")
                        // TODO: print warning
                case .EVENT_DATA_INTERACTION_PROFILE_CHANGED:
                        c.printf("Event: .EVENT_DATA_INTERACTION_PROFILE_CHANGED\n")
                        // TODO: this shouldn't happen but handle
                case:
                        c.printf("Event: Unhandled event type %d\n", event_data.sType)
                }
        }
}

// Wait for the next frame, and get the transforms and button inputs of the controllers
app_update_begin_frame_and_get_inputs :: proc(a: ^App) {
        result: xr.Result

        // Sync Input
        active_action_set := xr.ActiveActionSet{
                actionSet = a.action_set,
                subactionPath = xr.Path(0),
        }
        action_sync_info := xr.ActionsSyncInfo{
                sType = .ACTIONS_SYNC_INFO,
                next = nil,
                countActiveActionSets = 1,
                activeActionSets = &active_action_set,
        }
        result = xr.SyncActions(a.session, &action_sync_info)
        assert(xr.succeeded(result))

        // Wait Frame
        a.frame_state.sType = .FRAME_STATE
        a.frame_state.next = nil
        frame_wait := xr.FrameWaitInfo{
                sType = .FRAME_WAIT_INFO,
                next = nil,
        }
        result = xr.WaitFrame(a.session, &frame_wait, &a.frame_state)
        assert(xr.succeeded(result))
        a.should_render = bool(a.frame_state.shouldRender)

        // TODO: Different code paths for focussed vs. not focussed

        // Get Action States and Spaces (i.e. current state of the controller inputs)
        for i in 0 ..< HAND_COUNT {
                a.hand_locations[i].sType = .SPACE_LOCATION
                a.trigger_states[i].sType = .ACTION_STATE_FLOAT
                a.trigger_click_states[i].sType = .ACTION_STATE_BOOLEAN
        }

        result = xr.LocateSpace(a.hand_spaces[0], a.stage_space, a.frame_state.predictedDisplayTime, &a.hand_locations[0])
        assert(xr.succeeded(result))
        result = xr.LocateSpace(a.hand_spaces[1], a.stage_space, a.frame_state.predictedDisplayTime, &a.hand_locations[1])
        assert(xr.succeeded(result))

        action_get_info := xr.ActionStateGetInfo{
                sType = .ACTION_STATE_GET_INFO,
                action = a.trigger_action,
                subactionPath = a.hand_paths[0],
        }
        xr.GetActionStateFloat(a.session, &action_get_info, &a.trigger_states[0])
        action_get_info.subactionPath = a.hand_paths[1]
        xr.GetActionStateFloat(a.session, &action_get_info, &a.trigger_states[1])
        action_get_info.action = a.trigger_click_action
        action_get_info.subactionPath = a.hand_paths[0]
        xr.GetActionStateBoolean(a.session, &action_get_info, &a.trigger_click_states[0])
        action_get_info.subactionPath = a.hand_paths[1]
        xr.GetActionStateBoolean(a.session, &action_get_info, &a.trigger_click_states[1])

        frame_begin := xr.FrameBeginInfo{
                sType = .FRAME_BEGIN_INFO,
                next = nil,
        }
        result = xr.BeginFrame(a.session, &frame_begin)
        assert(xr.succeeded(result))
}

projection_from_fov_gl :: proc(fov: xr.Fovf, near, far: f32) -> (proj: matrix[4, 4]f32) {
	left := math.tan(fov.angleLeft)
	right := math.tan(fov.angleRight)
	down := math.tan(fov.angleDown)
	up := math.tan(fov.angleUp)

	width := right - left
	height := up - down // Vulkan, and no offsets since this isn't GL
        offset := near

	proj = matrix[4, 4]f32 {
		2.0 / width, 0.0, (right + left) / width, 0.0,
		0.0, 2.0 / height, (up + down) / height, 0.0,
		0.0, 0.0, -(far + offset) / (far - near), -(far * (near + offset)) / (far - near),
		0.0, 0.0, -1.0, 0.0,
	}

	return
}

model_from_pose :: proc(pose: xr.Posef) -> (view: matrix[4, 4]f32) {
	cam_pos := pose.position
	cam_rot := pose.orientation
	translation := la.matrix4_translate_f32(transmute(la.Vector3f32)cam_pos)
	rotation := la.matrix4_from_quaternion_f32(transmute(la.Quaternionf32)cam_rot)
	return translation * rotation
}

// Locate the views, and render into the swapchains
app_update_render :: proc(a: ^App) {
        result: xr.Result

        // Reset Composition Layer
        a.projection_layer = xr.CompositionLayerProjection{
                sType = .COMPOSITION_LAYER_PROJECTION,
                space = a.stage_space,
        }

        // Locate Views
        views: [MAX_VIEWS]xr.View
        for i in 0 ..< a.view_count {
                views[i].sType = .VIEW;
                views[i].next = nil;
        }
        view_state := xr.ViewState{ sType = .VIEW_STATE }
        view_locate_info := xr.ViewLocateInfo{
                sType = .VIEW_LOCATE_INFO,
                viewConfigurationType = .PRIMARY_STEREO,
                displayTime = a.frame_state.predictedDisplayTime,
                space = a.stage_space,
        }
        result = xr.LocateViews(a.session, &view_locate_info, &view_state, a.view_count, &a.view_submit_count, &views[0])
        assert(xr.succeeded(result))

        // Fill in Projection Views info
        for i in 0 ..< a.view_submit_count {
                sub_image := xr.SwapchainSubImage{
                        swapchain = a.swapchains[i],
                        imageRect = {{0, 0}, {a.swapchain_widths[i], a.swapchain_heights[i]}},
                        imageArrayIndex = 0,
                }
                a.projection_layer_views[i] = xr.CompositionLayerProjectionView{
                        sType = .COMPOSITION_LAYER_PROJECTION_VIEW,
                        subImage = sub_image,
                        pose = views[i].pose,
                        fov = views[i].fov,
                }
        }

        for v in 0 ..< a.view_submit_count {
                // Acquire and wait for the swapchain image
                image_index: u32
                acquire_info := xr.SwapchainImageAcquireInfo { sType = .SWAPCHAIN_IMAGE_ACQUIRE_INFO }
                result = xr.AcquireSwapchainImage(a.swapchains[v], &acquire_info, &image_index)
                assert(xr.succeeded(result))
                wait_info := xr.SwapchainImageWaitInfo{
                        sType = .SWAPCHAIN_IMAGE_WAIT_INFO,
                        timeout = xr.INFINITE_DURATION,
                }
                result = xr.WaitSwapchainImage(a.swapchains[v], &wait_info)
                assert(xr.succeeded(result))
                swapchain_image := a.swapchain_images[v][image_index]
                colour_tex := swapchain_image.image
                width := a.projection_layer_views[v].subImage.imageRect.extent.width
                height := a.projection_layer_views[v].subImage.imageRect.extent.height

                // View, View Projection
                inverse_view := model_from_pose(a.projection_layer_views[v].pose)
                view := inverse(inverse_view)
                proj := projection_from_fov_gl(a.projection_layer_views[v].fov, 0.01, 100.0)
                view_proj := proj * view

                // Left MVP
                left_mvp := view_proj * model_from_pose(a.hand_locations[0].pose)

                // Right Model
                right_mvp := view_proj * model_from_pose(a.hand_locations[1].pose)

                // Render into the swapchain directly
                gl.BindFramebuffer(gl.FRAMEBUFFER, a.framebuffer)
                gl.FramebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, colour_tex, 0)
                gl.FramebufferTexture2D(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.TEXTURE_2D, a.depth_targets[v], 0)
                gl.Viewport(0, 0, width, height)
                gl.ClearColor(0.4, 0.4, 0.8, 1)
                gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

                // Render Left Hand
                ltrig := a.trigger_click_states[0].currentState ? f32(1.0) : f32(0.0)
                gl.UseProgram(a.box_program)
                gl.UniformMatrix4fv(0, 1, gl.FALSE, &left_mvp[0, 0])
                gl.Uniform2f(1, a.trigger_states[0].currentState, ltrig)
                gl.DrawArrays(gl.TRIANGLES, 0, 36)

                // Render Right Hand
                rtrig := a.trigger_click_states[1].currentState ? f32(1.0) : f32(0.0)
                gl.UseProgram(a.box_program)
                gl.UniformMatrix4fv(0, 1, gl.FALSE, &right_mvp[0, 0])
                gl.Uniform2f(1, a.trigger_states[1].currentState, rtrig)
                gl.DrawArrays(gl.TRIANGLES, 0, 36)

                // Render Background
                gl.UseProgram(a.background_program)
                gl.UniformMatrix4fv(0, 1, gl.FALSE, &view_proj[0, 0])
                gl.Uniform3fv(1, 1, cast(^f32)&a.hand_locations[0].pose.position)
                gl.DrawArrays(gl.TRIANGLES, 0, 3)

                // Release Image
                release_info := xr.SwapchainImageReleaseInfo{ sType = .SWAPCHAIN_IMAGE_RELEASE_INFO }
                result = xr.ReleaseSwapchainImage(a.swapchains[v], &release_info)
                assert(xr.succeeded(result))
        }

        a.projection_layer.viewCount = a.view_submit_count
        a.projection_layer.views = &a.projection_layer_views[0]
}

// Submit the frame
app_update_end_frame :: proc(a: ^App) {
        layers := cast(^xr.CompositionLayerBaseHeader)&a.projection_layer
        frame_end := xr.FrameEndInfo{
                sType = .FRAME_END_INFO,
                displayTime = a.frame_state.predictedDisplayTime,
                environmentBlendMode = .OPAQUE,
                layerCount = a.should_render ? 1 : 0,
                layers = a.should_render ? &layers : nil,
        }

        result := xr.EndFrame(a.session, &frame_end)
        assert(xr.succeeded(result))
}

app_update :: proc(a: ^App) {
        app_update_pump_events(a)
        if !a.is_session_running { return }
        app_update_begin_frame_and_get_inputs(a)
        if a.should_render {
                app_update_render(a)
        }
        app_update_end_frame(a)
}

app_shutdown :: proc(a: ^App) {
        result: xr.Result

        c.printf("Shutting Down\n")

        // Clean up
        for i in 0 ..< a.view_count {
                result = xr.DestroySwapchain(a.swapchains[i])
                assert(xr.succeeded(result))
        }

	result = xr.DestroySpace(a.stage_space)
        assert(xr.succeeded(result))

        if a.is_session_running {
                result = xr.EndSession(a.session)
                assert(xr.succeeded(result))
        }

        result = xr.DestroySession(a.session)
        assert(xr.succeeded(result))

	result = xr.DestroyInstance(a.instance)
        assert(xr.succeeded(result))
}

// Entrypoint called by the OS when using native activity
@export android_main :: proc "c" (ga: ^glue.App) {
        context = runtime.default_context()
        a: App
        app_init(&a, ga)

        a.is_running = true
        for a.is_running {
                app_update(&a)
        }

        app_shutdown(&a)
}

BACKGROUND_VERT_SRC : cstring = `
#version 320 es
precision highp float;

layout(location = 0) uniform mat4 view_proj;

layout(location = 0) out vec3 world_pos;

void main() {
        const vec2 positions[3] = vec2[3](vec2(-1000,-1000), vec2(3000,-1000), vec2(-1000, 3000));
        vec2 pos = positions[gl_VertexID];
        world_pos = vec3(pos.x, 0.0, pos.y);
        gl_Position = view_proj * vec4(world_pos, 1.0);
}
`

BACKGROUND_FRAG_SRC : cstring = `
#version 320 es
precision highp float;

layout(location = 1) uniform vec3 cam_pos;

layout(location = 0) in vec3 world_pos;
layout(location = 0) out vec4 out_color;

#define TILE_SIZE 1.0
#define LINE_WIDTH 0.1

void main() {
        // Based on the work of Evan Wallace: https://madebyevan.com/shaders/grid/
        vec3 cam_to_point = world_pos - cam_pos;
        float dist_sq = max(0.000001, (dot(cam_to_point, cam_to_point)));
        float fog_alpha = 1.0 / exp(0.005 * dist_sq);
        vec2 coord = world_pos.xz;
        vec2 grid = abs(fract(coord - 0.5) - 0.5) / fwidth(coord);
        float line = min(grid.x, grid.y);
        float color = 1.0 - min(line, 1.0);
        color = mix(color, 0.4, 1.0 - fog_alpha);
        vec3 col = mix(vec3(0.0), vec3(1.0, 1.0, 2.0), color);
        out_color = vec4(col, 1.0);
}
`

BOX_VERT_SRC : cstring = `
#version 320 es
precision highp float;

layout(location = 0) uniform mat4 mvp;
layout(location = 1) uniform vec2 trigger_state;
layout(location = 0) out vec3 vc;

void main() {
        const vec3 cube_positions[8] = vec3[8](
                vec3(-0.1, -0.1, -0.1),
                vec3( 0.1, -0.1, -0.1),
                vec3( 0.1, -0.1,  0.1),
                vec3(-0.1, -0.1,  0.1),
                vec3(-0.1,  0.1, -0.1),
                vec3( 0.1,  0.1, -0.1),
                vec3( 0.1,  0.1,  0.1),
                vec3(-0.1,  0.1,  0.1)
        );

        const int cube_indices[36] = int[36](
                0, 2, 1, 0, 3, 2,
                4, 5, 6, 4, 6, 7,
                0, 1, 5, 0, 5, 4,
                3, 6, 2, 3, 7, 6,
                0, 4, 7, 0, 7, 3,
                1, 2, 6, 1, 6, 5
        );

        int index = clamp(gl_VertexID, 0, 35);
        int element = clamp(cube_indices[index], 0, 7);
        float t = -(cos(3.14159 * trigger_state.x) - 1.0) / 2.0; // Ease
        vec3 pos = vec3(mix(1.0, 1.2, t)) * cube_positions[element];

        gl_Position = vec4(mvp * vec4(pos, 1.0));
        vc = mix(vec3(0, 0, 1), vec3(1, 0, 0), trigger_state.x);
}
`

BOX_FRAG_SRC : cstring = `
#version 320 es
precision highp float;

layout(location = 0) in vec3 vc;
layout(location = 0) out vec4 outColor;

void main() {
        outColor = vec4(vc, 1.0);
}
`
