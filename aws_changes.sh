#!/bin/bash

set -e

PROJECT_DIR="$1"

if [ -z "$PROJECT_DIR" ]
then
    echo "Undefined project dir"
    exit 1
fi

pushd "$PROJECT_DIR" > /dev/null
pushd ./aws-cpp-sdk-core/source/http/curl
sed -i "s/curl_easy_setopt(requestHandle, CURLOPT_PUT, 1L);/curl_easy_setopt(requestHandle, CURLOPT_UPLOAD, 1L);/g" ./CurlHttpClient.cpp
popd
popd
