FROM alpine:3.12


RUN apk add protoc protobuf-dev

# Python
RUN apk add python3 py3-pip 

# python3-dev build-base

#RUN pip install wheel
#RUN pip install grpcio grpcio_tools purerpc

RUN pip install purerpc

# Go
RUN apk add go
RUN GO111MODULE=on go get github.com/golang/protobuf/protoc-gen-go@v1.4.2

# End
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

RUN mkdir /gen && mkdir /proto
VOLUME ["/gen", "/proto"]
ENTRYPOINT ["sh", "entrypoint.sh"]