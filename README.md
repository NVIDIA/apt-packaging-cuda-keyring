# cuda-keyring

[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT-license)
[![Contributing](https://img.shields.io/badge/Contributing-Developer%20Certificate%20of%20Origin-violet)](https://developercertificate.org)


## Overview

Packaging for cuda-keyring

1. Install GPG public key in `/usr/share/keyrings/`
2. Set repository priority with apt pinning
3. Enable Nvidia's CUDA repository with `.list` for `apt-get`

### Note on enabling a repository

```shell
deb [signed-by=/path/to/keyring] https://$repositoryURL $suite
```

> ex: `debian11/x86_64`
```
deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /
``` 

### Blog post
[https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/](https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/)


## Deliverables

```shell
 - cuda-keyring
```

## Prerequisites

### Download GPG public key

The `apt-key` command is deprecated in Debian 12, Ubuntu 21.10 and derivative distros.
NVIDIA provides the repo GPG keys in both `*.pub` and encapsulated keyring formats.

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-archive-keyring.gpg
```

**OR**

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/$shortname.pub
cat $shortname.pub | gpg --dearmor > cuda-archive.keyring.gpg
```
> note: replace `$shortname` with `3bf863cc`


### Download priority pin

Repositories maintained by different organizations may contain packages with the same name.
To ensure `apt` selects software from one repository over another, priority pinning may be used.

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin cuda.pin
```

`cat cuda.pin`

```shell
Package: nsight-compute
Pin: origin *ubuntu.com*
Pin-Priority: -1

Package: nsight-systems
Pin: origin *ubuntu.com*
Pin-Priority: -1

Package: *
Pin: release l=NVIDIA CUDA
Pin-Priority: 600
```


### Install build dependencies
> *note:* these are only needed for building not installation

```shell
apt-get install debhelper devscripts dpkg-dev make
```


## Usage

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
```

```shell
DISTRO=ubuntu2204 ARCH=x86_64 ./build.sh cuda-archive-keyring.gpg cuda.pin
```

```shell
ls cuda-keyring*_all.deb
sudo dpkg --install cuda-keyring*_all.deb
sudo apt-get update
```


## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
