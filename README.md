<img src="./tomox-launch-kit.png">

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/built-by-developers.svg)](https://forthebadge.com)

# Quick start
## Table of contents

* [Introduction](#introduction)
* [Getting started](#getting-started)
* [Create your fullnode](#create-your-fullnode)
* [Database and message queue](#database)
* [Basic Deployment](#deployment)
    * [TomoX SDK](#TomoX-SDK)
    * [TomoX SDK UIs](#tomox-sdk-uis)
* [Legal Disclaimer](#legal-disclaimer)
* [Monitoring and Logging](#Monitoring-and-Logging)

## Introduction

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
* [Tomox-SDK-UI](https://github.com/tomochain/tomox-sdk-ui): TRC20/TRC21 relayer UIs

## Getting started ##

### Prerequisite ###

#### Minimum hardware and software requirements ####

* Processing transactions is mostly CPU bound. Therefore we recommend running CPU optimized servers. (You can check our base recommendations to create your fullnode [here](https://docs.tomochain.com/masternode/requirements/))

    * Directly facing internet (public IP, no NAT)
    * 16 cores CPU
    * 32 GB of RAM
    * SSD Storage

    [<span style="color:#59afe1"> If you are running a node in Testnet, 2CPU/8GB of RAM is sufficient. </span>]

* Go 1.12 or higher
* Docker and docker-compose with the latest version
* Nodejs 8.16.x or higher

All IT systems require maintenance.

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


## Basic Deployment ##

### TomoX SDK ###

#### Custom Config ####

### TomoX SDK UIs ###

#### Contribution ####

Please try your best to follow the guidance [here](https://chris.beams.io/posts/git-commit/)

## Monitoring and Logging ##

**(In-progress)**

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
