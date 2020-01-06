#!/bin/bash

echo 'export BDLCL_VERSION=0.14.1' >> ~/.bashrc
echo 'export BDL_HOME="/opt/bigstepdatalake-$BDLCL_VERSION"' >> ~/.bashrc

source  ~/.bashrc

if [ "$AUTH_METHOD" == "apikey" ]; then
	mv $BDL_HOME/conf/core-site.xml.apiKey $BDL_HOME/conf/core-site.xml
	if [ "$AUTH_APIKEY" != "" ]; then
		sed "s/AUTH_APIKEY/$AUTH_APIKEY/" $BDL_HOME/conf/core-site.xml >> $BDL_HOME/conf/core-site.xml.tmp && \
		mv $BDL_HOME/conf/core-site.xml.tmp $BDL_HOME/conf/core-site.xml
	fi
	if [ "$API_ENDPOINT" != "" ]; then
		sed "s/API_ENDPOINT/${API_ENDPOINT//\//\\/}/" $BDL_HOME/conf/core-site.xml >> $BDL_HOME/conf/core-site.xml.tmp && \
		mv $BDL_HOME/conf/core-site.xml.tmp $BDL_HOME/conf/core-site.xml
	fi
	if [ "$BDL_DEFAULT_PATH" != "" ]; then
		sed "s/BDL_DEFAULT_PATH/${BDL_DEFAULT_PATH//\//\\/}/" $BDL_HOME/conf/core-site.xml >> $BDL_HOME/conf/core-site.xml.tmp && \
		mv $BDL_HOME/conf/core-site.xml.tmp $BDL_HOME/conf/core-site.xml
	fi
fi

mkdir /models

bdl -get $MODEL_BDL_PATH /models/

/model_loader.sh &

/docker-java-home/bin/java -cp /opt/docker/lib/ml.combust.mleap.mleap-serving-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-runtime-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-core-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-base-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-tensor-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.bundle.bundle-ml-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-avro-0.9.0-SNAPSHOT.jar:/opt/docker/lib/ml.combust.mleap.mleap-xgboost-java-0.9.0-SNAPSHOT.jar:/opt/docker/lib/org.scala-lang.scala-library-2.11.8.jar:/opt/docker/lib/org.apache.spark.spark-mllib-local_2.11-2.2.0.jar:/opt/docker/lib/org.scalanlp.breeze_2.11-0.13.1.jar:/opt/docker/lib/org.scalanlp.breeze-macros_2.11-0.13.1.jar:/opt/docker/lib/org.scala-lang.scala-reflect-2.11.8.jar:/opt/docker/lib/com.github.fommil.netlib.core-1.1.2.jar:/opt/docker/lib/net.sourceforge.f2j.arpack_combined_all-0.1.jar:/opt/docker/lib/net.sf.opencsv.opencsv-2.3.jar:/opt/docker/lib/com.github.rwl.jtransforms-2.4.0.jar:/opt/docker/lib/org.spire-math.spire_2.11-0.13.0.jar:/opt/docker/lib/org.spire-math.spire-macros_2.11-0.13.0.jar:/opt/docker/lib/org.typelevel.machinist_2.11-0.6.1.jar:/opt/docker/lib/com.chuusai.shapeless_2.11-2.3.2.jar:/opt/docker/lib/org.typelevel.macro-compat_2.11-1.1.1.jar:/opt/docker/lib/org.apache.commons.commons-math3-3.4.1.jar:/opt/docker/lib/org.apache.spark.spark-tags_2.11-2.2.0.jar:/opt/docker/lib/org.spark-project.spark.unused-1.0.0.jar:/opt/docker/lib/com.trueaccord.scalapb.scalapb-runtime_2.11-0.6.0.jar:/opt/docker/lib/com.trueaccord.lenses.lenses_2.11-0.4.12.jar:/opt/docker/lib/com.lihaoyi.fastparse_2.11-0.4.2.jar:/opt/docker/lib/com.lihaoyi.fastparse-utils_2.11-0.4.2.jar:/opt/docker/lib/com.lihaoyi.sourcecode_2.11-0.1.3.jar:/opt/docker/lib/com.google.protobuf.protobuf-java-3.3.1.jar:/opt/docker/lib/com.jsuereth.scala-arm_2.11-2.0.jar:/opt/docker/lib/com.typesafe.config-1.3.0.jar:/opt/docker/lib/org.apache.avro.avro-1.8.1.jar:/opt/docker/lib/org.codehaus.jackson.jackson-core-asl-1.9.13.jar:/opt/docker/lib/org.codehaus.jackson.jackson-mapper-asl-1.9.13.jar:/opt/docker/lib/com.thoughtworks.paranamer.paranamer-2.7.jar:/opt/docker/lib/org.xerial.snappy.snappy-java-1.1.1.3.jar:/opt/docker/lib/org.apache.commons.commons-compress-1.8.1.jar:/opt/docker/lib/org.tukaani.xz-1.5.jar:/opt/docker/lib/org.slf4j.slf4j-api-1.7.7.jar:/opt/docker/lib/net.jafama.jafama-2.1.0.jar:/opt/docker/lib/com.typesafe.akka.akka-http_2.11-10.0.3.jar:/opt/docker/lib/com.typesafe.akka.akka-http-core_2.11-10.0.3.jar:/opt/docker/lib/com.typesafe.akka.akka-parsing_2.11-10.0.3.jar:/opt/docker/lib/com.typesafe.akka.akka-stream_2.11-2.4.16.jar:/opt/docker/lib/com.typesafe.akka.akka-actor_2.11-2.4.16.jar:/opt/docker/lib/org.scala-lang.modules.scala-java8-compat_2.11-0.7.0.jar:/opt/docker/lib/org.reactivestreams.reactive-streams-1.0.0.jar:/opt/docker/lib/com.typesafe.ssl-config-core_2.11-0.2.1.jar:/opt/docker/lib/org.scala-lang.modules.scala-parser-combinators_2.11-1.0.4.jar:/opt/docker/lib/com.typesafe.akka.akka-http-spray-json_2.11-10.0.3.jar:/opt/docker/lib/io.spray.spray-json_2.11-1.3.3.jar ml.combust.mleap.serving.Boot
