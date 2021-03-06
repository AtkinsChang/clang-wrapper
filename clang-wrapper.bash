#!/usr/bin/env bash

info="This is clang wrapper for ghc"

extraClangArgs="-Wno-invalid-pp-token -Wno-unicode -Wno-trigraphs"

inPreprocessorMode () {
    hasE=0
    hasU=0
    hasT=0
    for arg in "$@"
    do
        if [ 'x-E' = "x$arg" ];             then hasE=1; fi
        if [ 'x-undef' = "x$arg" ];         then hasU=1; fi
        if [ 'x-traditional' = "x$arg" ];   then hasT=1; fi
    done
    [ "$hasE$hasU$hasT" = '111' ]
}


adjustPreprocessorLanguage () {
    newArgs=''
    while [ $# -gt 0 ]
    do
        newArgs="$newArgs $1"
        if [ "$1" = '-x' ]
        then
            shift
            if [ $# -gt 0 ]
            then
                if [ "$1" = 'c' ]
                then
                    newArgs="$newArgs assembler-with-cpp"
                else
                    newArgs="$newArgs $1"
                fi
            fi
        fi
        shift
    done
    echo $newArgs
}

if [ $# -ne 0 ]
then
   if inPreprocessorMode "$@"
    then
        exec clang $extraClangArgs `adjustPreprocessorLanguage "$@"`
    else
        exec clang $extraClangArgs "$@"
    fi
else
    echo $info
fi
