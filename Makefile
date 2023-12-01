APP_IMAGE_NAME := asia-northeast1-docker.pkg.dev/cloudrun-v2-with-nginx/sample/app
PROXY_IMAGE_NAME := asia-northeast1-docker.pkg.dev/cloudrun-v2-with-nginx/sample/proxy

.PHONY: build
build:
## --platform は M2 などの mac で build する際に必要
	docker build -t $(APP_IMAGE_NAME) --platform linux/amd64  .
	docker build -t $(PROXY_IMAGE_NAME) --platform linux/amd64  ./proxy

.PHONY: push
push:
	docker push $(APP_IMAGE_NAME)
	docker push $(PROXY_IMAGE_NAME)

.PHONY: deploy
deploy:
	gcloud beta run deploy sample \
		--platform managed \
		--region asia-northeast1 \
		--container proxy \
		--image $(PROXY_IMAGE_NAME) \
		--port 8080 \
		--container app \
		--image $(APP_IMAGE_NAME) \
