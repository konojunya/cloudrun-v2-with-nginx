IMAGE_NAME := asia-northeast1-docker.pkg.dev/cloudrun-v2-with-nginx/sample/app

.PHONY: build
build:
## --platform は M2 などの mac で build する際に必要
	docker build -t $(IMAGE_NAME) --platform linux/amd64  .

.PHONY: push
push:
	docker push $(IMAGE_NAME)