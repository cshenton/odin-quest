package openxr

import "core:c"

StructureType :: enum c.int {
	UNKNOWN = 0,
	API_LAYER_PROPERTIES = 1,
	EXTENSION_PROPERTIES = 2,
	INSTANCE_CREATE_INFO = 3,
	SYSTEM_GET_INFO = 4,
	SYSTEM_PROPERTIES = 5,
	VIEW_LOCATE_INFO = 6,
	VIEW = 7,
	SESSION_CREATE_INFO = 8,
	SWAPCHAIN_CREATE_INFO = 9,
	SESSION_BEGIN_INFO = 10,
	VIEW_STATE = 11,
	FRAME_END_INFO = 12,
	HAPTIC_VIBRATION = 13,
	EVENT_DATA_BUFFER = 16,
	EVENT_DATA_INSTANCE_LOSS_PENDING = 17,
	EVENT_DATA_SESSION_STATE_CHANGED = 18,
	ACTION_STATE_BOOLEAN = 23,
	ACTION_STATE_FLOAT = 24,
	ACTION_STATE_VECTOR2F = 25,
	ACTION_STATE_POSE = 27,
	ACTION_SET_CREATE_INFO = 28,
	ACTION_CREATE_INFO = 29,
	INSTANCE_PROPERTIES = 32,
	FRAME_WAIT_INFO = 33,
	COMPOSITION_LAYER_PROJECTION = 35,
	COMPOSITION_LAYER_QUAD = 36,
	REFERENCE_SPACE_CREATE_INFO = 37,
	ACTION_SPACE_CREATE_INFO = 38,
	EVENT_DATA_REFERENCE_SPACE_CHANGE_PENDING = 40,
	VIEW_CONFIGURATION_VIEW = 41,
	SPACE_LOCATION = 42,
	SPACE_VELOCITY = 43,
	FRAME_STATE = 44,
	VIEW_CONFIGURATION_PROPERTIES = 45,
	FRAME_BEGIN_INFO = 46,
	COMPOSITION_LAYER_PROJECTION_VIEW = 48,
	EVENT_DATA_EVENTS_LOST = 49,
	INTERACTION_PROFILE_SUGGESTED_BINDING = 51,
	EVENT_DATA_INTERACTION_PROFILE_CHANGED = 52,
	INTERACTION_PROFILE_STATE = 53,
	SWAPCHAIN_IMAGE_ACQUIRE_INFO = 55,
	SWAPCHAIN_IMAGE_WAIT_INFO = 56,
	SWAPCHAIN_IMAGE_RELEASE_INFO = 57,
	ACTION_STATE_GET_INFO = 58,
	HAPTIC_ACTION_INFO = 59,
	SESSION_ACTION_SETS_ATTACH_INFO = 60,
	ACTIONS_SYNC_INFO = 61,
	BOUND_SOURCES_FOR_ACTION_ENUMERATE_INFO = 62,
	INPUT_SOURCE_LOCALIZED_NAME_GET_INFO = 63,
	COMPOSITION_LAYER_CUBE_KHR = 1000006000,
	INSTANCE_CREATE_INFO_ANDROID_KHR = 1000008000,
	COMPOSITION_LAYER_DEPTH_INFO_KHR = 1000010000,
	VULKAN_SWAPCHAIN_FORMAT_LIST_CREATE_INFO_KHR = 1000014000,
	EVENT_DATA_PERF_SETTINGS_EXT = 1000015000,
	COMPOSITION_LAYER_CYLINDER_KHR = 1000017000,
	COMPOSITION_LAYER_EQUIRECT_KHR = 1000018000,
	DEBUG_UTILS_OBJECT_NAME_INFO_EXT = 1000019000,
	DEBUG_UTILS_MESSENGER_CALLBACK_DATA_EXT = 1000019001,
	DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT = 1000019002,
	DEBUG_UTILS_LABEL_EXT = 1000019003,
	GRAPHICS_BINDING_OPENGL_WIN32_KHR = 1000023000,
	GRAPHICS_BINDING_OPENGL_XLIB_KHR = 1000023001,
	GRAPHICS_BINDING_OPENGL_XCB_KHR = 1000023002,
	GRAPHICS_BINDING_OPENGL_WAYLAND_KHR = 1000023003,
	SWAPCHAIN_IMAGE_OPENGL_KHR = 1000023004,
	GRAPHICS_REQUIREMENTS_OPENGL_KHR = 1000023005,
	GRAPHICS_BINDING_OPENGL_ES_ANDROID_KHR = 1000024001,
	SWAPCHAIN_IMAGE_OPENGL_ES_KHR = 1000024002,
	GRAPHICS_REQUIREMENTS_OPENGL_ES_KHR = 1000024003,
	GRAPHICS_BINDING_VULKAN_KHR = 1000025000,
	SWAPCHAIN_IMAGE_VULKAN_KHR = 1000025001,
	GRAPHICS_REQUIREMENTS_VULKAN_KHR = 1000025002,
	GRAPHICS_BINDING_D3D11_KHR = 1000027000,
	SWAPCHAIN_IMAGE_D3D11_KHR = 1000027001,
	GRAPHICS_REQUIREMENTS_D3D11_KHR = 1000027002,
	GRAPHICS_BINDING_D3D12_KHR = 1000028000,
	SWAPCHAIN_IMAGE_D3D12_KHR = 1000028001,
	GRAPHICS_REQUIREMENTS_D3D12_KHR = 1000028002,
	SYSTEM_EYE_GAZE_INTERACTION_PROPERTIES_EXT = 1000030000,
	EYE_GAZE_SAMPLE_TIME_EXT = 1000030001,
	VISIBILITY_MASK_KHR = 1000031000,
	EVENT_DATA_VISIBILITY_MASK_CHANGED_KHR = 1000031001,
	SESSION_CREATE_INFO_OVERLAY_EXTX = 1000033000,
	EVENT_DATA_MAIN_SESSION_VISIBILITY_CHANGED_EXTX = 1000033003,
	COMPOSITION_LAYER_COLOR_SCALE_BIAS_KHR = 1000034000,
	SPATIAL_ANCHOR_CREATE_INFO_MSFT = 1000039000,
	SPATIAL_ANCHOR_SPACE_CREATE_INFO_MSFT = 1000039001,
	COMPOSITION_LAYER_IMAGE_LAYOUT_FB = 1000040000,
	COMPOSITION_LAYER_ALPHA_BLEND_FB = 1000041001,
	VIEW_CONFIGURATION_DEPTH_RANGE_EXT = 1000046000,
	GRAPHICS_BINDING_EGL_MNDX = 1000048004,
	SPATIAL_GRAPH_NODE_SPACE_CREATE_INFO_MSFT = 1000049000,
	SPATIAL_GRAPH_STATIC_NODE_BINDING_CREATE_INFO_MSFT = 1000049001,
	SPATIAL_GRAPH_NODE_BINDING_PROPERTIES_GET_INFO_MSFT = 1000049002,
	SPATIAL_GRAPH_NODE_BINDING_PROPERTIES_MSFT = 1000049003,
	SYSTEM_HAND_TRACKING_PROPERTIES_EXT = 1000051000,
	HAND_TRACKER_CREATE_INFO_EXT = 1000051001,
	HAND_JOINTS_LOCATE_INFO_EXT = 1000051002,
	HAND_JOINT_LOCATIONS_EXT = 1000051003,
	HAND_JOINT_VELOCITIES_EXT = 1000051004,
	SYSTEM_HAND_TRACKING_MESH_PROPERTIES_MSFT = 1000052000,
	HAND_MESH_SPACE_CREATE_INFO_MSFT = 1000052001,
	HAND_MESH_UPDATE_INFO_MSFT = 1000052002,
	HAND_MESH_MSFT = 1000052003,
	HAND_POSE_TYPE_INFO_MSFT = 1000052004,
	SECONDARY_VIEW_CONFIGURATION_SESSION_BEGIN_INFO_MSFT = 1000053000,
	SECONDARY_VIEW_CONFIGURATION_STATE_MSFT = 1000053001,
	SECONDARY_VIEW_CONFIGURATION_FRAME_STATE_MSFT = 1000053002,
	SECONDARY_VIEW_CONFIGURATION_FRAME_END_INFO_MSFT = 1000053003,
	SECONDARY_VIEW_CONFIGURATION_LAYER_INFO_MSFT = 1000053004,
	SECONDARY_VIEW_CONFIGURATION_SWAPCHAIN_CREATE_INFO_MSFT = 1000053005,
	CONTROLLER_MODEL_KEY_STATE_MSFT = 1000055000,
	CONTROLLER_MODEL_NODE_PROPERTIES_MSFT = 1000055001,
	CONTROLLER_MODEL_PROPERTIES_MSFT = 1000055002,
	CONTROLLER_MODEL_NODE_STATE_MSFT = 1000055003,
	CONTROLLER_MODEL_STATE_MSFT = 1000055004,
	VIEW_CONFIGURATION_VIEW_FOV_EPIC = 1000059000,
	HOLOGRAPHIC_WINDOW_ATTACHMENT_MSFT = 1000063000,
	COMPOSITION_LAYER_REPROJECTION_INFO_MSFT = 1000066000,
	COMPOSITION_LAYER_REPROJECTION_PLANE_OVERRIDE_MSFT = 1000066001,
	ANDROID_SURFACE_SWAPCHAIN_CREATE_INFO_FB = 1000070000,
	COMPOSITION_LAYER_SECURE_CONTENT_FB = 1000072000,
	INTERACTION_PROFILE_DPAD_BINDING_EXT = 1000078000,
	INTERACTION_PROFILE_ANALOG_THRESHOLD_VALVE = 1000079000,
	HAND_JOINTS_MOTION_RANGE_INFO_EXT = 1000080000,
	LOADER_INIT_INFO_ANDROID_KHR = 1000089000,
	VULKAN_INSTANCE_CREATE_INFO_KHR = 1000090000,
	VULKAN_DEVICE_CREATE_INFO_KHR = 1000090001,
	VULKAN_GRAPHICS_DEVICE_GET_INFO_KHR = 1000090003,
	COMPOSITION_LAYER_EQUIRECT2_KHR = 1000091000,
	SCENE_OBSERVER_CREATE_INFO_MSFT = 1000097000,
	SCENE_CREATE_INFO_MSFT = 1000097001,
	NEW_SCENE_COMPUTE_INFO_MSFT = 1000097002,
	VISUAL_MESH_COMPUTE_LOD_INFO_MSFT = 1000097003,
	SCENE_COMPONENTS_MSFT = 1000097004,
	SCENE_COMPONENTS_GET_INFO_MSFT = 1000097005,
	SCENE_COMPONENT_LOCATIONS_MSFT = 1000097006,
	SCENE_COMPONENTS_LOCATE_INFO_MSFT = 1000097007,
	SCENE_OBJECTS_MSFT = 1000097008,
	SCENE_COMPONENT_PARENT_FILTER_INFO_MSFT = 1000097009,
	SCENE_OBJECT_TYPES_FILTER_INFO_MSFT = 1000097010,
	SCENE_PLANES_MSFT = 1000097011,
	SCENE_PLANE_ALIGNMENT_FILTER_INFO_MSFT = 1000097012,
	SCENE_MESHES_MSFT = 1000097013,
	SCENE_MESH_BUFFERS_GET_INFO_MSFT = 1000097014,
	SCENE_MESH_BUFFERS_MSFT = 1000097015,
	SCENE_MESH_VERTEX_BUFFER_MSFT = 1000097016,
	SCENE_MESH_INDICES_UINT32_MSFT = 1000097017,
	SCENE_MESH_INDICES_UINT16_MSFT = 1000097018,
	SERIALIZED_SCENE_FRAGMENT_DATA_GET_INFO_MSFT = 1000098000,
	SCENE_DESERIALIZE_INFO_MSFT = 1000098001,
	EVENT_DATA_DISPLAY_REFRESH_RATE_CHANGED_FB = 1000101000,
	VIVE_TRACKER_PATHS_HTCX = 1000103000,
	EVENT_DATA_VIVE_TRACKER_CONNECTED_HTCX = 1000103001,
	SYSTEM_FACIAL_TRACKING_PROPERTIES_HTC = 1000104000,
	FACIAL_TRACKER_CREATE_INFO_HTC = 1000104001,
	FACIAL_EXPRESSIONS_HTC = 1000104002,
	SYSTEM_COLOR_SPACE_PROPERTIES_FB = 1000108000,
	HAND_TRACKING_MESH_FB = 1000110001,
	HAND_TRACKING_SCALE_FB = 1000110003,
	HAND_TRACKING_AIM_STATE_FB = 1000111001,
	HAND_TRACKING_CAPSULES_STATE_FB = 1000112000,
	SYSTEM_SPATIAL_ENTITY_PROPERTIES_FB = 1000113004,
	SPATIAL_ANCHOR_CREATE_INFO_FB = 1000113003,
	SPACE_COMPONENT_STATUS_SET_INFO_FB = 1000113007,
	SPACE_COMPONENT_STATUS_FB = 1000113001,
	EVENT_DATA_SPATIAL_ANCHOR_CREATE_COMPLETE_FB = 1000113005,
	EVENT_DATA_SPACE_SET_STATUS_COMPLETE_FB = 1000113006,
	FOVEATION_PROFILE_CREATE_INFO_FB = 1000114000,
	SWAPCHAIN_CREATE_INFO_FOVEATION_FB = 1000114001,
	SWAPCHAIN_STATE_FOVEATION_FB = 1000114002,
	FOVEATION_LEVEL_PROFILE_CREATE_INFO_FB = 1000115000,
	KEYBOARD_SPACE_CREATE_INFO_FB = 1000116009,
	KEYBOARD_TRACKING_QUERY_FB = 1000116004,
	SYSTEM_KEYBOARD_TRACKING_PROPERTIES_FB = 1000116002,
	TRIANGLE_MESH_CREATE_INFO_FB = 1000117001,
	SYSTEM_PASSTHROUGH_PROPERTIES_FB = 1000118000,
	PASSTHROUGH_CREATE_INFO_FB = 1000118001,
	PASSTHROUGH_LAYER_CREATE_INFO_FB = 1000118002,
	COMPOSITION_LAYER_PASSTHROUGH_FB = 1000118003,
	GEOMETRY_INSTANCE_CREATE_INFO_FB = 1000118004,
	GEOMETRY_INSTANCE_TRANSFORM_FB = 1000118005,
	SYSTEM_PASSTHROUGH_PROPERTIES2_FB = 1000118006,
	PASSTHROUGH_STYLE_FB = 1000118020,
	PASSTHROUGH_COLOR_MAP_MONO_TO_RGBA_FB = 1000118021,
	PASSTHROUGH_COLOR_MAP_MONO_TO_MONO_FB = 1000118022,
	PASSTHROUGH_BRIGHTNESS_CONTRAST_SATURATION_FB = 1000118023,
	EVENT_DATA_PASSTHROUGH_STATE_CHANGED_FB = 1000118030,
	RENDER_MODEL_PATH_INFO_FB = 1000119000,
	RENDER_MODEL_PROPERTIES_FB = 1000119001,
	RENDER_MODEL_BUFFER_FB = 1000119002,
	RENDER_MODEL_LOAD_INFO_FB = 1000119003,
	SYSTEM_RENDER_MODEL_PROPERTIES_FB = 1000119004,
	RENDER_MODEL_CAPABILITIES_REQUEST_FB = 1000119005,
	BINDING_MODIFICATIONS_KHR = 1000120000,
	VIEW_LOCATE_FOVEATED_RENDERING_VARJO = 1000121000,
	FOVEATED_VIEW_CONFIGURATION_VIEW_VARJO = 1000121001,
	SYSTEM_FOVEATED_RENDERING_PROPERTIES_VARJO = 1000121002,
	COMPOSITION_LAYER_DEPTH_TEST_VARJO = 1000122000,
	SYSTEM_MARKER_TRACKING_PROPERTIES_VARJO = 1000124000,
	EVENT_DATA_MARKER_TRACKING_UPDATE_VARJO = 1000124001,
	MARKER_SPACE_CREATE_INFO_VARJO = 1000124002,
	SPATIAL_ANCHOR_PERSISTENCE_INFO_MSFT = 1000142000,
	SPATIAL_ANCHOR_FROM_PERSISTED_ANCHOR_CREATE_INFO_MSFT = 1000142001,
	SPACE_QUERY_INFO_FB = 1000156001,
	SPACE_QUERY_RESULTS_FB = 1000156002,
	SPACE_STORAGE_LOCATION_FILTER_INFO_FB = 1000156003,
	SPACE_UUID_FILTER_INFO_FB = 1000156054,
	SPACE_COMPONENT_FILTER_INFO_FB = 1000156052,
	EVENT_DATA_SPACE_QUERY_RESULTS_AVAILABLE_FB = 1000156103,
	EVENT_DATA_SPACE_QUERY_COMPLETE_FB = 1000156104,
	SPACE_SAVE_INFO_FB = 1000158000,
	SPACE_ERASE_INFO_FB = 1000158001,
	EVENT_DATA_SPACE_SAVE_COMPLETE_FB = 1000158106,
	EVENT_DATA_SPACE_ERASE_COMPLETE_FB = 1000158107,
	SWAPCHAIN_IMAGE_FOVEATION_VULKAN_FB = 1000160000,
	SWAPCHAIN_STATE_ANDROID_SURFACE_DIMENSIONS_FB = 1000161000,
	SWAPCHAIN_STATE_SAMPLER_OPENGL_ES_FB = 1000162000,
	SWAPCHAIN_STATE_SAMPLER_VULKAN_FB = 1000163000,
	COMPOSITION_LAYER_SPACE_WARP_INFO_FB = 1000171000,
	SYSTEM_SPACE_WARP_PROPERTIES_FB = 1000171001,
	SEMANTIC_LABELS_FB = 1000175000,
	ROOM_LAYOUT_FB = 1000175001,
	BOUNDARY_2D_FB = 1000175002,
	DIGITAL_LENS_CONTROL_ALMALENCE = 1000196000,
	SPACE_CONTAINER_FB = 1000199000,
	PASSTHROUGH_KEYBOARD_HANDS_INTENSITY_FB = 1000203002,
	COMPOSITION_LAYER_SETTINGS_FB = 1000204000,
	VULKAN_SWAPCHAIN_CREATE_INFO_META = 1000227000,
	PERFORMANCE_METRICS_STATE_META = 1000232001,
	PERFORMANCE_METRICS_COUNTER_META = 1000232002,
	SYSTEM_HEADSET_ID_PROPERTIES_META = 1000245000,
	PASSTHROUGH_CREATE_INFO_HTC = 1000317001,
	PASSTHROUGH_COLOR_HTC = 1000317002,
	PASSTHROUGH_MESH_TRANSFORM_INFO_HTC = 1000317003,
	COMPOSITION_LAYER_PASSTHROUGH_HTC = 1000317004,
	FOVEATION_APPLY_INFO_HTC = 1000318000,
	FOVEATION_DYNAMIC_MODE_INFO_HTC = 1000318001,
	FOVEATION_CUSTOM_MODE_INFO_HTC = 1000318002,
	ACTIVE_ACTION_SET_PRIORITIES_EXT = 1000373000,
}

