#!/bin/bash
set -e

export $(grep -v '^#' kong.env | xargs)

kong migrations bootstrap || true
echo "Migration complete"
