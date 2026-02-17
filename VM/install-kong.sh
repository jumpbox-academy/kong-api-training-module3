#!/bin/bash
set -e

curl -fsSL https://download.konghq.com/gateway-3.x-ubuntu-jammy/pool/all/k/kong/kong_3.9.0_amd64.deb -o kong.deb
sudo apt install -y ./kong.deb

echo "Kong installed"