Result :: enum c.int {
	SUCCESS = 0, // Function successfully completed.
	TIMEOUT_EXPIRED = 1, // The specified timeout time occurred before the operation could complete.
	SESSION_LOSS_PENDING = 3, // The session will be lost soon.
	EVENT_UNAVAILABLE = 4, // No event was available.
	SPACE_BOUNDS_UNAVAILABLE = 7, // The space's bounds are not known at the moment.
	SESSION_NOT_FOCUSED = 8, // The session is not in the focused state.
	FRAME_DISCARDED = 9, // A frame has been discarded from composition.
	ERROR_VALIDATION_FAILURE = -1, // The function usage was invalid in some way.
	ERROR_RUNTIME_FAILURE = -2, // The runtime failed to handle the function in an unexpected way that is not covered by another error result.
	ERROR_OUT_OF_MEMORY = -3, // A memory allocation has failed.
	ERROR_API_VERSION_UNSUPPORTED = -4, // The runtime does not support the requested API version.
	ERROR_INITIALIZATION_FAILED = -6, // Initialization of object could not be completed.
	ERROR_FUNCTION_UNSUPPORTED = -7, // The requested function was not found or is otherwise unsupported.
	ERROR_FEATURE_UNSUPPORTED = -8, // The requested feature is not supported.
	ERROR_EXTENSION_NOT_PRESENT = -9, // A requested extension is not supported.
	ERROR_LIMIT_REACHED = -10, // The runtime supports no more of the requested resource.
	ERROR_SIZE_INSUFFICIENT = -11, // The supplied size was smaller than required.
	ERROR_HANDLE_INVALID = -12, // A supplied object handle was invalid.
	ERROR_INSTANCE_LOST = -13, // The slink:XrInstance was lost or could not be found. It will need to be destroyed and optionally recreated.
	ERROR_SESSION_RUNNING = -14, // The session &lt;&lt;session_running, is already running&gt;&gt;.
	ERROR_SESSION_NOT_RUNNING = -16, // The session &lt;&lt;session_not_running, is not yet running&gt;&gt;.
	ERROR_SESSION_LOST = -17, // The slink:XrSession was lost. It will need to be destroyed and optionally recreated.
	ERROR_SYSTEM_INVALID = -18, // The provided basetype:XrSystemId was invalid.
	ERROR_PATH_INVALID = -19, // The provided basetype:XrPath was not valid.
	ERROR_PATH_COUNT_EXCEEDED = -20, // The maximum number of supported semantic paths has been reached.
	ERROR_PATH_FORMAT_INVALID = -21, // The semantic path character format is invalid.
	ERROR_PATH_UNSUPPORTED = -22, // The semantic path is unsupported.
	ERROR_LAYER_INVALID = -23, // The layer was NULL or otherwise invalid.
	ERROR_LAYER_LIMIT_EXCEEDED = -24, // The number of specified layers is greater than the supported number.
	ERROR_SWAPCHAIN_RECT_INVALID = -25, // The image rect was negatively sized or otherwise invalid.
	ERROR_SWAPCHAIN_FORMAT_UNSUPPORTED = -26, // The image format is not supported by the runtime or platform.
	ERROR_ACTION_TYPE_MISMATCH = -27, // The API used to retrieve an action's state does not match the action's type.
	ERROR_SESSION_NOT_READY = -28, // The session is not in the ready state.
	ERROR_SESSION_NOT_STOPPING = -29, // The session is not in the stopping state.
	ERROR_TIME_INVALID = -30, // The provided basetype:XrTime was zero, negative, or out of range.
	ERROR_REFERENCE_SPACE_UNSUPPORTED = -31, // The specified reference space is not supported by the runtime or system.
	ERROR_FILE_ACCESS_ERROR = -32, // The file could not be accessed.
	ERROR_FILE_CONTENTS_INVALID = -33, // The file's contents were invalid.
	ERROR_FORM_FACTOR_UNSUPPORTED = -34, // The specified form factor is not supported by the current runtime or platform.
	ERROR_FORM_FACTOR_UNAVAILABLE = -35, // The specified form factor is supported, but the device is currently not available, e.g. not plugged in or powered off.
	ERROR_API_LAYER_NOT_PRESENT = -36, // A requested API layer is not present or could not be loaded.
	ERROR_CALL_ORDER_INVALID = -37, // The call was made without having made a previously required call.
	ERROR_GRAPHICS_DEVICE_INVALID = -38, // The given graphics device is not in a valid state. The graphics device could be lost or initialized without meeting graphics requirements.
	ERROR_POSE_INVALID = -39, // The supplied pose was invalid with respect to the requirements.
	ERROR_INDEX_OUT_OF_RANGE = -40, // The supplied index was outside the range of valid indices.
	ERROR_VIEW_CONFIGURATION_TYPE_UNSUPPORTED = -41, // The specified view configuration type is not supported by the runtime or platform.
	ERROR_ENVIRONMENT_BLEND_MODE_UNSUPPORTED = -42, // The specified environment blend mode is not supported by the runtime or platform.
	ERROR_NAME_DUPLICATED = -44, // The name provided was a duplicate of an already-existing resource.
	ERROR_NAME_INVALID = -45, // The name provided was invalid.
	ERROR_ACTIONSET_NOT_ATTACHED = -46, // A referenced action set is not attached to the session.
	ERROR_ACTIONSETS_ALREADY_ATTACHED = -47, // The session already has attached action sets.
	ERROR_LOCALIZED_NAME_DUPLICATED = -48, // The localized name provided was a duplicate of an already-existing resource.
	ERROR_LOCALIZED_NAME_INVALID = -49, // The localized name provided was invalid.
	ERROR_GRAPHICS_REQUIREMENTS_CALL_MISSING = -50, // The fname:xrGetGraphicsRequirements* call was not made before calling fname:xrCreateSession.
	ERROR_RUNTIME_UNAVAILABLE = -51, // The loader was unable to find or load a runtime.
	ERROR_ANDROID_THREAD_SETTINGS_ID_INVALID_KHR = 1000003000,
	ERROR_ANDROID_THREAD_SETTINGS_FAILURE_KHR = 1000003001,
	ERROR_CREATE_SPATIAL_ANCHOR_FAILED_MSFT = 1000039001,
	ERROR_SECONDARY_VIEW_CONFIGURATION_TYPE_NOT_ENABLED_MSFT = 1000053000,
	ERROR_CONTROLLER_MODEL_KEY_INVALID_MSFT = 1000055000,
	ERROR_REPROJECTION_MODE_UNSUPPORTED_MSFT = 1000066000,
	ERROR_COMPUTE_NEW_SCENE_NOT_COMPLETED_MSFT = 1000097000,
	ERROR_SCENE_COMPONENT_ID_INVALID_MSFT = 1000097001,
	ERROR_SCENE_COMPONENT_TYPE_MISMATCH_MSFT = 1000097002,
	ERROR_SCENE_MESH_BUFFER_ID_INVALID_MSFT = 1000097003,
	ERROR_SCENE_COMPUTE_FEATURE_INCOMPATIBLE_MSFT = 1000097004,
	ERROR_SCENE_COMPUTE_CONSISTENCY_MISMATCH_MSFT = 1000097005,
	ERROR_DISPLAY_REFRESH_RATE_UNSUPPORTED_FB = 1000101000,
	ERROR_COLOR_SPACE_UNSUPPORTED_FB = 1000108000,
	ERROR_SPACE_COMPONENT_NOT_SUPPORTED_FB = 1000113000,
	ERROR_SPACE_COMPONENT_NOT_ENABLED_FB = 1000113001,
	ERROR_SPACE_COMPONENT_STATUS_PENDING_FB = 1000113002,
	ERROR_SPACE_COMPONENT_STATUS_ALREADY_SET_FB = 1000113003,
	ERROR_UNEXPECTED_STATE_PASSTHROUGH_FB = 1000118000,
	ERROR_FEATURE_ALREADY_CREATED_PASSTHROUGH_FB = 1000118001,
	ERROR_FEATURE_REQUIRED_PASSTHROUGH_FB = 1000118002,
	ERROR_NOT_PERMITTED_PASSTHROUGH_FB = 1000118003,
	ERROR_INSUFFICIENT_RESOURCES_PASSTHROUGH_FB = 1000118004,
	ERROR_UNKNOWN_PASSTHROUGH_FB = 1000118050,
	ERROR_RENDER_MODEL_KEY_INVALID_FB = 1000119000,
	RENDER_MODEL_UNAVAILABLE_FB = 1000119020,
	ERROR_MARKER_NOT_TRACKED_VARJO = 1000124000,
	ERROR_MARKER_ID_INVALID_VARJO = 1000124001,
	ERROR_SPATIAL_ANCHOR_NAME_NOT_FOUND_MSFT = 1000142001,
	ERROR_SPATIAL_ANCHOR_NAME_INVALID_MSFT = 1000142002,
}

