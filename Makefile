CIRCLE_BUILD_NUM ?= 0
SHELL = bash

docker_dirs := $(shell git diff --name-only HEAD~1..HEAD . | grep -v .circleci | grep "/" | cat | cut -d'/' -f 1 | sort -u)

.DEFAULT_GOAL: build

.PHONY: build
build: $(docker_dirs)

.PHONY: push
push: docker-login $(docker_dirs)
	@for image in $^; do \
		if [ "$$image" != "$<" ]; then \
			echo "Pushing $$image image to dockerhub." ; \
			docker push ${DOCKERHUB_USER}/$$image ; \
		fi; \
	done

.PHONY: $(docker_dirs)
$(docker_dirs):
	@echo "Building $@ image."
	@tag=$(shell cat $@/Dockerfile | grep ARG | grep CI_BUILD_VERSION= | cut -d'=' -f 2)_${CIRCLE_BUILD_NUM} && \
		docker build -t ${DOCKERHUB_USER}/$@:$${tag} $@/

.PHONY: docker-login
docker-login:
ifdef CI
	cat .dockerhub_pass | docker login --username ${DOCKERHUB_USER} --password-stdin
else
	docker login -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PASS}
endif