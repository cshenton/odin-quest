package android

import "core:c"

ANativeActivity :: struct {
        /**
         * Pointer to the callback function table of the native application.
         * You can set the functions here to your own callbacks.  The callbacks
         * pointer itself here should not be changed; it is allocated and managed
         * for you by the framework.
         */
        callbacks: ^ANativeActivityCallbacks, 
    
        /**
         * The global handle on the process's Java VM.
         */
        vm: rawptr, // JavaVM*
    
        /**
         * JNI context for the main thread of the app.  Note that this field
         * can ONLY be used from the main thread of the process; that is, the
         * thread that calls into the ANativeActivityCallbacks.
         */
        env: rawptr, // JNIEnv* 
    
        /**
         * The NativeActivity object handle.
         *
         * IMPORTANT NOTE: This member is mis-named. It should really be named
         * 'activity' instead of 'clazz', since it's a reference to the
         * NativeActivity instance created by the system for you.
         *
         * We unfortunately cannot change this without breaking NDK
         * source-compatibility.
         */
        clazz: rawptr, // jobject 
    
        /**
         * Path to this application's internal data directory.
         */
        internalDataPath: cstring,
    
        /**
         * Path to this application's external (removable/mountable) data directory.
         */
        externalDataPath: cstring,
    
        /**
         * The platform's SDK version code.
         */
        sdkVersion: i32,
    
        /**
         * This is the native instance of the application.  It is not used by
         * the framework, but can be set by the application to its own instance
         * state.
         */
        instance: rawptr,
    
        /**
         * Pointer to the Asset Manager instance for the application.  The application
         * uses this to access binary assets bundled inside its own .apk file.
         */
        assetManager: rawptr, // AAssetManager* 
    
        /**
         * Available starting with Honeycomb: path to the directory containing
         * the application's OBB files (if any).  If the app doesn't have any
         * OBB files, this directory may not exist.
         */
        obbPath: cstring,
}

onStartProc :: #type proc "c" (activity: ^ANativeActivity)
onResumeProc :: #type proc "c" (activity: ^ANativeActivity)
onPauseProc :: #type proc "c" (activity: ^ANativeActivity)
onStopProc :: #type proc "c" (activity: ^ANativeActivity)
onDestroyProc :: #type proc "c" (activity: ^ANativeActivity)
onWindowFocusChangedProc :: #type proc "c" (activity: ^ANativeActivity, hasFocus: i32)
onNativeWindowCreatedProc :: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow)
onNativeWindowResizedProc :: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow)
onNativeWindowRedrawNeededProc :: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow)
onNativeWindowDestroyedProc :: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow)
onInputQueueCreatedProc :: #type proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue)
onInputQueueDestroyedProc :: #type proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue)
onContentRectChangedProc :: #type proc "c" (activity: ^ANativeActivity, rect: ^ARect)
onConfigurationChangedProc :: #type proc "c" (activity: ^ANativeActivity)
onLowMemoryProc :: #type proc "c" (activity: ^ANativeActivity)
onSaveInstanceStateProc :: #type proc "c" (activity: ^ANativeActivity, outSize: ^c.size_t) -> rawptr

/**
 * These are the callbacks the framework makes into a native application.
 * All of these callbacks happen on the main thread of the application.
 * By default, all callbacks are NULL; set to a pointer to your own function
 * to have it called.
 */
ANativeActivityCallbacks :: struct {
        /**
         * NativeActivity has started.  See Java documentation for Activity.onStart()
         * for more information.
         */
        onStart: onStartProc,
    
        /**
         * NativeActivity has resumed.  See Java documentation for Activity.onResume()
         * for more information.
         */
        onResume: onResumeProc,

        /**
         * Framework is asking NativeActivity to save its current instance state.
         * See Java documentation for Activity.onSaveInstanceState() for more
         * information.  The returned pointer needs to be created with malloc();
         * the framework will call free() on it for you.  You also must fill in
         * outSize with the number of bytes in the allocation.  Note that the
         * saved state will be persisted, so it can not contain any active
         * entities (pointers to memory, file descriptors, etc).
         */
         onSaveInstanceState: onSaveInstanceStateProc,
    
        /**
         * NativeActivity has paused.  See Java documentation for Activity.onPause()
         * for more information.
         */
        onPause: onPauseProc,

        /**
         * NativeActivity has stopped.  See Java documentation for Activity.onStop()
         * for more information.
         */
        onStop: onStopProc,

        /**
         * NativeActivity is being destroyed.  See Java documentation for Activity.onDestroy()
         * for more information.
         */
        onDestroy: onDestroyProc,

        /**
         * Focus has changed in this NativeActivity's window.  This is often used,
         * for example, to pause a game when it loses input focus.
         */
        onWindowFocusChanged: onWindowFocusChangedProc,

        /**
         * The drawing window for this native activity has been created.  You
         * can use the given native window object to start drawing.
         */
        onNativeWindowCreated: onNativeWindowCreatedProc,

        /**
         * The drawing window for this native activity has been resized.  You should
         * retrieve the new size from the window and ensure that your rendering in
         * it now matches.
         */
        onNativeWindowResized: onNativeWindowResizedProc,

        /**
         * The drawing window for this native activity needs to be redrawn.  To avoid
         * transient artifacts during screen changes (such resizing after rotation),
         * applications should not return from this function until they have finished
         * drawing their window in its current state.
         */
        onNativeWindowRedrawNeeded: onNativeWindowRedrawNeededProc,

        /**
         * The drawing window for this native activity is going to be destroyed.
         * You MUST ensure that you do not touch the window object after returning
         * from this function: in the common case of drawing to the window from
         * another thread, that means the implementation of this callback must
         * properly synchronize with the other thread to stop its drawing before
         * returning from here.
         */
        onNativeWindowDestroyed: onNativeWindowDestroyedProc,

        /**
         * The input queue for this native activity's window has been created.
         * You can use the given input queue to start retrieving input events.
         */
        onInputQueueCreated: onInputQueueCreatedProc,

        /**
         * The input queue for this native activity's window is being destroyed.
         * You should no longer try to reference this object upon returning from this
         * function.
         */
        onInputQueueDestroyed: onInputQueueDestroyedProc,

        /**
         * The rectangle in the window in which content should be placed has changed.
         */
        onContentRectChanged: onContentRectChangedProc,

        /**
         * The current device AConfiguration has changed.  The new configuration can
         * be retrieved from assetManager.
         */
        onConfigurationChanged: onConfigurationChangedProc,

        /**
         * The system is running low on memory.  Use this callback to release
         * resources you do not need, to help the system avoid killing more
         * important processes.
         */
        onLowMemory: onLowMemoryProc,
}


