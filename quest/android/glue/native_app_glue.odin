package android_glue

/**
 * The native activity interface provided by <android/native_activity.h>
 * is based on a set of application-provided callbacks that will be called
 * by the Activity's main thread when certain events occur.
 *
 * This means that each one of this callbacks _should_ _not_ block, or they
 * risk having the system force-close the application. This programming
 * model is direct, lightweight, but constraining.
 *
 * The 'android_native_app_glue' static library is used to provide a different
 * execution model where the application can implement its own main event
 * loop in a different thread instead. Here's how it works:
 *
 * 1/ The application must provide a function named "android_main()" that
 *    will be called when the activity is created, in a new thread that is
 *    distinct from the activity's main thread.
 *
 * 2/ android_main() receives a pointer to a valid "android_app" structure
 *    that contains references to other important objects, e.g. the
 *    ANativeActivity object instance the application is running in.
 *
 * 3/ the "android_app" object holds an ALooper instance that already
 *    listens to two important things:
 *
 *      - activity lifecycle events (e.g. "pause", "resume"). See APP_CMD_XXX
 *        declarations below.
 *
 *      - input events coming from the AInputQueue attached to the activity.
 *
 *    Each of these correspond to an ALooper identifier returned by
 *    ALooper_pollOnce with values of LOOPER_ID_MAIN and LOOPER_ID_INPUT,
 *    respectively.
 *
 *    Your application can use the same ALooper to listen to additional
 *    file-descriptors.  They can either be callback based, or with return
 *    identifiers starting with LOOPER_ID_USER.
 *
 * 4/ Whenever you receive a LOOPER_ID_MAIN or LOOPER_ID_INPUT event,
 *    the returned data will point to an android_poll_source structure.  You
 *    can call the process() function on it, and fill in android_app->onAppCmd
 *    and android_app->onInputEvent to be called for your own processing
 *    of the event.
 *
 *    Alternatively, you can call the low-level functions to read and process
 *    the data directly...  look at the process_cmd() and process_input()
 *    implementations in the glue to see how to do this.
 *
 * See the sample named "native-activity" that comes with the NDK with a
 * full usage example.  Also look at the JavaDoc of NativeActivity.
 */

import "core:c"
import android ".."
import "core:sys/unix"

/**
 * Data associated with an ALooper fd that will be returned as the "outData"
 * when that source has data ready.
 */
 Poll_Source :: struct {
        // The identifier of this source.  May be LOOPER_ID_MAIN or
        // LOOPER_ID_INPUT.
        id: i32,

        // The android_app this ident is associated with.
        app: ^App,

        // Function to call to perform the standard processing of data from
        // this source.
        process: processFn,
}

/**
 * This is the interface for the standard glue code of a threaded
 * application.  In this model, the application's code is running
 * in its own thread separate from the main thread of the process.
 * It is not required that this thread be associated with the Java
 * VM, although it will need to be in order to make JNI calls any
 * Java objects.
 */
App :: struct {
        // The application can place a pointer to its own state object
        // here if it likes.
        userData: rawptr,

        // Fill this in with the function to process main app commands (APP_CMD_*)
        onAppCmd: onAppCmdFn,

        // Fill this in with the function to process input events.  At this point
        // the event has already been pre-dispatched, and it will be finished upon
        // return.  Return 1 if you have handled the event, 0 for any default
        // dispatching.
        onInputEvent: onInputEventFn,

        // The ANativeActivity object instance that this app is running in.
        activity: ^android.ANativeActivity,

        // The current configuration the app is running in.
        config: ^android.AConfiguration,

        // This is the last instance's saved state, as provided at creation time.
        // It is NULL if there was no state.  You can use this as you need; the
        // memory will remain around until you call android_app_exec_cmd() for
        // APP_CMD_RESUME, at which point it will be freed and savedState set to NULL.
        // These variables should only be changed when processing a APP_CMD_SAVE_STATE,
        // at which point they will be initialized to NULL and you can malloc your
        // state and place the information here.  In that case the memory will be
        // freed for you later.
        savedState: rawptr,
        savedStateSize: c.size_t,

        // The ALooper associated with the app's thread.
        looper: ^android.ALooper,

        // When non-NULL, this is the input queue from which the app will
        // receive user input events.
        inputQueue: ^android.AInputQueue,

        // When non-NULL, this is the window surface that the app can draw in.
        window: ^android.ANativeWindow,

        // Current content rectangle of the window; this is the area where the
        // window's content should be placed to be seen by the user.
        contentRect: android.ARect,

        // Current state of the app's activity.  May be either APP_CMD_START,
        // APP_CMD_RESUME, APP_CMD_PAUSE, or APP_CMD_STOP; see below.
        activityState: i32,

        // This is non-zero when the application's NativeActivity is being
        // destroyed and waiting for the app thread to complete.
        destroyRequested: i32,

        // -------------------------------------------------
        // Below are "private" implementation of the glue code.

        mutex: unix.pthread_mutex_t,
        cond: unix.pthread_cond_t,

        msgread: i32,
        msgwrite: i32,

        thread: unix.pthread_t,

        cmdPollSource: Poll_Source,
        inputPollSource: Poll_Source,

        running: i32,
        stateSaved: i32,
        destroyed: i32,
        redrawNeeded: i32,
        pendingInputQueue: ^android.AInputQueue,
        pendingWindow: ^android.ANativeWindow,
        pendingContentRect: android.ARect,
}

