FROM combustml/mleap-serving:0.9.0-SNAPSHOT

ENV BDLCL_VERSION 0.14.1

RUN cd /opt && \
    wget https://repo.lentiq.com/bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    tar -xzvf bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    rm -rf /opt/bigstepdatalake-$BDLCL_VERSION-bin.tar.gz && \
    cd /opt/bigstepdatalake-$BDLCL_VERSION/lib/ && \
    export PATH=/opt/bigstepdatalake-$BDLCL_VERSION/bin:$PATH && \
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/bigstepdatalake-$BDLCL_VERSION/lib/' >> ~/.bashrc && \
    bash ~/.bashrc
	
ADD core-site.xml.apiKey /opt/bigstepdatalake-$BDLCL_VERSION/conf

ADD readyness_probe.sh /
ADD entrypoint.sh /
ADD model_loader.sh /

RUN chmod 777 /readyness_probe.sh
RUN chmod 777 /entrypoint.sh
RUN chmod 777 /model_loader.sh

ENV PATH /opt/bigstepdatalake-$BDLCL_VERSION/bin:$PATH

EXPOSE 65327

ENTRYPOINT ["/entrypoint.sh"]
