#!/bin/bash
#Author Hai Dam <haidv@tomochain.com>

export DOCKER_COMPOSE_VERSION="1.24.0"

set -eu

function echocolor {
    echo "$(tput setaf 2) $1 $(tput sgr0)"
}

echocolor '---------------  Installing and setting prerequisites for setting up the suite...'
echocolor '------------------------------------------------------------'
echocolor '####################### Downloading and setting up Docker...'
echocolor '------------------------------------------------------------'
# Docker
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


echocolor '------------------------------------------------------------'
echocolor '############################### Installing apache2-utils so we have at our disposal htpasswd...'
sudo apt-get install apache2-utils -y --install-recommends

echo -e  '\033[1;31m --Finish-- \033[0m'