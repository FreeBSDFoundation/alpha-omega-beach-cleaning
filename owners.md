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

Version:
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dimitry Andric      | dim@     | MAINTAINERS        |
| Ed Maste            | emaste@  | MAINTAINERS        |

### Component: LLVM

Upstream:      [LLVM](https://llvm.org)  
Version:
Directory:     `contrib/llvm-project`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dimitry Andric      | dim@     | MAINTAINERS        |
| Ed Maste            | emaste@  | MAINTAINERS        |
| John Baldwin        | jhb@     | MAINTAINERS        |

## Kernel Components

### Component: ice(4)

Version:
Description:   Intel Ethernet 800 Series Driver  
Directory:     `sys/contrib/dev/ice`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Eric Joyner         | erj@     | MAINTAINERS        |

### Component: umb(4)

Upstream:      [OpenBSD](https://openbsd.org)  
Version:
Directory:     `sys/dev/usb/net`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Pierre Pronchery    | khorben@ | Original import    |

### Component: ZFS

Upstream:      [OpenZFS](https://openzfs.org)  
Version:
Directory:     `sys/contrib/openzfs`, `cddl`  
Vendor branch: `vendor/openzfs/*`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |

## Network Services

### Component: ldns

Upstream:      NLnet Labs  
Version:
Directory:     `contrib/ldns`  
Vendor branch: `vendor/ldns`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dag-Erling Smørgrav | des@     | Import of 1.8.3    |

### Component: OpenSSH

Homepage:      [OpenSSH](https://openssh.com)  
Upstream:      [OpenBSD](https://openbsd.org)  
Version:
Directory:     `crypto/openssh`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |

### Component: Unbound

Upstream:      NLnet Labs  
Version:
Directory:     `contrib/unbound`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Dag-Erling Smørgrav | des@     |                    |

## Security Components

### Component: BearSSL

Upstream:      [BearSSL](https://bearssl.org)  
Version:
Directory:     `contrib/bearssl`  
Vendor branch: `vendor/bearssl`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Simon J. Gerraty    | sjg@     | Import of 20220418 |

### Component: OpenSSL

Upstream:      [OpenSSL](https://openssl-library.org)  
Version:
Directory:     `crypto/openssl`  
Strategy:      [LTS](https://openssl-library.org/policies/releasestrat/index.html)  
Vendor branch: `vendor/openssl`, `vendor/openssl-3.0`, `vendor/openssl-3.5`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    |                    |
| Pierre Pronchery    | khorben@ | Import of 3.0, 3.5 |

## System Libraries

### Component: libedit

## Testing Infrastructure

### Component: ATF

Upstream:      [NetBSD](https://netbsd.org)  
Version:
Strategy:      [Fork](https://github.com/freebsd/kyua)  
Vendor branch: `vendor/atf`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    | MAINTAINERS        |

### Component: NetBSD tests

Upstream:      [NetBSD](https://netbsd.org)  
Version:
Vendor branch: `vendor/NetBSD/tests`  
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Ngie Cooper         | ngie@    | MAINTAINERS        |

### Component: pjdfstest

Version:
Owners:

| Full name           | e-mail   | Capacity           |
| ------------------- | -------- | ------------------ |
| Alan Somers         | asomers@ | MAINTAINERS        |
| Ngie Cooper         | ngie@    | MAINTAINERS        |
| Paweł Jakub Dawidek | pjd@     | MAINTAINERS        |

