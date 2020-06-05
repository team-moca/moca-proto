# MOCA Proto

Repository contains proto and grpc files for the moca project.
A Dockerfile exists to generate libraries.

## 🐳 Dockerfile usage

You'll only have to build a new image if `Dockerfile` or `entrypoint.sh` changed.
Otherwise, just run the container.

### Build

Build the image:

```sh
docker build . --tag moca-proto
```

### Run

Run the image:

```sh
docker run -v $PWD/gen:/gen -v $PWD/proto:/proto --user $(id -u):$(id -g) moca-proto
```
