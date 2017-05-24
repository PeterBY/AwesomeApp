REM reinstall and start APK on device
call %ADB% uninstall %PACKAGE%
call %ADB% install %DEV_HOME%\bin\%APK_NAME%.apk
call %ADB% shell am start -n %PACKAGE%/%PACKAGE%.%MAIN_CLASS%