ObjectType :: enum c.int {
	UNKNOWN = 0,
	INSTANCE = 1, // XrInstance
	SESSION = 2, // XrSession
	SWAPCHAIN = 3, // XrSwapchain
	SPACE = 4, // XrSpace
	ACTION_SET = 5, // XrActionSet
	ACTION = 6, // XrAction
	DEBUG_UTILS_MESSENGER_EXT = 1000019000,
	SPATIAL_ANCHOR_MSFT = 1000039000,
	SPATIAL_GRAPH_NODE_BINDING_MSFT = 1000049000,
	HAND_TRACKER_EXT = 1000051000,
	SCENE_OBSERVER_MSFT = 1000097000,
	SCENE_MSFT = 1000097001,
	FACIAL_TRACKER_HTC = 1000104000,
	FOVEATION_PROFILE_FB = 1000114000,
	TRIANGLE_MESH_FB = 1000117000,
	PASSTHROUGH_FB = 1000118000,
	PASSTHROUGH_LAYER_FB = 1000118002,
	GEOMETRY_INSTANCE_FB = 1000118004,
	SPATIAL_ANCHOR_STORE_CONNECTION_MSFT = 1000142000,
	PASSTHROUGH_HTC = 1000317000,
}

AndroidThreadTypeKHR :: enum c.int {
	APPLICATION_MAIN = 1,
	APPLICATION_WORKER = 2,
	RENDERER_MAIN = 3,
	RENDERER_WORKER = 4,
}

