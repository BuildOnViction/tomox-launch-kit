<img src="./tomox-launch-kit.png">

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/built-by-developers.svg)](https://forthebadge.com)

# Quick start #

## Table of contents ##

* [Introduction](#introduction)
* [Getting started](#getting-started)
* [Create your fullnode](#create-your-fullnode)
* [Database and message queue](#database-and-message-queue)
* [Basic Deployment](#Basic-Deployment)
    * [TomoX SDK](#TomoX-SDK)
    * [TomoX SDK UIs](#tomox-sdk-uis)
* [Monitoring and Logging](#Monitoring-and-Logging)
* [Legal Disclaimer](#legal-disclaimer)

## Introduction ##

Launch a TomoX relayer in under a minute with Launch Kit. This repository contains
an open-source, free-to-use TomoX relayer template that you can use as a starting
point for your own project.

* Quickly launch a market for your community token
* Seemlessly create an in-game marketplace for digital items and collectibles
* Enable trading of any TRC-20 or TRC21 asset

Fork this repository to get started!

Tomox SDK is split into two separate repository:

* [Tomox-SDK](https://github.com/tomochain/tomox-sdk): Relayer server, API and
database with rabbitmq that powers by Launch Kit.
* [Tomox-SDK-UI](https://github.com/tomochain/tomox-sdk-ui): TRC20/TRC21 relayer
UIs

## Getting started ##

### Prerequisite ###

#### Minimum hardware and software requirements ####

* Processing transactions is mostly CPU bound. Therefore we recommend running CPU optimized servers. (You can check our base recommendations to create your fullnode [here](https://docs.tomochain.com/masternode/requirements/))

    * Directly facing internet (public IP, no NAT)
    * 16 cores CPU
    * 32 GB of RAM
    * SSD Storage

    **|** <span style="color:green"> If you are running a node in Testnet, 2CPU/8GB 
    of RAM is sufficient. </span> **|**

#### Application platform ####

* Go 1.12 or higher
* Docker and docker-compose with the latest version
* Nodejs 8.16.x or higher
* Yarn
* nginx

For ubuntu, you can use our [scipt](./scripts).

#### Networks ####

Your server need to open these ports:

* 80/443 for HTTP/HTTPs
* 8501 for fullnode

#### All IT systems require maintenance ####

It is of the owner's responsability to ensure over time that your node has enough:

* disk space to store the new blockchain data
* processing power to keep the chain operating at optimal speed
* monitoring to be able to react quickly in case of problem
* security mesures like firewalling, os security patching, ssh via keypairs, etc.

This is a non exhaustive list.

## Create your fullnode ##

Use this [guide](https://docs.tomochain.com/masternode/tomonative/) to run your
fullnode on server.

## Database and message queue ##

TomoX SDK use mongo as database and rabbitmq for serve as poll queue.

```bash
git clone https://github.com/tomochain/tomox-lanch-kit.git
cd tomox-launch-kit/deploy
docker-compose up -d
```

## Basic Deployment ##

### TomoX SDK ###

Clone [tomox-sdk](https://github.com/tomochain/tomox-sdk.git) to your server

`$ git clone https://github.com/tomochain/tomox-sdk.git`

Go to `tomox-sdk` and edit your relayer config. We have some parameter needs to
be change

* `coinmarketcap_api_key` : Your CoinMarketCap API
* `exchange_address` : Your Relayer Coinbase

After customized your own config, run you SDK backend

```bash
cd tomox-sdk
go build .
nohup ./tomox-sdk > log.temp &
```

If you use Ubuntu server, we created service for run tomox-sdk as service

```bash
wget https://raw.githubusercontent.com/tomochain/tomox-launch-kit/master/dex/scripts/sdk/tomox-sdk.service
sudo mv tomox-sdk.service /lib/systemd/system/
sudo chmod 755 /lib/systemd/system/tomox-sdk.service
sudo systemctl enable tomox-sdk.service
sudo systemctl start tomox-sdk.service
```

#### Custom Config ####

```yaml
coingecko_api_url: https://api.coingecko.com/api/v3
coinmarketcap_api_key: <Your CoinMarketCap API>
coinmarketcap_api_url: https://pro-api.coinmarketcap.com/v1
db_name: tomodex
deposit:
  tomochain:
    distribution_public_key: 0x59B8515E7fF389df6926Cd52a086B0f1f46C630A
    issuer_public_key: 0x59B8515E7fF389df6926Cd52a086B0f1f46C630A
    lock_unix_timestamp: 0
    signer_private_key: 0x3411b45169aa5a8312e51357db68621031020dcf46011d7431db1bbb6d3922ce
    starting_balance: 100
    token_asset_code: WETH
env: dev
error_file: config/errors.yaml
ethereum:
  decimal: 8
  exchange_address: <Your Relayer Coinbase>
  contract_address: 0x82c41f368c6df8ac52fd2ab159b5860a89a85fe3  # will update when testnet
  fee_account: 0x6e6BB166F420DDd682cAEbf55dAfBaFda74f2c9c
  http_url: https://testnet.tomochain.com
  ws_url: wss://testnet.tomochain.com/ws
jwt_signing_key: QfCAH04Cob7b71QCqy738vw5XGSnFZ9d
jwt_verification_key: QfCAH04Cob7b71QCqy738vw5XGSnFZ9d
logs:
  engine: ./engine.log
  main: ./main.log
  operator: ./operator.log
mongo_url: mongodb://mongo0:27017,mongo1:27018,mongo2:27019/tomodex?replicaSet=rs0
rabbitmq_url: amqp://guest:guest@rabbitmq:5672/
server_port: 8080
simulated: false
supported_currencies: ETH,TOMO,BTC,USDT
tick_duration:
  day:
  - 1
  hour:
  - 1
  - 4
  - 12
  min:
  - 1
  - 5
  - 15
  - 30
  month:
  - 1
  - 3
  - 6
  - 9
  week:
  - 1
  year:
  - 1
```

### TomoX SDK UIs ###

#### Build up your UIs ####

```bash
git clone https://github.com/tomochain/tomox-sdk-ui.git
cd tomox-sdk-ui
yarn install && yarn build
sudo rm -Rf /var/www/public/* && sudo cp -Rf build/* /var/www/public
sudo systemctl reload nginx
```

#### Relayer Domain ###

Enable your SSL secure on DNS/CND provider and insert the necessary DNS and CNAME.
We will get this structure

<img src="./dns-sample.png">

#### Contribution ####

Please try your best to follow the guidance [here](https://chris.beams.io/posts/git-commit/)

## Monitoring and Logging ##

**In-progress**

[![Build Status](https://travis-ci.org/tomochain/tomox-launch-kit.svg?branch=master)](https://travis-ci.org/tomochain/tomox-launch-kit)

 This is a starter kit for Docker Swarm monitoring with [Prometheus](https://prometheus.io/),
[Grafana](http://grafana.org/),
[cAdvisor](https://github.com/google/cadvisor), 
[Node Exporter](https://github.com/prometheus/node_exporter),
[Alert Manager](https://github.com/prometheus/alertmanager)
and [Unsee](https://github.com/cloudflare/unsee).

[![naviat/grafana](http://dockeri.co/image/naviat/grafana)](https://hub.docker.com/r/naviat/grafana/)

[![naviat/alertmanager](http://dockeri.co/image/naviat/alertmanager)](https://hub.docker.com/r/naviat/alertmanager/)

[![naviat/node-exporter](http://dockeri.co/image/naviat/node-exporter)](https://hub.docker.com/r/naviat/node-exporter/)

[![naviat/prometheus](http://dockeri.co/image/naviat/prometheus)](https://hub.docker.com/r/naviat/prometheus/)

## Legal Disclaimer ##

The laws and regulations applicable to the use and exchange of digital assets and
blockchain-native tokens, including through any software developed using the
licensed work created by Tomo. as described here (the “Work”), vary by
jurisdiction. As set forth in the Apache License, Version 2.0 applicable to the
Work, developers are “solely responsible for determining the appropriateness of
using or redistributing the Work,” which includes responsibility for ensuring
compliance with any such applicable laws and regulations. See the Apache License,
Version 2.0 for the specific language governing all applicable permissions and
limitations:
http://www.apache.org/licenses/LICENSE-2.0