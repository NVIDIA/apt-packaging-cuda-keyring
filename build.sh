#!/usr/bin/env bash
# Copyright 2022, NVIDIA Corporation
# SPDX-License-Identifier: MIT

err() { echo "ERROR: $*"; exit 1; }

make_clean() {
    rm -rf debian/.debhelper/ debian/files debian/changelog debian/control debian/cuda-keyring/
    rm -f debian/cuda-keyring.debhelper.log debian/cuda-keyring.install debian/cuda-keyring.postinst debian/cuda-keyring.substvars
    rm -f debian/cuda*.list debian/cuda*.gpg debian/cuda*pin*
}

make_clean
[[ -f "$1" ]] || err "USAGE: $0 [keyring] [pin file]"
[[ -f "$1" ]] && [[ "$1" =~ \.gpg ]] && cp -v "$1" debian/
[[ -f "$2" ]] && [[ "$2" =~ \.pin ]] && cp -v "$2" debian/cuda-repository-pin-600

make -i -f debian/rules fill_templates || err "make"
dpkg-buildpackage -b -kcudatools@nvidia.com || err "dpkg-buildpackage"

make_clean
mv -v ../cuda-keyring*.deb .
rm -f ../cuda-keyring_*

dpkg -I ./cuda-keyring*.deb
dpkg -c ./cuda-keyring*.deb