EyeVisibility :: enum c.int {
	BOTH = 0, // Display in both eyes.
	LEFT = 1, // Display in the left eye only.
	RIGHT = 2, // Display in the right eye only.
}

ActionType :: enum c.int {
	BOOLEAN_INPUT = 1,
	FLOAT_INPUT = 2,
	VECTOR2F_INPUT = 3,
	POSE_INPUT = 4,
	VIBRATION_OUTPUT = 100,
}

ReferenceSpaceType :: enum c.int {
	VIEW = 1,
	LOCAL = 2,
	STAGE = 3,
	UNBOUNDED_MSFT = 1000038000,
	COMBINED_EYE_VARJO = 1000121000,
}

FormFactor :: enum c.int {
	HEAD_MOUNTED_DISPLAY = 1,
	HANDHELD_DISPLAY = 2,
}

ViewConfigurationType :: enum c.int {
	PRIMARY_MONO = 1,
	PRIMARY_STEREO = 2,
	PRIMARY_QUAD_VARJO = 1000037000,
	SECONDARY_MONO_FIRST_PERSON_OBSERVER_MSFT = 1000054000,
}

EnvironmentBlendMode :: enum c.int {
	OPAQUE = 1,
	ADDITIVE = 2,
	ALPHA_BLEND = 3,
}

