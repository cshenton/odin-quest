# Odin Quest

[![Watch the video](./quest_odin_example.png)](https://youtube.com/shorts/uB-KziG82zA)

This is a small experiment to build an Odin codebase from scratch to run a meaningful application on the Quest 2.
See the [original repo](https://github.com/cshenton/quest_xr) for information about building Quest `.apk` without
build systems.

This repo extends that example, replacing the C++ application code with [Odin](https://odin-lang.org/). The
only major difference in the build process is that we build a `quest.o` file using the Odin compiler, then link
that into the existing build process. Compared to the rest of the process, the part involving Odin is mercifully
simple, just:

```powershell
odin build quest -target:linux_arm64 -build-mode:obj -reloc-mode:pic
```

## Bindings

I had to write some bindings to get this to work

- EGL: The OpenGL ES loader, in `quest/egl`
- OpenXR: I reused my existing [OpenXR bindings](https://github.com/cshenton/openxr_odin) and made some edits
  to support the OpenGLES structures
- Android Native App Glue: I wrote a _very_ barebones version of `android_native_app_glue.h` and the minimal
  subset of the Android headers needed to support it.

The OpenGLES bindings are fudged. I just attempt to load desktop OpenGL functions using Odin's vendored OpenGL
loader (and EGL), then only use the shared subset.

## How to Build

First, ensure you have the relevant Android SDK, NDK, and build tools installed, the [official docs](https://developer.oculus.com/documentation/native/android/mobile-studio-setup-android/)
get this bit right, so just follow them. Make sure you actually open Android Studio, then open a blank project as
well, because these actually seems to be required to complete the installation... alternatively, there are the
plain [command line tools](https://developer.android.com/studio) (scroll down) but I haven't tested a fresh install
with those yet. 

The build process depends on the following executables:

- `aapt` the Android Asset Packaging Tool which ships with the Android SDK
- `adb` the Android Debug Bridge, used to install the apk
- `clang` the clang compiler that ships with the Android SDK (more specifically, the NDK)
- `jarsigner` in the Android JDK, used to sign our apk (instead of apksigner, since we're Android < 30)
- `keytool` in the Android JDK, used to generate a key store for signing
- `zipalign` which is a zip alignment tool optimises the archive so it can be `mmap`ed, which ships with the Android SDK

Once that's all set up, and you preferably have some sort of example application built to validate your install, just
take a peek at `build.ps1` for the actual build incantations. Make sure you generate a debug key with the commented out
command!
