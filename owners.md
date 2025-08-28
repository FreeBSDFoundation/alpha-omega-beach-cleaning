# Code Owners

This list aims at documenting the individuals, groups, and organisations
generally responsible for the third-party components identified in the FreeBSD
operating system. The [initial inventory](dependencies.md) is documented in its
own file.

Important: this list is not official!

Also, it aims at making a clear distinction between de facto maintainers of the
respective components, as opposed to formal assignments. (E.g., through the
inclusion in a review team in Phabricator)

It aims at completing - as opposed to replacing - the information already
contained in the `MAINTAINERS` file of the src repository.

## Compilation Infrastructure

### Component: libcxxrt

Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dimitry Andric      | dim@     | MAINTAINERS        |
| Ed Maste            | emaste@  | MAINTAINERS        |

### Component: LLVM

Upstream:      [LLVM](https://llvm.org)  
Directory:     `contrib/llvm-project`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dimitry Andric      | dim@     | MAINTAINERS        |
| Ed Maste            | emaste@  | MAINTAINERS        |
| John Baldwin        | jhb@     | MAINTAINERS        |

## Kernel Components

### Component: ice(4)

Description:   Intel Ethernet 800 Series Driver  
Directory:     `sys/contrib/dev/ice`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
|                     | erj@     | MAINTAINERS        |

### Component: umb(4)

Upstream:      [OpenBSD](https://openbsd.org)  
Directory:     `sys/dev/usb/net`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Pierre Pronchery    | khorben@ | Original import    |

### Component: ZFS

Upstream:      [OpenZFS](https://openzfs.org)  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |

## Network Services

### Component: OpenSSH

Upstream:      [OpenBSD](https://openbsd.org)  
Directory:     `crypto/openssh`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |

### Component: Unbound

Upstream:      NLnet Labs  
Directory:     `contrib/unbound`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dag-Erling Smørgrav | des@     |                    |

## Security Components

### Component: BearSSL

Upstream:      [BearSSL](https://bearssl.org)  
Directory:     `contrib/bearssl`  
Vendor branch: `vendor/bearssl`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Simon J. Gerraty    | sjg@     | Import of 20220418 |

### Component: OpenSSL

Upstream:      [OpenSSL](https://openssl-library.org)  
Directory:     `crypto/openssl`  
Strategy:      [LTS](https://openssl-library.org/policies/releasestrat/index.html)  
Vendor branch: `vendor/openssl-3.5`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    |                    |
| Pierre Pronchery    | khorben@ | Import of 3.0, 3.5 |

## Testing infrastructure

### Component: ATF

Upstream:      [NetBSD](https://netbsd.org)  
Strategy:      [Fork](https://github.com/freebsd/kyua)  
Vendor branch: `vendor/atf`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    | MAINTAINERS        |

### Component: NetBSD tests

Upstream:      [NetBSD](https://netbsd.org)  
Vendor branch: `vendor/NetBSD/tests`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    | MAINTAINERS        |

### Component: pjdfstest

Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Alan Somers         | asomers@ | MAINTAINERS        |
| Ngie Cooper         | ngie@    | MAINTAINERS        |
| Paweł Jakub Dawidek | pjd@     | MAINTAINERS        |

