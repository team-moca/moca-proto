FROM thethingsindustries/protoc:latest

# lang:python
RUN apk add python3 curl
RUN pip3 install purerpc

# End
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

RUN mkdir /gen && mkdir /proto
VOLUME ["/gen", "/proto"]
ENTRYPOINT ["sh", "entrypoint.sh"]