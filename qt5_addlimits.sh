#!/bin/bash

set -e

PROJECT_DIR="$1"

if [ -z "$PROJECT_DIR" ]
then
    echo "Undefined project dir"
    exit 1
fi

pushd "$PROJECT_DIR" > /dev/null
pushd ./qtbase/src/corelib

pushd ./global > /dev/null
sed -i "47i\#include <limits>" ./qfloat16.h
sed -i "50i\#include <limits>" ./qendian.h
popd

pushd ./text > /dev/null
sed -i "44i\#include <limits>" ./qbytearraymatcher.h
popd
popd

pushd ./qtdeclarative/src/qmldebug > /dev/null
sed -i "52i\#include <limits>" ./qqmlprofilerevent_p.h
popd
popd
