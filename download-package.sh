#!/usr/bin/env bash

set -e

PACKAGE="$1"
RELEASE="$2"

hash=$(./download-package-url.sh --stdout https://repo.magento.com/packages.json | jq '.["provider-includes"]["p/provider-ce$%hash%.json"].sha256' | tr -d '"')
packages=$(./download-package-url.sh --stdout "https://repo.magento.com/p/provider-ce\$$hash.json")

packageProviderHash=$(echo "$packages" | jq '.providers["'$PACKAGE'"].sha256' | tr -d '"')
url=$(./download-package-url.sh --gunzip "https://repo.magento.com/p/$PACKAGE\$$packageProviderHash.json" | jq ".packages[\"$PACKAGE\"][\"$RELEASE\"].dist.url" | tr -d '"')

[[ "null" == "$url" ]] && {
  echo [Error] No release found for $PACKAGE $RELEASE >&2
  exit 2
}

./download-package-url.sh "$url"
echo "$(basename "$url")"

