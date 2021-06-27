#!/usr/bin/env bash
set -eou pipefail
URL=$1
etag=$(curl -sfIL "$URL" | awk 'BEGIN {FS=": "}/^etag/{print $2}' | tr -d '"' | tr -d '\r' || (echo "Extraction of etag failed for $URL" >&2 && exit 1))
echo "{ \"etag\": \"$etag\" }"
