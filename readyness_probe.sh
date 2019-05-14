#!/bin/bash

curl http://localhost:65327/model
if [ $? -eq 0 ]; then
        curl_result=`curl http://localhost:65327/model`
        bad_result="There was an internal server error."

        if [ "$curl_result" == "$bad_result" ]; then
                exit 2
        fi
else
        exit 1
fi