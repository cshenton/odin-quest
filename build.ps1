# Shared paths
$ANDROID_SDK_HOME = "C:/Users/User/AppData/Local/Android/Sdk"
$ANDROID_JAR = "$ANDROID_SDK_HOME/platforms/android-29/android.jar"
$ANDROID_NDK_HOME = "$ANDROID_SDK_HOME/ndk/25.2.9519653"
$ANDROID_LLVM = "$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/windows-x86_64"
$ANDROID_LIBS = "$ANDROID_LLVM/sysroot/usr/include"
$ANDROID_LIBS_LINK = "$ANDROID_LLVM/sysroot/usr/lib/aarch64-linux-android/29"

# Command line tools
$AAPT = "$ANDROID_SDK_HOME/build-tools/34.0.0/aapt"
$ADB = "$ANDROID_SDK_HOME/platform-tools/adb.exe"
$CLANG = "$ANDROID_LLVM/bin/clang"
$JARSIGNER = "C:/Program Files/Android/jdk/jdk-8.0.302.8-hotspot/jdk8u302-b08/bin/jarsigner.exe"
$KEYTOOL = "C:/Program Files/Android/jdk/jdk-8.0.302.8-hotspot/jdk8u302-b08/bin/keytool.exe"
$ZIPALIGN = "$ANDROID_SDK_HOME/build-tools/34.0.0/zipalign"

# Generate debug key
# & $KEYTOOL -genkey -v -keystore debug.keystore -storepass android `
#   -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 `
#   -validity 10000 -dname "C=US, O=Android, CN=Android Debug"

# Clean any previous build
rm -ea 0 questodin.apk

# Build directories
mkdir -ea 0 build/assets
mkdir -ea 0 build/lib/arm64-v8a

# Compile
odin build quest -target:linux_arm64 -build-mode:obj -reloc-mode:pic

& $CLANG --target=aarch64-linux-android29 -ffunction-sections -Os -fdata-sections `
-Wall -fvisibility=hidden -m64 -Os -fPIC -DANDROIDVERSION=29 -DANDROID  `
 -Iinclude -Ideps/include -I./src -I$ANDROID_LIBS -I$ANDROID_LIBS/android `
 quest.o deps/android_native_app_glue.c quest/openxr/libopenxr_loader.so `
 -L$ANDROID_LIBS_LINK -s -lm -lGLESv3 -lEGL -landroid -llog `
 -shared -uANativeActivity_onCreate `
 -o build/lib/arm64-v8a/libquestodin.so

# Package
cp -ea 0 -r assets/assets build
cp -ea 0 quest/openxr/libopenxr_loader.so build/lib/arm64-v8a/
& $AAPT package -f -F build.apk -I $ANDROID_JAR -M AndroidManifest.xml `
  -S assets/resources -v --target-sdk-version 29 build

# Sign and align
& $JARSIGNER -sigalg SHA1withRSA -digestalg SHA1 -verbose -keystore debug.keystore `
  -storepass android build.apk androiddebugkey
& $ZIPALIGN -f -v 4 build.apk questodin.apk

# Clean up
rm -ea 0 -r build
rm -ea 0 temp.apk
rm -ea 0 build.apk

# Install and run
# & $ADB install -r questodin.apk
# & $ADB shell am start -n org.cshenton.questodin/android.app.NativeActivity
# & $ADB logcat OpenXR:V questodin:V *:S -v color

& $ADB install -r questodin.apk
& $ADB shell am start -n org.cshenton.questodin/android.app.NativeActivity
& $ADB logcat > log.txt