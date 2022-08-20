# cuda-keyring

[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT-license)
[![Contributing](https://img.shields.io/badge/Contributing-Developer%20Certificate%20of%20Origin-violet)](https://developercertificate.org)


## Overview

Packaging for cuda-keyring

1. Install GPG public key in `/usr/share/keyrings/`
2. Set repository priority with apt pinning
3. Enable Nvidia's CUDA repository with `.list` for `apt-get`


### Usage

```shell
usage: build.sh <keyring.gpg> [priority.pin]
       DISTRO=[ubuntu2204|ubuntu2004] ARCH=[x86_64|sbsa|aarch64] build.sh
       DISTRO=[ubuntu2204|ubuntu2004] ARCH=[cross-linux-sbsa|cross-linux-aarch64] build.sh
       DISTRO=[ubuntu1804|ubuntu1604] ARCH=[x86_64|ppc64el|sbsa] build.sh
       DISTRO=[debian11|debian10|wsl-ubuntu] ARCH=x86_64 build.sh
```

### Example

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-archive-keyring.gpg
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin cuda.pin
DISTRO=ubuntu2204 ARCH=x86_64 ./build.sh cuda-archive-keyring.gpg cuda.pin
```


## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
