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

The list of third-party components can be generated with the tool developed for
the project:

```shell-session
$ make dependencies.md
cd src && bmake aobc-tool
go build   -o aobc-tool cmd/aobc-tool/aobc-tool.go
aobc-tool generate dependencies
$ cat dependencies.md
| Component | Directory | Upstream | Homepage |
| --- | --- | --- | --- |
| __Compilation Infrastructure__ | | | |
| bmake | `contrib/bmake` | NetBSD | https://www.NetBSD.org |
| byacc | `contrib/byacc` | invisible-island | https://invisible-island.net/byacc/ |
[...]
```

The `aobc-tool` itself and accompanying `Makefile` is available in the
[alpha-omega-beach-cleaning](https://github.com/FreeBSDFoundation/alpha-omega-beach-cleaning)
repository from the FreeBSD Foundation's GitHub organization.

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

The corresponding report was generated with the tool developed for the project,
as follows:

```shell-session
$ make security.md
cd src && bmake aobc-tool
go build   -o aobc-tool cmd/aobc-tool/aobc-tool.go
aobc-tool generate securityreview
$ cat security.md
| Component | Security impact | Score |
| --- | --- | --- |
| __Compilation Infrastructure__ | | |
| bmake | build | 1 |
| byacc | build | 1 |
[...]
```

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
3. Time allowing, providing tooling for code ownership, replacement for the
   `MAINTAINERS` file, metrics for version gaps, time since last import, test
   suite integration and coverage, distance from upstream, etc.

The initial list of priorities was generated with the tool developed for the
project, as illustrated here:

```shell-session
$ make plan.md
cd src && bmake aobc-tool
go build   -o aobc-tool cmd/aobc-tool/aobc-tool.go
aobc-tool generate plan
$ cat plan.md
| Component | Plan |
| --- | --- |
| __Compilation Infrastructure__ | |
| bmake | fix |
| byacc | fix |
[...]
$ grep -v ' fix ' plan.md
| Component | Plan |
| --- | --- |
| __Compilation Infrastructure__ | |
| Git | import |
| unifdef | fork |
| __Kernel__ | |
| ipfilter | fork |
| pf | fork |
| __System Libraries__ | |
| gdtoa | fork |
| libdialog | forego |
| libdiff | fork |
| __System Tools__ | |
| diff | fork |
| ee | fork |
| patch | fork |
| pkg | import |
| __Test Infrastructure__ | |
| ATF | fork |
| kyua | fork |
```

The plans listed above outside of Git, pkg, and pkgconf either document de-facto
situations ("fork") or reflect external events ("forego") that occurred during
this project.

### Code Owners

This project, its database and tooling have been presented to the respective
code owners identified, whom have all been contacted in December 2025.

The feedback received was very positive, with corrections made to the database
as requested by the developers contacted.

The original `MAINTAINERS` file, documenting a mix of internal and third-party
components, was found to be incomplete and stale - a known problem. Instead, the
capability to generate machine-readable reports in GitHub's CODEOWNERS file
format was added to `aobc-tool`, together with a companion `blame` command:

```shell-session
$ make CODEOWNERS
cd src && bmake aobc-tool
go build   -o aobc-tool cmd/aobc-tool/aobc-tool.go
aobc-tool generate codeowners
$ cat CODEOWNERS
# bmake
/contrib/bmake sjg@FreeBSD.org

# byacc
/contrib/byacc bapt@FreeBSD.org jkim@FreeBSD.org
[...]
$ ./src/aobc-tool blame contrib/byacc/btyaccpar.c
Owner(s) for byacc: (contrib/byacc/btyaccpar.c in contrib/byacc)
- bapt@
- jkim@
```

### Plan Execution: Import of spdxtool via pkgconf

The SBOM initiative has matured and has been confirmed as a new key component,
required in the next release of FreeBSD. The original draft pull-request offered
for this project has been used by the SBOM initiative to validate the prototype,
in particular regarding the granularity of the SBOM files: it is now expected to
match each binary component installed (e.g., from the `lib`, `bin`, `sbin`,
`usr.bin`, and `usr.sbin` sub-directories) where SBOM information is relevant
and available.

A [draft pull-request](https://github.com/freebsd/freebsd-src/pull/1994) was
opened on GitHub, documenting the project further
[here](https://github.com/freebsd/freebsd-src/pull/1994#issuecomment-3896743965)
and
[here](https://github.com/freebsd/freebsd-src/pull/1994#issuecomment-3980704283)
in response to the feedback received.

Further integration work is now needed before this pull-request can land into
FreeBSD's src repository, as `bomtool(1)` and `spdxtool(1)` need to be built as
part of the toolchain in addition to being shipped in the default system: they
are necessary as native tools, even when cross-compiling. This is in addition to
the actual handling of the SBOM meta-data, and corresponding updates to the
build system.

The spdxtool command itself is not available in any public release of pkgconf at
the time of this report; this is why the vendor import branch goes beyond the
latest release and includes this intermediate development status. The bomtool
command also implements more features this way than in the public release.

### Plan Execution: Import of pkg in the base system

After discussions between the release engineering team and developers of pkg, it
has become clear that importing pkg into the base system is the way forward.
This is due in great part to the ongoing "pkgbase" migration from sets to
individual packages for the installation and maintenance of the base system.
Work has begun on this task, following the regular procedure for vendor updates.

This is because the pace of development for pkg is necessarily decoupled from
that of the base system: packages are released every 3 months, and will require
fixes or features faster than the base system can offer them. For this reason,
pkg needs to gain the capability to delegate its operation to any updated
version installed as a package, as deemed necessary by the developers of pkg.
Once ready, this will effectively replace ("forego") the bootstrapping system.

In practice, [NetBSD](https://www.NetBSD.org/) already uses this mode of
operation with its equivalent `pkg_install` tool, which is believed to be
working well for that project, in a very similar situation.

This task is pending completion, with the current status available for review on
GitHub at <https://github.com/khorben/freebsd-src/tree/khorben/pkg-2.6.2> for
pkg's 2.6.2 release.

### Plan Execution: Additional Tooling

Different versions of FreeBSD include different versions of third-party
software. A single database file cannot easily cover the entire history of the
development, except for making it a relational database, complete with
timestamps and additional complexity.

Instead, for this project, we have tried to automate the collection of software
versions used in a working system. Over 50 individual programs have been written
(one per third-party component) with the simple goal to report the respective
versions. Unfortunately, this could not be completed in every situation, and
about 20 components do not report their respective versions this way.

On another hand, this helped with the implementation of a test suite for this
project, including a GitHub workflow running on a FreeBSD system:

```yaml
name: Re-generate the deliverables (FreeBSD)
[...]
jobs:
  test-all:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
[...]
    - name: Test in FreeBSD
      id: test
      uses: vmactions/freebsd-vm@v1
      with:
        usesh: true
        prepare: |
        

        run: |
          pkg install -y go go-yq pkgconf
          make CODEOWNERS dependencies.md plan.md security.md
          make pkgconfig spdx
          make versions.yml merge-versions
```

The following components could be implemented for the automated version check:

```shell-session
$ (cd src/versions && ls *.c)
acpi.c          less.c          ntp.c
awk.c           libarchive.c    openpam.c
bc.c            libc.c          openssh.c
bmake.c         libcbor.c       openssl.c
bsddialog.c     libdialog.c     patch.c
bsnmp.c         libedit.c       pkg.c
byacc.c         libevent.c      sendmail.c
bzip2.c         libexpat.c      sqlite.c
common.c        liblzma.c       tcpdump.c
diff.c          libmagic.c      tzdata.c
dma.c           libpcap.c       unbound.c
dtc.c           libxo.c         unifdef.c
flex.c          llvm.c          wireguard.c
heimdal.c       lua.c           wpa_supplicant.c
ipfilter.c      lyaml.c         zfs.c
kyua.c          mkuzip.c        zlib.c
ldns.c          ncurses.c       zstd.c
```

With these tools, the updated information can be merged into the database
file directly, with the `merge-versions` rule from the `Makefile`:

```makefile
merge-versions: $(OBJDIR)versions.yml
	@(yq eval-all 'select(fileIndex == 0) * select(fileindex == 1)' database.yml versions.yml)
```

This requires the installation of the Go implementation of `yq(1)`, as listed in
the GitHub workflow.

### Conclusion

First and foremost, this project has had a tremendous impact at coordinating the
security lifecycle of FreeBSD's base system with one of its most critical
components: OpenSSL. This is true for the 15.0 release, but will now also be
easier for future releases of FreeBSD and OpenSSL.

This work inspired the import of pkgconf and of pkg into the base system;
unfortunately neither task is fully completed as of the time of this report, but
reviews are ongoing and testing has validated both concepts.

Just as importantly, this initiative has blended perfectly with another project:
CRA compliance in the European Union and specifically, for the production of
SBOM artefacts for future releases of FreeBSD. This task is directly related to
the import of pkgconf, and has contributed greatly to the accuracy, reusability,
and completeness of the data gathered, tooling created, and testing performed
during this project.

Finally, we hope that as much as possible of this information and tooling will
make its way into the workflow of every user of FreeBSD, either directly as
developer or downstream user, or for consumers in and beyond the European
market. We are committed to continuing this work, for current and future
releases of FreeBSD.
