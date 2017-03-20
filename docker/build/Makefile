
build:
	docker build -t deployer . && docker tag deployer:latest 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/deployer:latest

publish:
    aws ecr get-login --region ap-southeast-1 && docker push 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/deployer:latest