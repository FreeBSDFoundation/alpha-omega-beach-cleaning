# Inventory of Dependencies

For the detailed information, refer to the list of [owners](owners.md).

| Component                      | Dependency   | Directory              | Upstream |
| ------------------------------ | ------------ | ---------------------- | -------- |
| __Compilation Infrastructure__ |              |                        |          |
|                                | libcxxrt     |                        |          |
|                                | LLVM         | `contrib/llvm-project` |          |
| __Kernel__                     |              |                        |          |
|                                | ice(4)       |                        |          |
|                                | umb(4)       |                        |          |
|                                | ZFS          |                        | OpenZFS  |
| __Network Services__           |              |                        |          |
|                                | OpenSSH      | `crypto/openssh`       | OpenBSD  |
|                                | Unbound      | `crypto/unbound`       | OpenBSD  |
| __Security Infrastructure__    |              |                        |          |
|                                | BearSSL      | `contrib/bearssl`      | BearSSL  |
|                                | OpenSSL      | `crypto/openssl`       | OpenSSL  |
| __Test Infrastructure__        |              |                        |          |
|                                | ATF          |                        |          |
|                                | NetBSD tests |                        |          |
|                                | pjdfstest    |                        |          |
