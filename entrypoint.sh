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
protoc -I/proto -I/proto/grpc \
    --python_out=/gen/service_connector/python/moca_service_connector --purerpc_out=/gen/service_connector/python/moca_service_connector \
    --go_out=/gen/service_connector/go --go_opt=paths=source_relative \
    --dart_out=/gen/service_connector/dart \
    /proto/grpc/service_connector.proto /proto/*.proto

echo -e "$C_MOCA Generating client connector..."
protoc -I/proto -I/proto/grpc \
    --python_out=/gen/client_connector/python/moca_client_connector --purerpc_out=/gen/client_connector/python/moca_client_connector \
    --go_out=/gen/client_connector/go --go_opt=paths=source_relative \
    --dart_out=/gen/client_connector/dart \
    /proto/grpc/client_connector.proto /proto/*.proto


echo -e "$C_MOCA Done."

chmod -R 775 /gen 
