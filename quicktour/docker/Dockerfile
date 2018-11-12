# Auto Generated Dockerfile

FROM ballerina/ballerina:0.981.0
LABEL maintainer="dev@ballerina.io"

COPY hello_service.balx /home/ballerina 

COPY twitter.conf /home/ballerina/conf/twitter.conf
EXPOSE  9090

CMD ballerina run hello_service.balx --config /home/ballerina/conf/twitter.conf
