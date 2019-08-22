#!/bin/bash
#Author Hai Dam <haidv@tomochain.com>

# Set version 
set -eu
export DOCKER_COMPOSE_VERSION="1.24.0"

function echocolor {
    echo "$(tput setaf 2) $1 $(tput sgr0)"
}

# Docker
echocolor '---------------  Installing and setting prerequisites for setting up the suite...'
echocolor '------------------------------------------------------------'
echocolor '####################### Downloading and setting up Docker...'
echocolor '------------------------------------------------------------'
# Docker
if
sudo apt remove --yes docker docker-engine docker.io \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
    && wget --quiet --output-document=- https://download.docker.com/linux/ubuntu/gpg \
        | sudo apt-key add - \
    && sudo add-apt-repository \
        "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
        $(lsb_release --codename --short) \
        stable" \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install docker-ce \
    && sudo usermod --append --groups docker "$USER" \
    && sudo systemctl enable docker \
    && echocolor 'Docker installed successfully'

echocolor 'Waiting for Docker to start...'
sleep 3


# Docker Compose

echocolor '------------------------------------------------------------'
echocolor '############################### Downloading docker-compose and making docker-compose executable...'
echocolor '------------------------------------------------------------'
sudo wget \
        --output-document=/usr/local/bin/docker-compose \
        https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_VERSION"/run.sh \
    && sudo chmod +x /usr/local/bin/docker-compose \
    && sudo wget \
        --output-document=/etc/bash_completion.d/docker-compose \
        "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose" \
    && echocolor 'Docker Compose installed successfully!'


## GOLANG 
wget -q -O - https://gist.githubusercontent.com/naviat/3ca77f48f90ab3fe495c17054499ba1f/raw/ffcab909e96bb17c9c1bb59123b1d1fd566f0149/goinstall.sh | bash

## Nodejs 

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

sudo sh -c 'echo deb https://deb.nodesource.com/node_8.x xenial main > /etc/apt/sources.list.d/nodesource.list'

sudo apt-get update
sudo apt-get install nodejs

echo -e  '\033[1;31m --Finish-- \033[0m'
