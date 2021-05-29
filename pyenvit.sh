#!/usr/bin/env bash

# fail on error
set -e
set -o pipefail

# shortcut vars
declare -r VER='3.8.10'
declare -r PE="$(cygpath --unix "${PYENV_ROOT}/versions")"
declare -r PR="$(cygpath --unix "${ASV_PLAT_PORTS}/python")"

declare -ar locarr=(

    # pyenv symlink install
    "${PE}/asv-${VER}-rel"
    "${PE}/asv-${VER}-dbg"

    # pyenv symlink virtualenv
    "${PE}/glue-run-rel"
    "${PE}/glue-run-dbg"

    # python root virtualenvs
    "${PR}/envs/glue-run-rel"
    "${PR}-debug/envs/glue-run-dbg"

    # python symlink bin
    "${PR}/bin"
    "${PR}-debug/bin"
)

echo "clean and relink"
# drop old versions
rm -rvf ${locarr[@]}

# symlink python root bin on windows
ln -s "${PR}/Scripts" "${PR}/bin"
ln -s "${PR}-debug/Scripts" "${PR}-debug/bin"

# symlink Python Build "install" into pyenv versions
ln -s "${PR}" "${PE}/asv-${VER}-rel"
ln -s "${PR}-debug" "${PE}/asv-${VER}-dbg"

# use pyenv to make virtualenvs from the builds
declare ORIGPATH="${PATH}"
export PATH="${PE}/asv-${VER}-rel/DLLs:${ORIGPATH}"
echo 
echo "pyenv virtualenv "asv-${VER}-rel" 'glue-run-rel'"
time pyenv virtualenv "asv-${VER}-rel" 'glue-run-rel'

export PATH="${PE}/asv-${VER}-dbg/DLLs:${ORIGPATH}"
echo 
echo "pyenv virtualenv "asv-${VER}-dbg" 'glue-run-dbg'"
time pyenv virtualenv "asv-${VER}-dbg" 'glue-run-dbg'