SessionState :: enum c.int {
	UNKNOWN = 0,
	IDLE = 1,
	READY = 2,
	SYNCHRONIZED = 3,
	VISIBLE = 4,
	FOCUSED = 5,
	STOPPING = 6,
	LOSS_PENDING = 7,
	EXITING = 8,
}

PerfSettingsLevelEXT :: enum c.int {
	POWER_SAVINGS = 0, // Performance settings hint used by the application to indicate that it enters a non-XR section (head-locked / static screen), during which power savings are to be prioritized
	SUSTAINED_LOW = 25, // Performance settings hint used by the application to indicate that it enters a low and stable complexity section, during which reducing power is more important than occasional late rendering frames
	SUSTAINED_HIGH = 50, // Performance settings hint used by the application to indicate that it enters a high or dynamic complexity section, during which the XR Runtime strives for consistent XR compositing and frame rendering within a thermally sustainable range
	BOOST = 75, // Performance settings hint used by the application to indicate that the application enters a section with very high complexity, during which the XR Runtime is allowed to step up beyond the thermally sustainable range
}

PerfSettingsDomainEXT :: enum c.int {
	CPU = 1, // Indicates that the performance settings or notification applies to CPU domain
	GPU = 2, // Indicates that the performance settings or notification applies to GPU domain
}

PerfSettingsSubDomainEXT :: enum c.int {
	COMPOSITING = 1, // Indicates that the performance notification originates from the COMPOSITING sub-domain
	RENDERING = 2, // Indicates that the performance notification originates from the RENDERING sub-domain
	THERMAL = 3, // Indicates that the performance notification originates from the THERMAL sub-domain
}

PerfSettingsNotificationLevelEXT :: enum c.int {
	NORMAL = 0, // Notifies that the sub-domain has reached a level where no further actions other than currently applied are necessary
	WARNING = 25, // Notifies that the sub-domain has reached an early warning level where the application should start proactive mitigation actions with the goal to return to the ename:XR_PERF_NOTIF_LEVEL_NORMAL level
	IMPAIRED = 75, // Notifies that the sub-domain has reached a critical level with significant performance degradation. The application should take drastic mitigation action
}

VisibilityMaskTypeKHR :: enum c.int {
	HIDDEN_TRIANGLE_MESH = 1, // exclusive mesh; indicates that which the viewer cannot see.
	VISIBLE_TRIANGLE_MESH = 2, // inclusive mesh; indicates strictly that which the viewer can see.
	LINE_LOOP = 3, // line loop; traces the outline of the area the viewer can see.
}

HandEXT :: enum c.int {
	LEFT = 1,
	RIGHT = 2,
}

HandJointEXT :: enum c.int {
	PALM = 0,
	WRIST = 1,
	THUMB_METACARPAL = 2,
	THUMB_PROXIMAL = 3,
	THUMB_DISTAL = 4,
	THUMB_TIP = 5,
	INDEX_METACARPAL = 6,
	INDEX_PROXIMAL = 7,
	INDEX_INTERMEDIATE = 8,
	INDEX_DISTAL = 9,
	INDEX_TIP = 10,
	MIDDLE_METACARPAL = 11,
	MIDDLE_PROXIMAL = 12,
	MIDDLE_INTERMEDIATE = 13,
	MIDDLE_DISTAL = 14,
	MIDDLE_TIP = 15,
	RING_METACARPAL = 16,
	RING_PROXIMAL = 17,
	RING_INTERMEDIATE = 18,
	RING_DISTAL = 19,
	RING_TIP = 20,
	LITTLE_METACARPAL = 21,
	LITTLE_PROXIMAL = 22,
	LITTLE_INTERMEDIATE = 23,
	LITTLE_DISTAL = 24,
	LITTLE_TIP = 25,
}

HandJointSetEXT :: enum c.int {
	DEFAULT = 0,
	HAND_WITH_FOREARM_ULTRALEAP = 1000149000,
}

HandJointsMotionRangeEXT :: enum c.int {
	UNOBSTRUCTED = 1,
	CONFORMING_TO_CONTROLLER = 2,
}

HandPoseTypeMSFT :: enum c.int {
	TRACKED = 0,
	REFERENCE_OPEN_PALM = 1,
}

ColorSpaceFB :: enum c.int {
	UNMANAGED = 0,
	REC2020 = 1,
	REC709 = 2,
	RIFT_CV1 = 3,
	RIFT_S = 4,
	QUEST = 5,
	P3 = 6,
	ADOBE_RGB = 7,
}

BlendFactorFB :: enum c.int {
	ZERO = 0,
	ONE = 1,
	SRC_ALPHA = 2,
	ONE_MINUS_SRC_ALPHA = 3,
	DST_ALPHA = 4,
	ONE_MINUS_DST_ALPHA = 5,
}

ReprojectionModeMSFT :: enum c.int {
	DEPTH = 1,
	PLANAR_FROM_DEPTH = 2,
	PLANAR_MANUAL = 3,
	ORIENTATION_ONLY = 4,
}

HandForearmJointULTRALEAP :: enum c.int {
	PALM = 0,
	WRIST = 1,
	THUMB_METACARPAL = 2,
	THUMB_PROXIMAL = 3,
	THUMB_DISTAL = 4,
	THUMB_TIP = 5,
	INDEX_METACARPAL = 6,
	INDEX_PROXIMAL = 7,
	INDEX_INTERMEDIATE = 8,
	INDEX_DISTAL = 9,
	INDEX_TIP = 10,
	MIDDLE_METACARPAL = 11,
	MIDDLE_PROXIMAL = 12,
	MIDDLE_INTERMEDIATE = 13,
	MIDDLE_DISTAL = 14,
	MIDDLE_TIP = 15,
	RING_METACARPAL = 16,
	RING_PROXIMAL = 17,
	RING_INTERMEDIATE = 18,
	RING_DISTAL = 19,
	RING_TIP = 20,
	LITTLE_METACARPAL = 21,
	LITTLE_PROXIMAL = 22,
	LITTLE_INTERMEDIATE = 23,
	LITTLE_DISTAL = 24,
	LITTLE_TIP = 25,
	ELBOW = 26,
}

InstanceCreateFlag :: enum Flags64 {
}

SessionCreateFlag :: enum Flags64 {
}

SwapchainCreateFlag :: enum Flags64 {
	PROTECTED_CONTENT = 0, // Content will be protected from CPU access
	STATIC_IMAGE = 1, // Only one image will be acquired from this swapchain over its lifetime
}

SwapchainUsageFlag :: enum Flags64 {
	COLOR_ATTACHMENT = 0, // Specifies that the image may: be a color rendering target.
	DEPTH_STENCIL_ATTACHMENT = 1, // Specifies that the image may: be a depth/stencil rendering target.
	UNORDERED_ACCESS = 2, // Specifies that the image may: be accessed out of order and that access may: be via atomic operations.
	TRANSFER_SRC = 3, // Specifies that the image may: be used as the source of a transfer operation.
	TRANSFER_DST = 4, // Specifies that the image may: be used as the destination of a transfer operation.
	SAMPLED = 5, // Specifies that the image may: be sampled by a shader.
	MUTABLE_FORMAT = 6, // Specifies that the image may: be reinterpreted as another image format.
	INPUT_ATTACHMENT_MND = 7,
}

