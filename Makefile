CIRCLE_BUILD_NUM ?= 0

docker_dirs := $(git diff --name-only HEAD~1..HEAD . | grep -v .circleci | grep "/" | cat)
docker_imgs := $(docker_dirs)

.DEFAULT_GOAL: build

.PHONY: build
build: $(docker_dirs)

.PHONY: push
push: docker-login build $(docker_imgs)

.PHONY: $(docker_dirs)
$(docker_dirs):
	@echo "Building $@ image."
	@tag=$(cat $@/Dockerfile | grep ARG | grep VERSION= | cut -d'=' -f 2)_${CIRCLE_BUILD_NUM} && \
		docker build -t ${DOCKERHUB_USER}/$@:$${tag} $@/

.PHONY: $(docker_imgs)
	@echo "Pushing $@ image to dockerhub."
	@docker push ${DOCKERHUB_USER}/${docker_dir}

.PHONY: docker-login
docker-login:
	docker login -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PASS}