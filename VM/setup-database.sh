#!/bin/bash
set -e

sudo -u postgres psql -c "CREATE USER kong WITH PASSWORD 'kong';" || true
sudo -u postgres psql -c "CREATE DATABASE kong OWNER kong;" || true

echo "Database and user ready"
