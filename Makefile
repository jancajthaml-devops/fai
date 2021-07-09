
META := $(shell git rev-parse --abbrev-ref HEAD 2> /dev/null | sed 's:.*/::')
VERSION := $(shell git fetch --tags --force 2> /dev/null; tags=($$(git tag --sort=-v:refname)) && ([ $${\#tags[@]} -eq 0 ] && echo v0.0.0 || echo $${tags[0]}))

export COMPOSE_DOCKER_CLI_BUILD = 0
export DOCKER_BUILDKIT = 0
export COMPOSE_PROJECT_NAME = fai

.ONESHELL:
.PHONY: arm64
.PHONY: amd64
.PHONY: armhf

.PHONY: all
all: bootstrap

.PHONY: bootstrap
bootstrap:
	@docker build -t openbank/fai:$(VERSION) .

.PHONY: setup
setup:
	@docker run --name fai --privileged -it openbank/fai:$(VERSION)
	@docker commit fai fai-setup
	@docker rm -v fai
