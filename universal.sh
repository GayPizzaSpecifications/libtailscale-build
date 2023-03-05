#!/bin/sh
set -e

OUT="${1}"
shift

LIBS=()

for PLATFORM in ${@}
do
  LIBS+=("build/libtailscale-${PLATFORM}.dylib")
done

lipo -create -output "build/libtailscale-${OUT}.dylib" "${LIBS[@]}"
