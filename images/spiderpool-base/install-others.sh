#!/bin/bash

# Copyright 2017-2020 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

packages=(
  # Additional iproute2 runtime dependencies
  libelf1
  libmnl0
  bash-completion
  iptables
)


export DEBIAN_FRONTEND=noninteractive

apt-get update

# tzdata is one of the dependencies and a timezone must be set
# to avoid interactive prompt when it is being installed
ln -fs /usr/share/zoneinfo/UTC /etc/localtime

apt-get install -y --no-install-recommends "${packages[@]}"

# The installation of rdma-core should not use the `--no-install-recommends` parameter
# to ensure that the corresponding dependencies are installed.
apt-get install -y rdma-core

apt-get purge --auto-remove
apt-get clean
rm -rf /var/lib/apt/lists/*
