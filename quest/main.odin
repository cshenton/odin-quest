package quest

import glue "./android/glue"

import egl "./egl"
import xr "./openxr"

HAND_COUNT :: 2
MAX_VIEWS :: 4
MAX_SWAPCHAIN_LENGTH :: 3

App :: struct {
        // Native app glue
        app: rawptr, // TODO: ^glue.App,
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

app_android_handle_cmd :: proc "c" (app: ^glue.App, cmd: i32) {
        a := cast(^App)app.userData

        switch cmd {
        // case .CMD_DESTROY: ANativeActivity_finish
        }
}

// Callback handling android commands
// extern "C" void app_android_handle_cmd(android_app *app, int32_t cmd) {
//         app_t *a = (app_t *)app->userData;

//         switch (cmd) {
//         case APP_CMD_DESTROY:
//                 // Handle application shutdown
//                 ANativeActivity_finish(app->activity);
//                 // TODO: call app_shutdown
//                 break;
//         case APP_CMD_INIT_WINDOW:
//                 if (!a->is_window_init) {
//                         a->is_window_init = true;
//                         printf( "Got start event\n" );
//                 }
//                 else {
//                         // TODO: Handle Resume
//                 }
//                 break;
//         case APP_CMD_TERM_WINDOW:
//                 // Turns up when focus is lost
//                 // Seems like the main loop just xrWaitFrame hitches
//         	break;
//         case APP_CMD_SAVE_STATE:
//                 printf("Saving application state\n");
//                 app->savedState = malloc(sizeof(app_t));
//                 memcpy(app->savedState, a, sizeof(app_t));
//                 app->savedStateSize = sizeof(app_t);
//                 break;
//         case APP_CMD_RESUME:
//                 // Nope, that doesn't work
//                 // printf("Resumed, loading state\n");
//                 // memcpy(a, app->savedState, sizeof(app_t));
//                 break;
//         // TODO: APP_CMD_SAVE_STATE
//         default:
//                 printf("event not handled: %d\n", cmd);
//         }
// }

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
