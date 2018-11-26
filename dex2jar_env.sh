#!/bin/bash

apkDir=$APK_DECOMPILE_SOURCE_DIR
decompileDir=$APK_DECOMPILE_TARGET_DIR
dexToolsDir=$APK_DECOMPILE_DEXTOOL_DIR
jarOutputDir=$APK_DECOMPILE_JAR_OUTPUT_DIR

cd $apkDir
fnums=$(ls -l *.apk |grep "^-"|wc -l)

if [ $fnums -le 0 ]
  then
  echo "Not found apk file, exit!"
  exit 1
fi

echo "apk files number: $fnums"

apks='ls *.apk'
for apk in $apks
do
  bname=$(basename $apk .apk)

  if [ $bname == "ls" ]
  then
    continue
  fi
  
  echo "[CMD] apk decode: apktool d -o ${decompileDir}/${bname}_release ${apkDir}/${bname}.apk"
  apktool d -o ${decompileDir}/${bname}_release ${apkDir}/${bname}.apk

  echo "[CMD] apk build: apktool b ${decompileDir}/${bname}_release"
  apktool b ${decompileDir}/${bname}_release

  cd $dexToolsDir
  echo "[CMD] Switch to dex2jar Dir: "$(pwd)

  echo "[CMD] Generate jar file:\n./d2j-dex2jar.sh -o ${jarOutputDir}/${bname}.jar ${decompileDir}/${bname}_release/build/apk/classes.dex"
  ./d2j-dex2jar.sh -o ${jarOutputDir}/${bname}.jar ${decompileDir}/${bname}_release/build/apk/classes.dex
done

echo "Action Done!"
exit 0


