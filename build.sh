#!/bin/bash
set -e

if [ -z "${GOOS}" ] || [ -z "${GOARCH}" ]
then
  echo "GOOS and GOARCH must be set."
  exit 1
fi

if [ -z "${LIBSUFFIX}" ]
then
  echo "LIBSUFFIX must be set."
  exit 1
fi

cd "$(dirname "${0}")"

if [ ! -f "libtailscale/go.mod" ]
then
  git submodule update --init --recursive
fi

mkdir -p "libs"
mkdir -p "archives"

cd "libtailscale"
CGO_ENABLED=1 go build -buildmode=c-shared -o "../libs/libtailscale-${GOOS}-${GOARCH}.${LIBSUFFIX}"
CGO_ENABLED=1 go build -buildmode=c-archive -o "../archives/libtailscale-${GOOS}-${GOARCH}.a"
rm -rf "../libs/"*.h "../archives/"*.h