ViewStateFlag :: enum Flags64 {
	ORIENTATION_VALID = 0, // Indicates validity of all slink:XrView orientations
	POSITION_VALID = 1, // Indicates validity of all slink:XrView positions
	ORIENTATION_TRACKED = 2, // Indicates whether all slink:XrView orientations are actively tracked
	POSITION_TRACKED = 3, // Indicates whether all slink:XrView positions are actively tracked
}

CompositionLayerFlag :: enum Flags64 {
	CORRECT_CHROMATIC_ABERRATION = 0, // Enables chromatic aberration correction when not done by default. This flag has no effect on any known conformant runtime, and is planned for deprecation for OpenXR 1.1
	BLEND_TEXTURE_SOURCE_ALPHA = 1, // Enables the layer texture alpha channel.
	UNPREMULTIPLIED_ALPHA = 2, // Indicates the texture color channels have not been premultiplied by the texture alpha channel.
}

SpaceLocationFlag :: enum Flags64 {
	ORIENTATION_VALID = 0, // Indicates that the pname:orientation member contains valid data
	POSITION_VALID = 1, // Indicates that the pname:position member contains valid data
	ORIENTATION_TRACKED = 2, // Indicates whether pname:pose member contains an actively tracked pname:orientation
	POSITION_TRACKED = 3, // Indicates whether pname:pose member contains an actively tracked pname:position
}

SpaceVelocityFlag :: enum Flags64 {
	LINEAR_VALID = 0, // Indicates that the pname:linearVelocity member contains valid data. Applications must: not read the pname:linearVelocity field if this flag is unset.
	ANGULAR_VALID = 1, // Indicates that the pname:angularVelocity member contains valid data. Applications must: not read the pname:angularVelocity field if this flag is unset.
}

InputSourceLocalizedNameFlag :: enum Flags64 {
	USER_PATH = 0, // Asks for the part of the string which indicates the top level user path the source represents
	INTERACTION_PROFILE = 1, // Asks for the part of the string which represents the interaction profile of the source
	COMPONENT = 2, // Asks for the part of the string which represents the component on the device which needs to be interacted with
}

VulkanInstanceCreateFlagKHR :: enum Flags64 {
}

VulkanDeviceCreateFlagKHR :: enum Flags64 {
}

DebugUtilsMessageSeverityFlagEXT :: enum Flags64 {
	VERBOSE = 0, // Most verbose output severity, typically used for debugging.
	INFO = 4, // General info message
	WARNING = 8, // Indicates the item may be the cause of issues.
	ERROR = 12, // Indicates that the item is definitely related to erroneous behavior.
}

DebugUtilsMessageTypeFlagEXT :: enum Flags64 {
	GENERAL = 0, // Indicates this is a general message
	VALIDATION = 1, // Indicates the message is related to a validation message
	PERFORMANCE = 2, // Indicates the message is related to a potential performance situation
	CONFORMANCE = 3, // Indicates the message is related to a non-conformant runtime result
}

OverlayMainSessionFlagEXTX :: enum Flags64 {
	ENABLED_COMPOSITION_LAYER_INFO_DEPTH = 0, // Indicates the main session enabled `XR_KHR_composition_layer_depth`
}

OverlaySessionCreateFlagEXTX :: enum Flags64 {
}

SpatialGraphNodeTypeMSFT :: enum c.int {
	STATIC = 1,
	DYNAMIC = 2,
}

SceneObjectTypeMSFT :: enum c.int {
	UNCATEGORIZED = -1,
	BACKGROUND = 1,
	WALL = 2,
	FLOOR = 3,
	CEILING = 4,
	PLATFORM = 5,
	INFERRED = 6,
}

ScenePlaneAlignmentTypeMSFT :: enum c.int {
	NON_ORTHOGONAL = 0,
	HORIZONTAL = 1,
	VERTICAL = 2,
}

SceneComputeStateMSFT :: enum c.int {
	NONE = 0,
	UPDATING = 1,
	COMPLETED = 2,
	COMPLETED_WITH_ERROR = 3,
}

SceneComponentTypeMSFT :: enum c.int {
	INVALID = -1,
	OBJECT = 1,
	PLANE = 2,
	VISUAL_MESH = 3,
	COLLIDER_MESH = 4,
	SERIALIZED_SCENE_FRAGMENT = 1000098000,
}

SceneComputeFeatureMSFT :: enum c.int {
	PLANE = 1,
	PLANE_MESH = 2,
	VISUAL_MESH = 3,
	COLLIDER_MESH = 4,
	SERIALIZE_SCENE = 1000098000,
}

SceneComputeConsistencyMSFT :: enum c.int {
	SNAPSHOT_COMPLETE = 1,
	SNAPSHOT_INCOMPLETE_FAST = 2,
	OCCLUSION_OPTIMIZED = 3,
}

MeshComputeLodMSFT :: enum c.int {
	COARSE = 1,
	MEDIUM = 2,
	FINE = 3,
	UNLIMITED = 4,
}

AndroidSurfaceSwapchainFlagFB :: enum Flags64 {
	SYNCHRONOUS = 0, // Create the underlying BufferQueue in synchronous mode
	USE_TIMESTAMPS = 1, // Acquire most recent buffer whose presentation timestamp is not greater than display time of final composited frame
}

CompositionLayerImageLayoutFlagFB :: enum Flags64 {
	VERTICAL_FLIP = 0, // The coordinate origin of the swapchain image must be considered to be flipped vertically.
}

SwapchainCreateFoveationFlagFB :: enum Flags64 {
	SCALED_BIN = 0, // Explicitly create the swapchain with scaled bin foveation support. The application must ensure that the swapchain is using the OpenGL graphics API and that the QCOM_texture_foveated extension is supported and enabled.
	FRAGMENT_DENSITY_MAP = 1, // Explicitly create the swapchain with fragment density map foveation support. The application must ensure that the swapchain is using the Vulkan graphics API and that the VK_EXT_fragment_density_map extension is supported and enabled.
}

SwapchainStateFoveationFlagFB :: enum Flags64 {
}

CompositionLayerSecureContentFlagFB :: enum Flags64 {
	EXCLUDE_LAYER = 0, // Indicates the layer will only be visible inside the HMD, and not visible to external sources
	REPLACE_LAYER = 1, // Indicates the layer will be displayed inside the HMD, but replaced by proxy content when written to external sources
}

SpaceComponentTypeFB :: enum c.int {
	LOCATABLE = 0, // Enables tracking the 6 DOF pose of the slink:XrSpace with flink:xrLocateSpace.
	STORABLE = 1, // Enables persistence operations: save and erase.
	BOUNDED_2D = 3, // Bounded 2D component.
	BOUNDED_3D = 4, // Bounded 3D component.
	SEMANTIC_LABELS = 5, // Semantic labels component.
	ROOM_LAYOUT = 6, // Room layout component.
	SPACE_CONTAINER = 7, // Space container component.
}

FoveationLevelFB :: enum c.int {
	NONE = 0, // No foveation
	LOW = 1, // Less foveation (higher periphery visual fidelity, lower performance)
	MEDIUM = 2, // Medium foveation (medium periphery visual fidelity, medium performance)
	HIGH = 3, // High foveation (lower periphery visual fidelity, higher performance)
}

FoveationDynamicFB :: enum c.int {
	DISABLED = 0, // Static foveation at the maximum desired level
	LEVEL_ENABLED = 1, // Dynamic changing foveation based on performance headroom available up to the maximum desired level
}

