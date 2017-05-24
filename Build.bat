call Env
call Clr

REM create R.java
call %AAPT_PATH% package -f -m -S %DEV_HOME%\res -J %DEV_HOME%\src -M %DEV_HOME%\AndroidManifest.xml -I %ANDROID_JAR%

REM create bin directory
mkdir %DEV_HOME%\bin

REM Use Jack toolchain (*.java -> *.dex)
%JAVAVM% -jar %JACK_JAR% --output-dex "%DEV_HOME%\bin" -cp %ANDROID_JAR% -D jack.java.source.version=1.8 "%DEV_HOME%\src\%PACKAGE_PATH%\R.java" "%DEV_HOME%\src\%PACKAGE_PATH%\%MAIN_CLASS%.java"  

REM create unsigned APK
call %AAPT_PATH% package -f -M %DEV_HOME%\AndroidManifest.xml -S %DEV_HOME%\res -I %ANDROID_JAR% -F %DEV_HOME%\bin\%APK_NAME%.unsigned.apk %DEV_HOME%\bin

REM create key
call "%JAVA_HOME%\bin\keytool" -genkey -validity 10000 -dname "CN=AndroidDebug, O=Android, C=US" -keystore %DEV_HOME%\%APK_NAME%.keystore -storepass android -keypass android -alias androiddebugkey -keyalg RSA -keysize 2048

REM create signed APK
call "%JAVA_HOME%\bin\jarsigner" -sigalg SHA1withRSA -digestalg SHA1 -keystore %DEV_HOME%\%APK_NAME%.keystore -storepass android -keypass android -signedjar %DEV_HOME%\bin\%APK_NAME%.apk %DEV_HOME%\bin\%APK_NAME%.unsigned.apk androiddebugkey

REM call Install

pause