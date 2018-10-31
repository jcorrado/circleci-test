REV := $(shell git log --oneline -1 | awk '{print $$1}')
IMAGE := empatico/logstash
ECR_IMAGE := 307937454286.dkr.ecr.us-east-1.amazonaws.com/$(IMAGE)

all: docker

.PHONY: docker
docker:
	docker build -t $(IMAGE):$(REV) .
	docker tag $(IMAGE):$(REV) $(IMAGE)
	docker tag $(IMAGE):$(REV) $(ECR_IMAGE):$(REV)
	docker tag $(IMAGE):$(REV) $(ECR_IMAGE)

# Requires a login:
.PHONY: release
release: docker
	docker push $(ECR_IMAGE):$(REV)
	docker push $(ECR_IMAGE)
