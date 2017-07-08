#!/usr/bin/env bash
set -ex
env
######   Security Token Access #############
aws sts assume-role --role-arn arn:aws:iam::103426260373:role/dev-to-prod-iam-role --role-session-name "Prod-role-session" > assume-role-output.txt
cat assume-role-output.txt
AccessKeyId=$(cat assume-role-output.txt  | jq -r '.Credentials.AccessKeyId')
SecretAccessKey=$(cat assume-role-output.txt  | jq -r '.Credentials.SecretAccessKey')
SessionToken=$(cat assume-role-output.txt  | jq -r '.Credentials.SessionToken')

######   Env Variable Set #############
if [ -d "${HOME}/.aws/" ]
then
    echo "Directory /path/to/dir exists."
else
    mkdir ${HOME}/.aws/
fi

echo "[profile TempCred]" >> ~/.aws/config
echo "aws_access_key_id = ${AccessKeyId}"  >> ~/.aws/config
echo "aws_secret_access_key = ${SecretAccessKey}"  >> ~/.aws/config
echo "aws_security_token = ${SessionToken}"  >> ~/.aws/config
echo "region = ap-southeast-1"  >> ~/.aws/config
aws configure set TempCred.s3.use_accelerate_endpoint true
#######   Test Copy file to validate  ###
touch ${PWD}/test
aws s3  --profile TempCred  cp test s3://tol-production-static-apache-dev/

######   Clean Credentials #############
rm ~/.aws/config
rm ${PWD}/test