WindingOrderFB :: enum c.int {
	UNKNOWN = 0, // Winding order is unknown and the runtime cannot make any assumptions on the triangle orientation
	CW = 1, // Clockwise winding order
	CCW = 2, // Counter-clockwise winding order
}

TriangleMeshFlagFB :: enum Flags64 {
	MUTABLE = 0, // The triangle mesh is mutable (can be modified after it is created).
}

PassthroughLayerPurposeFB :: enum c.int {
	RECONSTRUCTION = 0, // Reconstruction passthrough (full screen environment)
	PROJECTED = 1, // Projected passthrough (using a custom surface)
	TRACKED_KEYBOARD_HANDS = 1000203001,
	TRACKED_KEYBOARD_MASKED_HANDS = 1000203002,
}

PassthroughFlagFB :: enum Flags64 {
	IS_RUNNING_AT_CREATION = 0, // The object (passthrough, layer) is running at creation.
	LAYER_DEPTH = 1, // The passthrough system sends depth information to the compositor. Only applicable to layer objects.
}

PassthroughStateChangedFlagFB :: enum Flags64 {
	REINIT_REQUIRED = 0, // Passthrough system requires reinitialization.
	NON_RECOVERABLE_ERROR = 1, // Non-recoverable error has occurred. A device reboot or a firmware update may be required.
	RECOVERABLE_ERROR = 2, // A recoverable error has occurred. The runtime will attempt to recover, but some functionality may be temporarily unavailable.
	RESTORED_ERROR = 3, // The runtime has recovered from a previous error and is functioning normally.
}

PassthroughCapabilityFlagFB :: enum Flags64 {
	XR_PASSTHROUGH_CAPABILITY = 0, // The system supports passthrough.
	COLOR = 1, // The system can show passthrough with realistic colors. ename:XR_PASSTHROUGH_CAPABILITY_BIT_FB must: be set if ename:XR_PASSTHROUGH_CAPABILITY_COLOR_BIT_FB is set.
	LAYER_DEPTH = 2, // The system supports passthrough layers composited using depth testing. ename:XR_PASSTHROUGH_CAPABILITY_BIT_FB must: be set if ename:XR_PASSTHROUGH_CAPABILITY_LAYER_DEPTH_BIT_FB is set.
}

SpaceQueryActionFB :: enum c.int {
	LOAD = 0, // Tells the query to perform a load operation on any slink:XrSpace returned by the query.
}

SpaceStorageLocationFB :: enum c.int {
	INVALID = 0, // Invalid storage location
	LOCAL = 1, // Local device storage
}

SpacePersistenceModeFB :: enum c.int {
	INVALID = 0, // Invalid storage persistence
	INDEFINITE = 1, // Store slink:XrSpace indefinitely, or until erased
}

HandTrackingAimFlagFB :: enum Flags64 {
	COMPUTED = 0, // Aiming data is computed from additional sources beyond the hand data in the base structure
	VALID = 1, // Aiming data is valid
	INDEX_PINCHING = 2, // Index finger pinch discrete signal
	MIDDLE_PINCHING = 3, // Middle finger pinch discrete signal
	RING_PINCHING = 4, // Ring finger pinch discrete signal
	LITTLE_PINCHING = 5, // Little finger pinch discrete signal
	SYSTEM_GESTURE = 6, // System gesture is active
	DOMINANT_HAND = 7, // Hand is currently marked as dominant for the system
	MENU_PRESSED = 8, // System menu gesture is active
}

KeyboardTrackingFlagFB :: enum Flags64 {
	EXISTS = 0, // indicates that the system has a physically tracked keyboard to report.  If not set then no other bits should be considered to be valid or meaningful.  If set either XR_KEYBOARD_TRACKING_LOCAL_BIT_FB or XR_KEYBOARD_TRACKING_REMOTE_BIT_FB must also be set.
	LOCAL = 1, // indicates that the physically tracked keyboard is intended to be used in a local pairing with the system.  Mutally exclusive with XR_KEYBOARD_TRACKING_REMOTE_BIT_FB.
	REMOTE = 2, // indicates that the physically tracked keyboard is intended to be used while paired to a separate remote computing device. Mutally exclusive with XR_KEYBOARD_TRACKING_LOCAL_BIT_FB.
	CONNECTED = 3, // indicates that the physically tracked keyboard is actively connected to the headset and capable of sending key data
}

KeyboardTrackingQueryFlagFB :: enum Flags64 {
	LOCAL = 1, // indicates the query is for the physically tracked keyboard that is intended to be used in a local pairing with the System. Mutally exclusive with XR_KEYBOARD_TRACKING_QUERY_REMOTE_BIT_FB.
	REMOTE = 2, // indicates the query is for the physically tracked keyboard that may be connected to a separate remote computing device. Mutally exclusive with XR_KEYBOARD_TRACKING_QUERY_LOCAL_BIT_FB.
}

CompositionLayerSpaceWarpInfoFlagFB :: enum Flags64 {
	FRAME_SKIP = 0, // Skip current frame's space warp extrapolation
}

RenderModelFlagFB :: enum Flags64 {
	SUPPORTS_GLTF_2_0_SUBSET_1 = 0, // Minimal level of support.  Can only contain a single mesh.  Can only contain a single texture.  Can not contain transparency.  Assumes unlit rendering.  Requires Extension KHR_texturebasisu.
	SUPPORTS_GLTF_2_0_SUBSET_2 = 1, // All of XR_RENDER_MODEL_SUPPORTS_GLTF_2_0_SUBSET_1_BIT_FB support plus: Multiple meshes. Multiple Textures. Texture Transparency.
}

FacialTrackingTypeHTC :: enum c.int {
	EYE_DEFAULT = 1, // Specifies this handle will observe eye expressions, with values indexed by elink:XrEyeExpressionHTC whose count is dlink:XR_FACIAL_EXPRESSION_EYE_COUNT_HTC.
	LIP_DEFAULT = 2, // Specifies this handle will observe lip expressions, with values indexed by elink:XrLipExpressionHTC whose count is dlink:XR_FACIAL_EXPRESSION_LIP_COUNT_HTC.
}

PassthroughFormHTC :: enum c.int {
	PLANAR = 0, // Presents the passthrough with full of the entire screen.
	PROJECTED = 1, // Presents the passthrough projecting onto a custom mesh.
}

EyeExpressionHTC :: enum c.int {
	LEFT_BLINK = 0,
	LEFT_WIDE = 1,
	RIGHT_BLINK = 2,
	RIGHT_WIDE = 3,
	LEFT_SQUEEZE = 4,
	RIGHT_SQUEEZE = 5,
	LEFT_DOWN = 6,
	RIGHT_DOWN = 7,
	LEFT_OUT = 8,
	RIGHT_IN = 9,
	LEFT_IN = 10,
	RIGHT_OUT = 11,
	LEFT_UP = 12,
	RIGHT_UP = 13,
}

