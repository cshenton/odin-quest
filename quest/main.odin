package quest

import "core:fmt"

import glue "./android/glue"

import egl "./egl"
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
        is_session_ready: bool,
        is_session_begin_ever: bool,

        // Frame Submission
        view_submit_count: u32,
        projection_layer: xr.CompositionLayerProjection,
        projection_layer_views: [MAX_VIEWS]xr.CompositionLayerProjection,
}

app_android_handle_cmd :: proc "c" (app: ^glue.App, cmd: glue.App_Cmd) {
        a := cast(^App)app.userData

        #partial switch cmd {
        case .Destroy: {
                // Handle application shutdown
                // ANativeActivity_finish(app->activity);
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
                // source: ^glue.Poll_Source
                // if ( ALooper_pollAll( 0, 0, &events, (void **)&source ) >= 0 ) {
                //         if (source != NULL) {
                //                 source->process(app, source)
                //         }
                // }
        }
        fmt.printf("Window Initialized\n")
}


// Initialise EGL resources and context, needed later to pass to OpenXR
app_init_gl :: proc(a: ^App) {
        // Display
        a.egl_display = egl.GetDisplay(egl.DEFAULT_DISPLAY)
        assert(a.egl_display != egl.NO_DISPLAY)
        egl_major, egl_minor: i32
        egl_init_success := egl.Initialize(a.egl_display, &egl_major, &egl_minor)
        assert(bool(egl_init_success))

        fmt.printf("EGL Version: \"%s\"\n", egl.QueryString(a.egl_display, egl.VERSION))
        fmt.printf("EGL Vendor: \"%s\"\n", egl.QueryString(a.egl_display, egl.VENDOR))
        fmt.printf("EGL Extensions: \"%s\"\n", egl.QueryString(a.egl_display, egl.EXTENSIONS))

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
        fmt.printf("Config: %d\n", num_config)

        // Context
        fmt.printf("Creating Context\n")
        context_attribute_list := [?]i32{
                egl.CONTEXT_CLIENT_VERSION, 2,
                egl.NONE,
        }
        a.egl_context = egl.CreateContext(a.egl_display, a.egl_config, egl.NO_CONTEXT, &context_attribute_list[0])
        assert(a.egl_context != egl.NO_CONTEXT)
        fmt.printf("Context Created %p\n", a.egl_context)

        // Surface
        assert(a.app.window != nil)
        // win_width := ANativeWindow_getWidth(a.app.window)
        // win_height := ANativeWindow_getHeight(a.app.window)
        // fmt.printf("Width/Height: %dx%d\n", win_width, win_height)
        window_attribute_list := [?]i32{ egl.NONE }
        a.egl_surface = egl.CreateWindowSurface(a.egl_display, a.egl_config, a.app.window, &window_attribute_list[0])
        fmt.printf("Got Surface: %p\n", a.egl_surface)
        assert(a.egl_surface != egl.NO_SURFACE)

        // Make Current
        egl_make_current_success := egl.MakeCurrent(a.egl_display, a.egl_surface, a.egl_surface, a.egl_context)
        assert(bool(egl_make_current_success))

        // Make some OpenGL calls
        // fmt.printf("GL Vendor: \"%s\"\n", glGetString(GL_VENDOR))
        // fmt.printf("GL Renderer: \"%s\"\n", glGetString(GL_RENDERER))
        // fmt.printf("GL Version: \"%s\"\n", glGetString(GL_VERSION))
        // fmt.printf("GL Extensions: \"%s\"\n", glGetString(GL_EXTENSIONS))
}



BACKGROUND_VERT_SRC := `
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

BACKGROUND_FRAG_SRC := `
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

BOX_VERT_SRC := `
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

BOX_FRAG_SRC := `
#version 320 es
precision highp float;

layout(location = 0) in vec3 vc;
layout(location = 0) out vec4 outColor;

void main() {
        outColor = vec4(vc, 1.0);
}
`
