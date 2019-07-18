#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ AWS_TOKENS ]\n"

echo "AWS API Token for create VM or EBS persistent volume: "
unset input && read -s input \
; echo $input | docker secret create aws_tokens -

echo "AWS API Secret for create VM or EBS persistent volume: "

unset input && read -s input \
; echo $input | docker secret create aws_secret -

echo "Existing slack webhook url: "
unset input && read -s input \
; echo $input | docker secret create slack_webhook_url -


echo -e "\n[ loadbalancer ]\n"

echo "Creating internal masternode lb conf"
docker secret create nginx_conf_blockchain-proxy "./res/blockchain-proxy/nginx.conf"

clear
echo -e "\n[ review ]\n"
docker secret list
