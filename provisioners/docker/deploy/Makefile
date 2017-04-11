
build:
	docker build -t deployer . && docker tag deployer:latest 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/deployer:latest

publish:
    eval $(aws ecr get-login --registry-ids 331887960933 --region ap-southeast-1) && docker push 331887960933.dkr.ecr.ap-southeast-1.amazonaws.com/deployer:latest