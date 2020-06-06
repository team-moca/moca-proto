FROM thethingsindustries/protoc:latest

# lang:python
RUN apk add python3 curl git
RUN pip3 install purerpc

# End
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

RUN mkdir /repo
VOLUME ["/repo"]
ENTRYPOINT ["sh", "entrypoint.sh"]