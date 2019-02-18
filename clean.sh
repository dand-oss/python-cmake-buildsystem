#!/usr/bin/env bash

# fail on error
set -e
set -o pipefail

declare -ar delarr=(
    "/i/af/ports/build/[Pp]y*"
    "${ASV_PLAT_PORTS}/py*"
    "${PYENV_ROOT}/versions/glue*"
    "${PYENV_ROOT}/versions/asv*"
)

rm -rvf ${delarr[@]}
