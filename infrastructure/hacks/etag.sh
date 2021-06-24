#!/usr/bin/env bash
set -eou pipefail
URL=$1
etag=$(curl -sIL "$URL" | awk 'BEGIN {FS=": "}/^etag/{print $2}' | tr -d '"' | tr -d '\r')
echo "{ \"etag\": \"$etag\" }"