/**
 * This is the function that must be in the native code to instantiate the
 * application's native activity.  It is called with the activity instance (see
 * above); if the code is being instantiated from a previously saved instance,
 * the savedState will be non-NULL and point to the saved data.  You must make
 * any copy of this data you need -- it will be released after you return from
 * this function.
 */
ANativeActivity_createFunc :: #type proc "c" (activity: ^ANativeActivity, savedState: rawptr, savedStateSize: c.size_t)

@(default_calling_convention="c")
@(link_prefix="egl")
foreign egl {
}

// /**
//  * The name of the function that NativeInstance looks for when launching its
//  * native code.  This is the default function that is used, you can specify
//  * "android.app.func_name" string meta-data in your manifest to use a different
//  * function.
//  */
// extern ANativeActivity_createFunc ANativeActivity_onCreate;

// /**
//  * Finish the given activity.  Its finish() method will be called, causing it
//  * to be stopped and destroyed.  Note that this method can be called from
//  * *any* thread; it will send a message to the main thread of the process
//  * where the Java finish call will take place.
//  */
// void ANativeActivity_finish(ANativeActivity* activity);

// /**
//  * Change the window format of the given activity.  Calls getWindow().setFormat()
//  * of the given activity.  Note that this method can be called from
//  * *any* thread; it will send a message to the main thread of the process
//  * where the Java finish call will take place.
//  */
// void ANativeActivity_setWindowFormat(ANativeActivity* activity, int32_t format);

// /**
//  * Change the window flags of the given activity.  Calls getWindow().setFlags()
//  * of the given activity.  Note that this method can be called from
//  * *any* thread; it will send a message to the main thread of the process
//  * where the Java finish call will take place.  See window.h for flag constants.
//  */
// void ANativeActivity_setWindowFlags(ANativeActivity* activity,
//         uint32_t addFlags, uint32_t removeFlags);

// /**
//  * Flags for ANativeActivity_showSoftInput; see the Java InputMethodManager
//  * API for documentation.
//  */
// enum {
//     /**
//      * Implicit request to show the input window, not as the result
//      * of a direct request by the user.
//      */
//     ANATIVEACTIVITY_SHOW_SOFT_INPUT_IMPLICIT = 0x0001,

//     /**
//      * The user has forced the input method open (such as by
//      * long-pressing menu) so it should not be closed until they
//      * explicitly do so.
//      */
//     ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED = 0x0002,
// };

// /**
//  * Show the IME while in the given activity.  Calls InputMethodManager.showSoftInput()
//  * for the given activity.  Note that this method can be called from
//  * *any* thread; it will send a message to the main thread of the process
//  * where the Java finish call will take place.
//  */
// void ANativeActivity_showSoftInput(ANativeActivity* activity, uint32_t flags);

// /**
//  * Flags for ANativeActivity_hideSoftInput; see the Java InputMethodManager
//  * API for documentation.
//  */
// enum {
//     /**
//      * The soft input window should only be hidden if it was not
//      * explicitly shown by the user.
//      */
//     ANATIVEACTIVITY_HIDE_SOFT_INPUT_IMPLICIT_ONLY = 0x0001,
//     /**
//      * The soft input window should normally be hidden, unless it was
//      * originally shown with {@link ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED}.
//      */
//     ANATIVEACTIVITY_HIDE_SOFT_INPUT_NOT_ALWAYS = 0x0002,
// };

// /**
//  * Hide the IME while in the given activity.  Calls InputMethodManager.hideSoftInput()
//  * for the given activity.  Note that this method can be called from
//  * *any* thread; it will send a message to the main thread of the process
//  * where the Java finish call will take place.
//  */
// void ANativeActivity_hideSoftInput(ANativeActivity* activity, uint32_t flags);
