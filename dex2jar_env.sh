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

  echo "[CMD] apk build: apktool b ${decompileDir}/${bname}_release -- generates dex files"
  apktool b ${decompileDir}/${bname}_release

  cd ${decompileDir}/${bname}_release/build/apk
  dexes='ls *.dex'
  for dex in $dexes
  do
    dexbname=$(basename $dex .dex)
    
    if [ $dexbname == "ls" ]
    then
      continue
    fi

    dexidx=`echo ${dexbname} | tr -cd "[0-9]"`
    echo "dex name: $dexbname, idx is $dexidx"

    echo "[CMD] $dexToolsDir/d2j-dex2jar.sh -o ${jarOutputDir}/${bname}/${bname}${dexidx}.jar ${decompileDir}/${bname}_release/build/apk/${dexbname}.dex"
    $dexToolsDir/d2j-dex2jar.sh -o ${jarOutputDir}/${bname}/${bname}${dexidx}.jar ${decompileDir}/${bname}_release/build/apk/${dexbname}.dex
  done
  
done

echo "Action Done!"
exit 0

