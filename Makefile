# Image name
IMAGE_NAME := sst-simulator-demo
BUILD_SRC := /src
BUILD_DEST := /opt

# Build the Docker image
.PHONY: build
build:
	docker build \
		-t $(IMAGE_NAME) \
		--build-arg BUILD_DEST=$(BUILD_DEST) \
		--build-arg BUILD_SRC=$(BUILD_SRC) \
		.

# Run the Docker container
.PHONY: run
run:
	docker run --rm -it $(IMAGE_NAME) \
		sst $(BUILD_SRC)/sst-elements/src/sst/elements/MarblesDemo/test_simulation.py


# Remove the Docker image
.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME)

