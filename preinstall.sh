#!/bin/bash

cp ./fish-shell-release-2-trusty.list /etc/apt/sources.list.d/

apt-get update

apt-get install fish
