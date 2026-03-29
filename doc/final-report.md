Alpha-Omega Beach Cleaning Project: FreeBSD
===========================================

Final Report
------------

### Chronology

Technical execution on the project started on June 18th 2025, with an urgent
task on a tight schedule: updating OpenSSL to version 3.5 in FreeBSD's src
repository, in time for the preparation of the coming major release, 15.0.

Once this task cleared, a broader vision and timeline for the execution of this
project could be elaborated, as per the following table:

| Phase                          | Start date | End date   | Status  |
| ------------------------------ | ---------- | ---------- | ------- |
| Inventory of dependencies      | 25/08/2025 | 07/09/2025 | Done    |
| Security risk assessments      | 08/09/2025 | 21/09/2025 | Done    |
| Propose list of priorities     | 22/09/2025 | 28/09/2025 | Done    |
| Plan the respective actions    | 29/09/2025 | 26/10/2025 | Done    |
| Formalize code owners          | 27/10/2025 | 30/11/2025 | Done    |
| Integrate review methodologies |      _continuous_      ||         |
| Plan execution & coordination  |      _continuous_      ||         |
| Final report                   | 09/03/2026 | 30/03/2026 |         |

Concretely, the "execution & coordination" phase led to the preparation of two
components for import ("fork") into the src repository: pkgconf (for SBOM
generation with spdxtool) and pkg (for the switch to pkgbase).

The corresponding milestones are presented in detail here.

### OpenSSL 3.5.0

FreeBSD supports two different implementations of the SSL security protocol:
[BearSSL](https://www.bearssl.org) and [OpenSSL](https://openssl-library.org).
In public releases, OpenSSL is the default implementation, and it is of critical
importance for the security of FreeBSD the Operating System, as well as to its
supporting infrastructure, and for third-party software running on FreeBSD.

In the wake of the [heartbleed vulnerability](https://heartbleed.com/), the
broader Open Source community finally understood how critical a component
OpenSSL is for the whole ecosystem. While the [Long-Term Support timeline of
OpenSSL](https://openssl-library.org/policies/releasestrat/index.html) (LTS) is
a great addition to the project, it also dictates which of its releases should
be integrated into FreeBSD's base system:

* OpenSSL 3.0 (LTS) will reach end-of-life on September 7th, 2026.
* OpenSSL 3.5 (LTS) will reach end-of-life on April 8th, 2030.
* FreeBSD 15 is expected to reach end-of-life in December 2030.

Importing version 3.5 is therefore necessary to reduce the window of
responsibility for the FreeBSD community, where it will have to maintain its own
fork of OpenSSL 3.5. It is expected to last about 8 months, as opposed to over
four years if OpenSSL had been kept at version 3.0 in the coming FreeBSD
release.

The core of this work was completed just in time for the planned schedule
towards the release of FreeBSD 15, on August 8th 2025:

* Vendor updates for OpenSSL have been simplified, including the generation and
  import of the new manual pages.
* Build capability on every hardware architecture supported by FreeBSD 15.0.
  was ensured: amd64, i386, arm64, arm, powerpc64, powerpc64le, riscv (64-bit)
* Build capability was also tested for legacy hardware architectures: powerpc
  (32-bit)
* The process was coordinated for testing by Netflix, through the
  [stabweek tag](https://wiki.freebsd.org/StabWeeks) procedure for the base
  system.
* Reviews were performed as usual in Phabricator, e.g., in
  [D51613](https://reviews.freebsd.org/D51613)

Additional reviews and fixes were supported through this initiative until the
end of August 2025, when the scope was broadened to FreeBSD's whole base system.

### Inventory of Dependencies

Lists of third-party software in FreeBSD already existed, but neither fully up
to date, nor in a machine-readable format. This opportunity resulted in the
elaboration of a single database file, in the YAML format, and to the creation
of tooling around it.

In practice, this task extended beyond its initial goal, thanks to contributions
from the SBOM initiative (Software Bill of Material). This was the result of
multiple contributing factors:

* Some of FreeBSD's software depends on third-party components, which themselves
  depend on core software from FreeBSD: all of FreeBSD's software had to be
  enumerated as a result.
* The SBOM initiative had to gather and verify additional information, sometimes
  beyond the scope of the project, such as precise licensing or copyright
  assignments.
* Subsequent tasks of this project were based on this database, and also
  contributed to its extension (e.g., code owners, security exposure...)

The initial tooling around the database was implemented in Go as `aobc-tool` and
extended with shell scripts, with the capability to generate the following
reports or operations:

* List of known maintainers for the whole system.
* List of distinct components for the whole system.
* Generation of SBOM information in the pkg-config file format, and SPDX file
  format version 2 and 3 (JSON-LD).
* Generation of the execution plan for this project.
* Evaluation of the security risk for third-party components.
* Identification of the maintainer of any part of the base system.

By the end of the project, over 1.000 distinct components were listed in the
database file, of which 73 are imports from third-party projects.

### Security Risk Assessments

The software identified in the third-party sources was rated according to a list
of metrics, given the impact on:

* Developer systems or on the build infrastructure.
* Integrity of the hardware or at the Operating System level (e.g., kernel or
  run-time component)
* Network exposure (e.g., client/server software) or otherwise increased attack
  surface (e.g., common compression/decompression routines)
* Security of operations at the Operating System level (e.g., hashing, PRNG...)
* Authentication capabilities (e.g., pluggable authentication modules...)
* User applications in a broader sense.

The most critical components identified through this classification were:

1. (Git,) libfido2, OpenSSL, (pkg,) WireGuard, zlib, and ZFS (score: 4)
2. ACPI, BearSSL, Kerberos, LLVM, libcbor, Lua, OpenPAM, OpenSSH, and zstd
   (score: 3)

Some components are listed between brackets, for the following reasons:

* Git has been identified as a missing component for the FreeBSD base system to
  effectively provide a complete, self-sufficient environment for developers of
  the base system. However, its availability as a binary package is still
  considered to be a suitable workaround. Alternatively, the simpler
  implementation [Got](https://gameoftrees.org) could offer a basic but
  functional alternative, and with a more suitable licensing model.
* Similarly, `pkg(8)`, the package manager for the system, is itself only
  available as a binary package; a bootstrap is provided for its initial
  installation. However, with the switch to packages as an installation and
  update mechanism for the base system, bootstrapping is no longer considered
  sufficient and pkg should be imported to the base system.

### List of Priorities

Given the observations made above, conversations and meetings were arranged with
three formal groups of the FreeBSD Project: releng (release engineering),
secteam (security response), and srcmgr (source management team for the base
system). As a result, the following list of priorities was established:

1. Support the SBOM initiative through the import of tooling around the SPDX
   file format, like `bomtool(1)` and now also `spdxtool(1)` from the pkgconf
   project, for the generation of SBOMs in the SPDX version 2 and 3 file
   formats, respectively.
2. Import the pkg project into the base system, effectively foregoing the
   bootstrap and replacing it with the regular `pkg(8)` binary instead.
3. Time allowing, providing metrics for version gaps, time since last import,
   test suite integration and coverage, distance from upstream, etc.

