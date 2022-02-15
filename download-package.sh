#!/bin/bash

url="$1"
output=file

[ "$url" == "--stdout" ] && {
  url="$2"
  output=stdout
}


[ "$url" == "--gunzip" ] && {
  url="$2"
  output=gunzip
}

[ -z "$url" ] && {
	echo "No package url specified" >&2
	exit 1
}

username=$(jq '.["http-basic"]["repo.magento.com"].username' "$HOME/.composer/auth.json" | tr -d '"')
password=$(jq '.["http-basic"]["repo.magento.com"].password' "$HOME/.composer/auth.json" | tr -d '"')


if [ "$output" == "stdout" ]; then
  curl -sS -A "composer-php/1.6.0" -u "$username:$password" $url
elif [ "$output" == "gunzip" ]; then
  curl -sS --output - -A "composer-php/1.6.0" -u "$username:$password" $url | gunzip
else
  curl -sSOL -A "composer-php/1.6.0" -u "$username:$password" $url
fi
