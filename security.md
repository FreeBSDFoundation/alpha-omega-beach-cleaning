| Component | Security impact | Score |
| --- | --- | --- |
| __Compilation Infrastructure__ | | |
| bmake | build | 1 |
| byacc | build | 1 |
| dtc | build, kernel | 2 |
| elftoolchain | build | 1 |
| Git | build, crypto, network, user | 4 |
| libcxxrt | runtime | 1 |
| LLVM | build, runtime, user | 3 |
| unifdef | build | 1 |
| __General Commands__ | | |
| __Macros and Conventions__ | | |
| __Maintenance Commands__ | | |
| __Kernel__ | | |
| acpi | build, firmware, kernel | 3 |
| ice | kernel, network | 2 |
| ipfilter | kernel, network | 2 |
| pf | kernel, network | 2 |
| umb | kernel, network | 2 |
| ZFS | crypto, firmware, kernel, network | 4 |
| zstd | firmware, kernel, user | 3 |
| __Network Libraries__ | | |
| bsnmp | network | 1 |
| ldns | network | 1 |
| libpcap | network | 1 |
| __Network Services__ | | |
| blocklist | network, system | 2 |
| dma | network | 1 |
| NTP | network, system | 2 |
| OpenSSH | auth, crypto, network | 3 |
| Sendmail | network | 1 |
| Unbound | network | 1 |
| WireGuard | auth, crypto, kernel, network | 4 |
| wpa\_supplicant | kernel, network | 2 |
| __Network Tools__ | | |
| lib9p | network | 1 |
| tcpdump | network | 1 |
| __Security Infrastructure__ | | |
| BearSSL | crypto, network, user | 3 |
| OpenSSL | crypto, kernel, network, user | 4 |
| __System Libraries__ | | |
| arm-optimized-routines | system | 1 |
| bionic-x86\_64-string | system | 1 |
| bsddialog | user | 1 |
| bzip2 | user | 1 |
| flex | build, user | 2 |
| gdtoa | runtime | 1 |
| Heimdal Kerberos | auth, crypto, network | 3 |
| jemalloc | runtime, user | 2 |
| libarchive | user | 1 |
| libbegemot | network, user | 2 |
| libcbor | crypto, system, user | 3 |
| libdialog | user | 1 |
| libdiff | build, user | 2 |
| libedit | user | 1 |
| libevent | system, user | 2 |
| libexecinfo | user | 1 |
| libexpat | user | 1 |
| libfido2 | auth, crypto, system, user | 4 |
| liblzma | firmware, user | 2 |
| libmagic | user | 1 |
| libucl | system, user | 2 |
| libxo | user | 1 |
| mandoc | build, user | 2 |
| ncurses | user | 1 |
| OpenPAM | auth, system, user | 3 |
| SQLite | user | 1 |
| Time Zone Database | system, user | 2 |
| zlib | firmware, system, user | 3 |
| __System Tools__ | | |
| awk | build, user | 2 |
| bc | user | 1 |
| diff | build, user | 2 |
| ee | user | 1 |
| hyperv | system | 1 |
| less | user | 1 |
| Lua | firmware, runtime, user | 3 |
| patch | build, user | 2 |
| pkg | build, crypto, network, user | 4 |
| __Test Infrastructure__ | | |
| ATF | user | 1 |
| capsicum-test | kernel, user | 2 |
| GoogleTest | user | 1 |
| kyua | user | 1 |
| NetBSD tests | user | 1 |
| pjdfstest | user | 1 |
