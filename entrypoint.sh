#/bin/sh

C_MOCA="\e[1m\e[35m[MOCA Proto Compiler]\e[0m"
C_PYTHON="\e[1m\e[33m[lang:python]\e[0m"
C_GO="\e[1m\e[94m[lang:go]\e[0m"
C_DART="\e[1m\e[34m[lang:dart]\e[0m"

# Universal
echo -e "$C_MOCA Preparing..."

rm -rf /gen/*
cp -r /skel/* /gen/

echo -e "$C_MOCA Generating service connector..."
protoc -I/proto \
    --python_out=/gen/python/libmoca --purerpc_out=/gen/python/libmoca \
    --go_out=/gen/go --go_opt=paths=source_relative \
    --dart_out=/gen/dart \
    /proto/messages.proto /proto/types.proto /proto/compatibility.proto

protoc -I/proto \
    --python_out=/gen/python/libmoca --purerpc_out=/gen/python/libmoca \
    --go_out=/gen/go --go_opt=paths=source_relative \
    --dart_out=/gen/dart \
    /proto/service_connector.proto

protoc -I/proto \
    --python_out=/gen/python/libmoca --purerpc_out=/gen/python/libmoca \
    --go_out=/gen/go --go_opt=paths=source_relative \
    --dart_out=/gen/dart \
    /proto/client_connector.proto

echo -e "$C_MOCA Done."

chmod -R 775 /gen 