LipExpressionHTC :: enum c.int {
	JAW_RIGHT = 0,
	JAW_LEFT = 1,
	JAW_FORWARD = 2,
	JAW_OPEN = 3,
	MOUTH_APE_SHAPE = 4,
	MOUTH_UPPER_RIGHT = 5,
	MOUTH_UPPER_LEFT = 6,
	MOUTH_LOWER_RIGHT = 7,
	MOUTH_LOWER_LEFT = 8,
	MOUTH_UPPER_OVERTURN = 9,
	MOUTH_LOWER_OVERTURN = 10,
	MOUTH_POUT = 11,
	MOUTH_SMILE_RIGHT = 12,
	MOUTH_SMILE_LEFT = 13,
	MOUTH_SAD_RIGHT = 14,
	MOUTH_SAD_LEFT = 15,
	CHEEK_PUFF_RIGHT = 16,
	CHEEK_PUFF_LEFT = 17,
	CHEEK_SUCK = 18,
	MOUTH_UPPER_UPRIGHT = 19,
	MOUTH_UPPER_UPLEFT = 20,
	MOUTH_LOWER_DOWNRIGHT = 21,
	MOUTH_LOWER_DOWNLEFT = 22,
	MOUTH_UPPER_INSIDE = 23,
	MOUTH_LOWER_INSIDE = 24,
	MOUTH_LOWER_OVERLAY = 25,
	TONGUE_LONGSTEP1 = 26,
	TONGUE_LEFT = 27,
	TONGUE_RIGHT = 28,
	TONGUE_UP = 29,
	TONGUE_DOWN = 30,
	TONGUE_ROLL = 31,
	TONGUE_LONGSTEP2 = 32,
	TONGUE_UPRIGHT_MORPH = 33,
	TONGUE_UPLEFT_MORPH = 34,
	TONGUE_DOWNRIGHT_MORPH = 35,
	TONGUE_DOWNLEFT_MORPH = 36,
}

DigitalLensControlFlagALMALENCE :: enum Flags64 {
	PROCESSING_DISABLE = 0, // disables Digital Lens processing of render textures
}

CompositionLayerSettingsFlagFB :: enum Flags64 {
	NORMAL_SUPER_SAMPLING = 0, // Indicates compositor may: use layer texture supersampling.
	QUALITY_SUPER_SAMPLING = 1, // Indicates compositor may: use high quality layer texture supersampling.
	NORMAL_SHARPENING = 2, // Indicates compositor may: use layer texture sharpening.
	QUALITY_SHARPENING = 3, // Indicates compositor may: use high quality layer texture sharpening.
}

PerformanceMetricsCounterFlagMETA :: enum Flags64 {
	ANY_VALUE_VALID = 0, // Indicates any of the values in XrPerformanceMetricsCounterMETA is valid.
	UINT_VALUE_VALID = 1, // Indicates the uintValue in XrPerformanceMetricsCounterMETA is valid.
	FLOAT_VALUE_VALID = 2, // Indicates the floatValue in XrPerformanceMetricsCounterMETA is valid.
}

PerformanceMetricsCounterUnitMETA :: enum c.int {
	GENERIC = 0, // the performance counter unit is generic (unspecified).
	PERCENTAGE = 1, // the performance counter unit is percentage (%).
	MILLISECONDS = 2, // the performance counter unit is millisecond.
	BYTES = 3, // the performance counter unit is byte.
	HERTZ = 4, // the performance counter unit is hertz (Hz).
}

FoveationModeHTC :: enum c.int {
	DISABLE = 0, // No foveation
	FIXED = 1, // Apply system default setting with fixed clear FOV and periphery quality.
	DYNAMIC = 2, // Allow system to set foveation dynamically according realtime system metric or other extensions.
	CUSTOM = 3, // Allow application to set foveation with desired clear FOV, periphery quality, and focal center offset.
}

FoveationDynamicFlagHTC :: enum Flags64 {
	LEVEL_ENABLED = 0, // Allow system to set periphery pixel density dynamically.
	CLEAR_FOV_ENABLED = 1, // Allow system to set clear FOV degree dynamically.
	FOCAL_CENTER_OFFSET_ENABLED = 2, // Allow system to set focal center offset dynamically.
}

FoveationLevelHTC :: enum c.int {
	NONE = 0, // No foveation
	LOW = 1, // Light periphery pixel density drop and lower performance gain.
	MEDIUM = 2, // Medium periphery pixel density drop and medium performance gain
	HIGH = 3, // Heavy periphery pixel density drop and higher performance gain
}

InstanceCreateFlags :: distinct bit_set[InstanceCreateFlag; Flags64]
SessionCreateFlags :: distinct bit_set[SessionCreateFlag; Flags64]
SwapchainCreateFlags :: distinct bit_set[SwapchainCreateFlag; Flags64]
SwapchainUsageFlags :: distinct bit_set[SwapchainUsageFlag; Flags64]
ViewStateFlags :: distinct bit_set[ViewStateFlag; Flags64]
CompositionLayerFlags :: distinct bit_set[CompositionLayerFlag; Flags64]
SpaceLocationFlags :: distinct bit_set[SpaceLocationFlag; Flags64]
SpaceVelocityFlags :: distinct bit_set[SpaceVelocityFlag; Flags64]
InputSourceLocalizedNameFlags :: distinct bit_set[InputSourceLocalizedNameFlag; Flags64]
VulkanInstanceCreateFlagsKHR :: distinct bit_set[VulkanInstanceCreateFlagKHR; Flags64]
VulkanDeviceCreateFlagsKHR :: distinct bit_set[VulkanDeviceCreateFlagKHR; Flags64]
DebugUtilsMessageSeverityFlagsEXT :: distinct bit_set[DebugUtilsMessageSeverityFlagEXT; Flags64]
DebugUtilsMessageTypeFlagsEXT :: distinct bit_set[DebugUtilsMessageTypeFlagEXT; Flags64]
OverlayMainSessionFlagsEXTX :: distinct bit_set[OverlayMainSessionFlagEXTX; Flags64]
OverlaySessionCreateFlagsEXTX :: distinct bit_set[OverlaySessionCreateFlagEXTX; Flags64]
AndroidSurfaceSwapchainFlagsFB :: distinct bit_set[AndroidSurfaceSwapchainFlagFB; Flags64]
CompositionLayerImageLayoutFlagsFB :: distinct bit_set[CompositionLayerImageLayoutFlagFB; Flags64]
CompositionLayerSecureContentFlagsFB :: distinct bit_set[CompositionLayerSecureContentFlagFB; Flags64]
SwapchainCreateFoveationFlagsFB :: distinct bit_set[SwapchainCreateFoveationFlagFB; Flags64]
SwapchainStateFoveationFlagsFB :: distinct bit_set[SwapchainStateFoveationFlagFB; Flags64]
TriangleMeshFlagsFB :: distinct bit_set[TriangleMeshFlagFB; Flags64]
PassthroughFlagsFB :: distinct bit_set[PassthroughFlagFB; Flags64]
PassthroughStateChangedFlagsFB :: distinct bit_set[PassthroughStateChangedFlagFB; Flags64]
PassthroughCapabilityFlagsFB :: distinct bit_set[PassthroughCapabilityFlagFB; Flags64]
HandTrackingAimFlagsFB :: distinct bit_set[HandTrackingAimFlagFB; Flags64]
KeyboardTrackingFlagsFB :: distinct bit_set[KeyboardTrackingFlagFB; Flags64]
KeyboardTrackingQueryFlagsFB :: distinct bit_set[KeyboardTrackingQueryFlagFB; Flags64]
CompositionLayerSpaceWarpInfoFlagsFB :: distinct bit_set[CompositionLayerSpaceWarpInfoFlagFB; Flags64]
RenderModelFlagsFB :: distinct bit_set[RenderModelFlagFB; Flags64]
DigitalLensControlFlagsALMALENCE :: distinct bit_set[DigitalLensControlFlagALMALENCE; Flags64]
CompositionLayerSettingsFlagsFB :: distinct bit_set[CompositionLayerSettingsFlagFB; Flags64]
PerformanceMetricsCounterFlagsMETA :: distinct bit_set[PerformanceMetricsCounterFlagMETA; Flags64]
FoveationDynamicFlagsHTC :: distinct bit_set[FoveationDynamicFlagHTC; Flags64]
