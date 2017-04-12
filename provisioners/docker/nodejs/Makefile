ecr-login:
	aws ecr get-login --registry-ids 331887960933 --region ap-southeast-1 | sh -

build:
	docker build -t 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs:7.6.0 .

publish: build ecr-login
	docker push 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs:7.6.0

.PHONY: ecr-login build publish