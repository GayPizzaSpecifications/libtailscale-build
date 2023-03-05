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

mkdir -p "build"

cd "libtailscale"
CGO_ENABLED=1 go build -buildmode=c-shared -o "../build/libtailscale-${GOOS}-${GOARCH}.${LIBSUFFIX}"
rm -rf "../build/"*.h
