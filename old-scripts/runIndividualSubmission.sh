#!/usr/bin/env bash

p=$1
cd allrepos
outputString=${p}
counter=0
echo $p
mkdir $p # Create a unique directory for each user
cd $p
git clone https://github.com/csc413f16/p2-${p}.git # clone the repo. The pattern here is known.
cd p2-${p}

#Build the project. record that the build failed
./gradlew build
if [ $? -ne 0 ]; then
    buildfailed=1
    outputString="$outputString BUILD_FAILED"
fi



#   Use this to check if the user has passed or failed(binary)
#   More sophisticated implementation is below.
#    ./gradlew cAT
#
#    if [ $? -eq 0 ]; then
#        echo ${p}-passed
#
#        echo ${p} has PASSED >> ../../../result
#    else
#        echo ${p}-FAIL
#        echo ${p} has FAILED >> ../../../result
#    fi

    localpath=`pwd`

    adb push ${localpath}/app/build/outputs/apk/app-debug.apk /data/local/tmp/rs.csc413factorydem
    adb shell "pm install -r \"/data/local/tmp/rs.csc413factorydem\""


#    `adb push ${localpath}/app/build/outputs/apk/app-debug-androidTest.apk /data/local/tmp/rs.csc413factorydem.test`
#    `adb shell pm install -r "/data/local/tmp/rs.csc413factorydem.test"`

#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#setUp rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#    if [ $? -eq 0 ]; then
#        counter=$((counter+1))
#    fi

#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#setUp rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryBadString rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryStringDecoding rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryObjectReturns rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#setUp rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testCircle rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testRectangle rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi
#    adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testPicture rs.csc413factorydem.test/android.test.InstrumentationTestRunner | grep FAILURES
#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi

#    if [ $? -ne 0 ]; then
#        counter=$((counter+1))
#    fi



#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#setUp rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryBadString rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryStringDecoding rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapeFactory#testShapeFactoryObjectReturns rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#setUp rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testCircle rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testRectangle rs.csc413factorydem.test/android.test.InstrumentationTestRunner
#     adb shell am instrument -w   -e class rs.f16csc413p2.TestShapes#testPicture rs.csc413factorydem.test/android.test.InstrumentationTestRunner


echo ${p} ${counter}
outputString="$outputString $counter"
#Going back to the root directory.

#write results to someplace
echo ${outputString} >> ../../../result

#Go back to root dir
cd ../..

