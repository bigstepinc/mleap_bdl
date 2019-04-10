FROM combustml/mleap-serving:0.9.0-SNAPSHOT

RUN cd /opt && \
    wget https://repo.lentiq.com/bigstepdatalake-0.11.1-bin.tar.gz && \
    tar -xzvf bigstepdatalake-0.11.1-bin.tar.gz && \
    rm -rf /opt/bigstepdatalake-0.11.1-bin.tar.gz && \
    cd /opt/bigstepdatalake-0.11.1/lib/ && \
    export PATH=/opt/bigstepdatalake-0.11.1/bin:$PATH && \
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/bigstepdatalake-0.11.1/lib/' >> ~/.bashrc && \
    bash ~/.bashrc
	
ADD core-site.xml.apiKey /opt/bigstepdatalake-0.11.1/conf

ADD entrypoint.sh /
ADD model_loader.sh /

RUN chmod 777 /entrypoint.sh
RUN chmod 777 /model_loader.sh

ENV PATH /opt/bigstepdatalake-0.11.1/bin:$PATH

EXPOSE 65327

ENTRYPOINT ["/entrypoint.sh"]
