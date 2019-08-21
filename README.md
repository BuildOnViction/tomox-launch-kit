# TOMOX-LAUNCH-KIT
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/built-by-developers.svg)](https://forthebadge.com)

## Table of contents

- [Introduction](#introduction)
- [Getting started](#getting-started)
- [Database and message queue](#database)
- [Deployment](#deployment)
- [Legal Disclaimer](#legal-disclaimer)

## Introduction 

Launch a TOMO relayer in under a minute with Launch Kit. This repository contains an open-source, free-to-use TOMO relayer template that you can use as a starting point for your own project.

- Quickly launch a market for your community token
- Seemlessly create an in-game marketplace for digital items and collectibles
- Enable trading of any TRC-20 or TRC21 asset

Fork this repository to get started!

 Tomox SDK is split into two separate repository:

- [Tomox-SDK](https://github.com/tomochain/tomox-sdk): Relayer server, API and database with rabbitmq that powers by this launch kit project.
- [Tomox-SDK-UI](https://github.com/tomochain/tomox-sdk-ui): TRC20/TRC21 rayler UIs


## Getting started


#### Contribution

Please try your best to follow the guidance here:
https://chris.beams.io/posts/git-commit/

## Monitoring and Logging (In-progress)

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