Looper_Id :: enum c.int {
        /**
         * Looper data ID of commands coming from the app's main thread, which
         * is returned as an identifier from ALooper_pollOnce().  The data for this
         * identifier is a pointer to an android_poll_source structure.
         * These can be retrieved and processed with android_app_read_cmd()
         * and android_app_exec_cmd().
         */
        Main = 1,

        /**
         * Looper data ID of events coming from the AInputQueue of the
         * application's window, which is returned as an identifier from
         * ALooper_pollOnce().  The data for this identifier is a pointer to an
         * android_poll_source structure.  These can be read via the inputQueue
         * object of android_app.
         */
        Input = 2,

        /**
         * Start of user-defined ALooper identifiers.
         */
        User = 3,
}

App_Cmd :: enum c.int {
        /**
         * Command from main thread: the AInputQueue has changed.  Upon processing
         * this command, android_app->inputQueue will be updated to the new queue
         * (or NULL).
         */
        Input_Changed,

        /**
         * Command from main thread: a new ANativeWindow is ready for use.  Upon
         * receiving this command, android_app->window will contain the new window
         * surface.
         */
        Init_Window,

        /**
         * Command from main thread: the existing ANativeWindow needs to be
         * terminated.  Upon receiving this command, android_app->window still
         * contains the existing window; after calling android_app_exec_cmd
         * it will be set to NULL.
         */
        Term_Window,

        /**
         * Command from main thread: the current ANativeWindow has been resized.
         * Please redraw with its new size.
         */
        Window_Resized,

        /**
         * Command from main thread: the system needs that the current ANativeWindow
         * be redrawn.  You should redraw the window before handing this to
         * android_app_exec_cmd() in order to avoid transient drawing glitches.
         */
        Window_Redraw_Needed,

        /**
         * Command from main thread: the content area of the window has changed,
         * such as from the soft input window being shown or hidden.  You can
         * find the new content rect in android_app::contentRect.
         */
        Content_Rect_Changed,

        /**
         * Command from main thread: the app's activity window has gained
         * input focus.
         */
        Gained_Focus,

        /**
         * Command from main thread: the app's activity window has lost
         * input focus.
         */
        Lost_Focus,

        /**
         * Command from main thread: the current device configuration has changed.
         */
        Config_Changed,

        /**
         * Command from main thread: the system is running low on memory.
         * Try to reduce your memory use.
         */
        Low_Memory,

        /**
         * Command from main thread: the app's activity has been started.
         */
        Start,

        /**
         * Command from main thread: the app's activity has been resumed.
         */
        Resume,

        /**
         * Command from main thread: the app should generate a new saved state
         * for itself, to restore from later if needed.  If you have saved state,
         * allocate it with malloc and place it in android_app.savedState with
         * the size in android_app.savedStateSize.  The will be freed for you
         * later.
         */
        Save_State,

        /**
         * Command from main thread: the app's activity has been paused.
         */
        Pause,

        /**
         * Command from main thread: the app's activity has been stopped.
         */
        Stop,

        /**
         * Command from main thread: the app's activity is being destroyed,
         * and waiting for the app thread to clean up and exit before proceeding.
         */
        Destroy,
}

@(default_calling_convention="c")
@(link_prefix="android_")
foreign egl {

/**
 * Call when ALooper_pollAll() returns LOOPER_ID_MAIN, reading the next
 * app command message.
 */
app_read_cmd :: proc(app: ^App) -> i8 ---

/**
* Call with the command returned by android_app_read_cmd() to do the
* initial pre-processing of the given command.  You can perform your own
* actions for the command after calling this function.
*/
app_pre_exec_cmd :: proc(app: ^App, cmd: i8) ---
 
/**
* Call with the command returned by android_app_read_cmd() to do the
* final post-processing of the given command.  You must have done your own
* actions for the command before calling this function.
*/
app_post_exec_cmd :: proc(app: ^App, cmd: i8) ---

/**
* This is the function that application code must implement, representing
* the main entry to the app.
*/
//  extern void android_main(struct android_app* app);
}

processFn :: #type proc(app: ^App, source: ^Poll_Source)
onAppCmdFn :: #type proc(app: ^App, cmd: App_Cmd)
onInputEventFn :: #type proc(app: ^App, event: ^android.AInputEvent) -> i32
