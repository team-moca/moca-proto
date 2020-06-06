default: all
all: build run

build:
	docker build . --tag moca-proto

run:
	docker run -v $(PWD):/repo --user $(shell id -u):$(shell id -g) moca-proto


clean:
	rm -rf gen/client_connector
	rm -rf gen/service_connector

watch:
	@echo "Waiting for file changes..."
	@while true; do \
		make $(WATCHMAKE); \
		inotifywait -qre close_write .; \
	done
