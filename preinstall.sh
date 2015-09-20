#!/bin/bash

echo "deb http://ppa.launchpad.net/fish-shell/release-2/ubuntu trusty main" > "/etc/apt/sources.list.d/fish-shell-release-2-trusty.list"

apt-get update --allow-unauthenticated

apt-get install fish --force-yes --allow-unauthenticated
