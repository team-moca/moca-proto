# MOCA Proto

Repository contains proto and grpc files for the moca project.
A Dockerfile exists to generate libraries.

## 🐳 Usage with Docker

You'll only have to build a new image if `Dockerfile` or `entrypoint.sh` changed.
Otherwise, just run the container.

### Build

Build the image:

```sh
docker build . --tag moca-proto
```

Or run `make build`

### Run

Run the image:

```sh
docker run -v $PWD/gen:/gen -v $PWD/proto:/proto --user $(id -u):$(id -g) moca-proto
```

Or run `make run`