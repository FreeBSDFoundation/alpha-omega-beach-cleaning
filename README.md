# Alpha-Omega Beach Cleaning Project

[Alpha-Omega](https://alpha-omega.dev) (AO) is an associated project of the
[OpenSSF](https://openssf.org), established in February 2022. Its mission is to
protect society by catalyzing sustainable security improvements to the most
critical open source software projects and ecosystems.

FreeBSD is the most commonly used BSD-derived operating system. It is a complete
system, delivering a kernel, device drivers, userland utilities, and
documentation. Much of its codebase has become an integral part of popular and
critical products and services globally.

FreeBSD was granted funding by AO, under the "Beach Cleaning Project" umbrella,
for the purpose of improving the security and maintenance of third-party
software within the FreeBSD base system.

## Objectives

The objectives of this project include:

* Establishing a list of the different dependencies in the base system,
* Assessing the corresponding security risk and posture,
* Integrating tools for open source intelligence, (e.g., from
  [ecosyste.ms](https://ecosyste.ms))
* Assigning priorities for the components most at risk,
* Formalizing their respective owners in the FreeBSD project,
* Fixing, forking, or foregoing components and vulnerabilities.

## Timeline

The current timeline is set as follows:

| Phase                          | Start date | End date   | Status      | Notes                             |
| ------------------------------ | ---------- | ---------- | ----------- | --------------------------------- |
| Inventory of dependencies      | 25/08/2025 | 07/09/2025 | Done        | [Deliverable](dependencies.md)    |
| Security risk assessments      | 08/09/2025 | 21/09/2025 | Done        | [Deliverable](security.md)        |
| Propose list of priorities     | 22/09/2025 | 28/09/2025 | In progress | Continuous review and adjustments |
| Plan the respective actions    | 29/09/2025 | 26/10/2025 | Done        | [Deliverable](plan.md)            |
| Formalize code owners          | 27/10/2025 | 30/11/2025 |             | [Deliverable](owners.md)          |
| Integrate review methodologies |      _continuous_      ||             | See [^1]                          |
| Plan execution & coordination  |      _continuous_      ||             |                                   |
| Final report                   | 09/03/2026 | 30/03/2026 |             |                                   |

[^1]: [ecosyste.ms](https://ecosyste.ms)

## Reporting

Monthly reports are submitted to the Alpha-Omega project:

* [2025](https://github.com/ossf/alpha-omega/tree/main/alpha/engagements/2025/FreeBSD)

## This repository

### Database file

First, the file `database.yml` contains information about the components found
within a FreeBSD base system. The focus was initially on third-party components
(e.g., as found in `contrib` and `crypto`) until it became clear that collecting
dependency information requires listing FreeBSD's own components as well.

For each component identified, it lists:
* Name and description
* Homepage and source repositories
* Software licence
* Directory within FreeBSD's source tree
* Dependencies identified
* Developers or teams in charge
* Plan for the future evolution (if relevant)

### Tooling

Three more components can be found in this repository.

#### The Go program, `aobc-tool`

```shell-session
$ ./src/aobc-tool
Usage: aobc-tool generate [report]
       aobc-tool blame path...
```

Its `generate` command uses the database information to generate the following
reports:

* `codeowners`: a `CODEOWNERS` file, in the format expected by GitHub
* `dependencies`: the `dependencies.md` deliverable described above
* `pkgconfig`: a `pkgconfig` directory with one file per component in the
  `pkg-config` format
* `plan`: the `plan.md` deliverable described above
* `securityreview`: the `security.md` file described above

The `Makefile` offers a target with the name of the destination file (or folder)
for each report.

Its `blame` command uses the database information to identify the developers or
teams in charge of a specific component in the source tree:

```shell-session
$ aobc-tool blame contrib/llvm-project/lldb
Owner(s) for LLVM: (contrib/llvm-project/lldb in contrib/llvm-project)
- dim@
- emaste@
- jhb@
$ aobc-tool blame usr.sbin/pkg
Owner(s) for pkg: (usr.sbin/pkg in usr.sbin/pkg)
- #pkg
```

#### Version information programs

The collection of programs found in `src/versions` obtains version information
for their respective component of the same name. The version information
collected is output in the same format as the database file, suitable for
merging programmatically.

The `Makefile` offers a target for gathering that information, `versions.yml`,
which creates a consolidated report with the same name.

If the package `go-yq` is installed and exposes its `yq` command in the user's
`PATH`, the `merge-versions` target can be used to attempt to merge the version
information.  The resulting report is currently provided on the standard output.

#### SPDX generation

The `pkgconfig` files created above are meant not for use when compiling
programs, but for tracking version information and the respective dependencies.
In turn, they can be consumed by the `bomtool` program from the pkgconf project,
in order to generate SBOM files (Software Bill of Material) in the SPDX format.

The shell script in `tools/spdx.sh` does exactly that, as called by the `spdx`
target in the `Makefile`. This target creates a `spdx` folder, populated with
one file per `.pc` file in the `pkgconfig` folder.
