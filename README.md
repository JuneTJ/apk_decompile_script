# apk_decompile_script

# PREPARATION: The APK decompile script will use the apktool, dex2jar, jd-gui, please ensure that they are already installed.

# First, exports the environment from ~/.bashrc; please add following lines to the end of ~/.bashrc
# !Don't change the variable's name, because the apk_decompile_script hard code for this. If you want to change the variable's name, please also modify the apk_decompile_script.
# You can special already existed directory for these variables.

# APK_DECOMPILE_SOURCE_DIR: APK source dir
# APK_DECOMPILE_TARGET_DIR: APK decompile dir
# APK_DECOMPILE_DEXTOOL_DIR: dex tools's dir
# APK_DECOMPILE_JAR_OUTPUT_DIR: jar file dir 
export APK_DECOMPILE_SOURCE_DIR=/home/june/work/apk_decompile/apk
export APK_DECOMPILE_TARGET_DIR=/home/june/work/apk_decompile/decompile
export APK_DECOMPILE_DEXTOOL_DIR=/home/june/work/dex-tools-2.1
export APK_DECOMPILE_JAR_OUTPUT_DIR=${APK_DECOMPILE_TARGET_DIR}/jar

