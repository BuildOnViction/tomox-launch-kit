#!/bin/bash
docker swarm init

join_manager_tokens = $(docker swarm join-token manager)

docker swarm join --token ${join_manager_tokens}
