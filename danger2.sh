#!/usr/bin/env bash

cd allrepos

while read p; do

    outputString=${p}
    counter=8
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
        counter=-1
    fi

    localpath=`pwd`

    #run android tests
    ./gradlew cAT
    if [ $? -eq 0 ]; then
        echo ${p}-passed
        outputString="$outputString TESTS_PASSED"
        #echo ${p} has PASSED >> ../../../result
    else
        echo ${p}-FAIL
        outputString="$outputString TESTS_FAILED"

        for f in ${localpath}/app/build/outputs/androidTest-results/connected/*.xml; do
            echo "$f"
            cat "${f}"
            number=0
            #check for number of failures
            temp=$(cat "${f}" | grep \</failure\> | wc -l | grep -o -E '[0-9]+')
            echo $temp
            counter=$((counter-temp))
            break
        done
        #echo ${p} has FAILED >> ../../../result
    fi

    outputString="$outputString $counter"
    #write results
    echo ${outputString} >> ../../../result

    cd ../..

    echo REACHED END FOR ${p}

done <../all_github_ids