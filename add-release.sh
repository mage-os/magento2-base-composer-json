#!/usr/bin/env bash

set -e

RELEASE=$1

[ -z "$RELEASE" ] && {
  echo [Error] No release version specified >&2
  exit 1
}

echo Fetching git-tag composer.json...
mkdir -p "$RELEASE/git-tag"
curl -sS "https://raw.githubusercontent.com/magento/magento2/${RELEASE}/composer.json" > "$RELEASE/git-tag/composer.json" 

hash=$(./download-package.sh --stdout https://repo.magento.com/packages.json | jq '.["provider-includes"]["p/provider-ce$%hash%.json"].sha256' | tr -d '"')
packages=$(./download-package.sh --stdout "https://repo.magento.com/p/provider-ce\$$hash.json")

echo Fetching magento2-base composer.json...
mkdir -p "$RELEASE/magento2-base"
packageProviderHash=$(echo "$packages" | jq '.providers["magento/magento2-base"].sha256' | tr -d '"')
url=$(./download-package.sh --gunzip "https://repo.magento.com/p/magento/magento2-base\$$packageProviderHash.json" | jq ".packages[\"magento/magento2-base\"][\"$RELEASE\"].dist.url" | tr -d '"')
archive="$(basename "$url")"
./download-package.sh "$url"
unzip "$archive" composer.json
mv composer.json "$RELEASE/magento2-base/composer.json"
rm "$archive"

echo Fetching product-community-edition composer.json...
mkdir -p "$RELEASE/product-community-edition"
packageProviderHash=$(echo "$packages" | jq '.providers["magento/product-community-edition"].sha256' | tr -d '"')
url=$(./download-package.sh --gunzip "https://repo.magento.com/p/magento/product-community-edition\$$packageProviderHash.json" | jq ".packages[\"magento/product-community-edition\"][\"$RELEASE\"].dist.url" | tr -d '"')
archive="$(basename "$url")"
./download-package.sh "$url"
unzip "$archive" composer.json
mv composer.json "$RELEASE/product-community-edition/composer.json"
rm "$archive"

echo Fetching project-community-edition composer.json...
mkdir -p "$RELEASE/project-community-edition"
packageProviderHash=$(echo "$packages" | jq '.providers["magento/project-community-edition"].sha256' | tr -d '"')
url=$(./download-package.sh --gunzip "https://repo.magento.com/p/magento/project-community-edition\$$packageProviderHash.json" | jq ".packages[\"magento/project-community-edition\"][\"$RELEASE\"].dist.url" | tr -d '"')
archive="$(basename "$url")"
./download-package.sh "$url"
unzip "$archive" composer.json
mv composer.json "$RELEASE/project-community-edition/composer.json"
rm "$archive"
