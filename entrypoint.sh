#/bin/sh

C_PYTHON="\e[1m\e[33m[Python]\e[0m"
C_GO="\e[1m\e[94m[Go]\e[0m"
C_DART="\e[1m\e[34m[Dart]\e[0m"

rm -rf /gen/*

mkdir /gen/service_connector
mkdir /gen/client_connector

# Python
echo -e "$C_PYTHON Preparing..."
mkdir /gen/service_connector/python
mkdir /gen/client_connector/python

echo -e "$C_PYTHON Generating service connector..."
protoc -I/proto -I/proto/grpc --python_out=/gen/service_connector/python --purerpc_out=/gen/service_connector/python /proto/grpc/service_connector.proto /proto/*.proto

echo -e "$C_PYTHON Generating client connector..."
protoc -I/proto -I/proto/grpc --python_out=/gen/client_connector/python --purerpc_out=/gen/client_connector/python /proto/grpc/client_connector.proto /proto/*.proto

echo -e "$C_PYTHON Done."


# Go
echo -e "$C_GO Preparing..."
export PATH="$PATH:$(go env GOPATH)/bin"

mkdir /gen/service_connector/go
mkdir /gen/client_connector/go

echo -e "$C_GO Generating service connector..."
protoc --proto_path=/proto --go_out=/gen/service_connector/go --go_opt=paths=source_relative -I/proto /proto/grpc/service_connector.proto

echo -e "$C_GO Generating client connector..."
protoc --proto_path=/proto --go_out=/gen/client_connector/go --go_opt=paths=source_relative -I/proto /proto/grpc/client_connector.proto

echo -e "$C_GO Done."

# Dart
echo -e "$C_DART Preparing..."
mkdir /gen/service_connector/dart
mkdir /gen/client_connector/dart

echo -e "$C_DART Generating service connector..."
protoc -I/proto -I/proto/grpc --dart_out=/gen/service_connector/dart /proto/grpc/service_connector.proto /proto/*.proto

echo -e "$C_DART Generating client connector..."
protoc -I/proto -I/proto/grpc --dart_out=/gen/client_connector/dart /proto/grpc/client_connector.proto /proto/*.proto

echo -e "$C_DART Done."

chmod -R 775 /gen 
