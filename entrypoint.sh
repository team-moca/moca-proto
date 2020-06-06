#/bin/sh

C_MOCA="\e[1m\e[35m[MOCA Proto Compiler]\e[0m"
C_PYTHON="\e[1m\e[33m[lang:python]\e[0m"
C_GO="\e[1m\e[94m[lang:go]\e[0m"
C_DART="\e[1m\e[34m[lang:dart]\e[0m"

# Universal
echo -e "$C_MOCA Preparing..."

rm -rf /repo/gen/*
cp -r /repo/skel/* /repo/gen/

echo -e "$C_MOCA Generating service connector..."
protoc -I/repo/proto \
    --python_out=/repo/gen/python/libmoca --purerpc_out=/repo/gen/python/libmoca \
    --go_out=/repo/gen/go --go_opt=paths=source_relative \
    --dart_out=/repo/gen/dart/lib/src \
    /repo/proto/messages.proto /repo/proto/types.proto /repo/proto/compatibility.proto

protoc -I/repo/proto \
    --python_out=/repo/gen/python/libmoca --purerpc_out=/repo/gen/python/libmoca \
    --go_out=/repo/gen/go --go_opt=paths=source_relative \
    --dart_out=/repo/gen/dart/lib/src \
    /repo/proto/service_connector.proto

protoc -I/repo/proto \
    --python_out=/repo/gen/python/libmoca --purerpc_out=/repo/gen/python/libmoca \
    --go_out=/repo/gen/go --go_opt=paths=source_relative \
    --dart_out=/repo/gen/dart/lib/src \
    /repo/proto/client_connector.proto

echo -e "$C_MOCA Done."

# Determine version
cd /repo/gen/python/
VERSION=$(python3 setup.py --version)

echo -e "$C_MOCA Version: $VERSION"

cd /

echo -e "$C_DART Creating Dart library..."

for filename in /repo/gen/dart/lib/src/*.pb.dart; do
    CURRENT_FILE=$(basename "$filename" .pb.dart);
    echo -e "$C_DART Creating mini library for $CURRENT_FILE";

    echo -e "///\n//  Generated code. Do not modify.\n//  source: https://github.com/team-moca/moca-proto\n//\n\n" > "/repo/gen/dart/lib/$CURRENT_FILE.dart"
    echo "export 'src/$CURRENT_FILE.pb.dart';" >> "/repo/gen/dart/lib/$CURRENT_FILE.dart"
    echo "export 'src/$CURRENT_FILE.pbenum.dart';" >> "/repo/gen/dart/lib/$CURRENT_FILE.dart"
    echo "export 'src/$CURRENT_FILE.pbjson.dart';" >> "/repo/gen/dart/lib/$CURRENT_FILE.dart"
    echo "export 'src/$CURRENT_FILE.pbserver.dart';" >> "/repo/gen/dart/lib/$CURRENT_FILE.dart"
done

echo -e "\nversion: $VERSION" >> "/repo/gen/dart/pubspec.yaml";

echo -e "$C_DART Done."


chmod -R 775 /repo/gen 

echo -e "$C_MOCA Libraries with version $VERSION have been generated successfully."
