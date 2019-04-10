#!/bin/bash

counter="0"

while [ $counter -lt 10 ]
do
echo "Trying to load the model, try $counter" >> /tmp/model_load
curl -XPUT -H "content-type: application/json"   -d "{\"path\":\"/models/$MODEL_BDL_PATH\"}" http://localhost:65327/model
result=$?
if [ $result -eq 0 ]; then
	echo "Succesfully loaded the model" >> /tmp/model_load
	exit 0
else
	echo "Failed to load the model" >> /tmp/model_load
	sleep 10
	counter=$[$counter+1]
fi
done

echo "Failed to load the model following retries,killing main process" >> /tmp/model_load
# if it wasn't able to perform the load after 10 tries, kill the main process
kill 1
