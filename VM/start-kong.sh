#!/bin/bash
set -e

export $(grep -v '^#' kong.env | xargs)

kong start
echo "Kong started"
