#!/bin/sh
set -e

OUT="${1}"
shift

LIBS=()
ARCHIVES=()

for PLATFORM in ${@}
do
  LIBS+=("libs/libtailscale-${PLATFORM}.dylib")
  ARCHIVES+=("archives/libtailscale-${PLATFORM}.a")
done

lipo -create -output "libs/libtailscale-${OUT}.dylib" "${LIBS[@]}"
lipo -create -output "archives/libtailscale-${OUT}.a" "${ARCHIVES[@]}"
