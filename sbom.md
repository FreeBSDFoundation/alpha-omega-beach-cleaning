# FreeBSD SPDX Lite 3.0.1 classes

SPDX Lite version 3.0.1 requires several SPDX classes to available these are:


| Class/Property                           | Description                                                                         |
|------------------------------------------|-------------------------------------------------------------------------------------|
| [/Core/Agent]()                          | Represents an agent responsible for creating the document.                          |
| [/Core/CreationInfo]()                   | Contains information about the creation of the document, including date and author. |
| [/Core/Hash]()                           | Defines a hash value used to verify data integrity.                                 |
| [/Core/Relationship]()                   | Represents relationships between different SPDX elements.                           |
| [/Core/SpdxDocument]()                   | The main document containing all SPDX information.                                  |
| [/SimpleLicensing/LicenseExpression]()   | Represents a licensing expression used to describe software licenses.               |
| [/SimpleLicensing/SimpleLicensingText]() | Contains the text of a license.                                                     |
| [/Software/Sbom]()                       | Software Bill of Materials that lists the software components in use.               |
| [/Software/Package]()                    | Represents a package in the SBOM.                                                   |

## What information needs to be gathered
This data has to be available before SBOM can be generated.

|  Name                       | More info                                                     |
|-----------------------------|---------------------------------------------------------------|
| Whole SBOM license          | [FreeBSD Attorney text](#freebsd-attorney-text)               |
| Name for SBOM               | FreeBSD-src SBOM?                                             |
| SBOM type                   | Currently: `build`                                            |
| Copyright text for package  | Currently: `NOASSERTION`                                      |
| Download location           | [FreeBSD package download URI](#freebsd-package-download-uri) |
| Package homepage            |                                                               |
| Package name                |                                                               |
| Package version             | [FreeBSD package version](#freebsd-package-version)           |
| Package hash information    | Optional but for future proof can be necesery                 |
| SPDX License expression     |                                                               |
| License text                | Optional if SPDX license info is correct                      |
| Agent or Person information | Information whom have done document                           |
| Relationships               | Relationships between packages and licenses                   |

## Generating SPDX SBOM

An SPDX (Software Package Data Exchange) SBOM (Software Bill of Materials) is generated using [pkgconf]() by consuming `.pc` configuration files. These pkgconfig files contain metadata about software packages, including fields such as Name, Description, URL, Version, License, and Source.

An example `cat.pc` file might look like this:

```
Name: cat
Description: Concatenate and print files
URL: https://man.freebsd.org/cgi/man.cgi?query=cat&manpath=FreeBSD+15.0-RELEASE
Version: 15.0
License: BSD-3-Clause
Source: https://cgit.freebsd.org/src/tree/bin/cat?h=release/15.0.0
Requires: csu, libc, libcapsicum, libcasper, libcasper.services.cap_fileargs, libcasper.services.cap_net, libcompiler_rt
```

The fields in this file are converted into corresponding elements within the SPDX specification:

- The package information (Name, Description, URL, Version) is mapped to [/Software/Package]() class expression.
- The `Requires:` field specifies dependencies and is translated to `dependsOn` relationships in the [/Core/Relationship]() class.
- The `License:` field is converted into a licensing expression in [/SimpleLicensing/LicenseExpression]().

This structured format ensures comprehensive documentation of software components, their dependencies, and licensing details within an SPDX SBOM.

## Detailed class property documentation

# Class /Core/SpdxDocument
JSON-LD type: **SpdxDocument**

|  A  | Name                                        | More info         |
|:---:|:--------------------------------------------|-------------------|
| [x] | [creationInfo]()                            |                   |
| [x] | [dataLicense]()                             | [FreeBSD Attorney text](#freebsd-attorney-text) |
| [x] | [element]() ([/Software/Sbom]())            |                   |
| [x] | [name]()                                    | FreeBSD-src SBOM? |
| [x] | [rootElement](element) ([/Software/Sbom]()) |                   |
| [x] | [spdxId]()                                  | [FreeBSD SPDX ID](#freebsd-spdx-id) |

## /Core/SpdxDocument example JSON

```json
{
    "@type": "SpdxDocument",
    "creationInfo": "_:creationinfo_1",
    "dataLicense": "Disclaimer\n\nThe FreeBSD software and this Software Bill of Materials (SBOM) are provided to users “AS IS” and without warranty of any kind, whether express or implied, and the FreeBSD Project and the FreeBSD Foundation specifically disclaim any implied warranties of merchantability or fitness for a particular purpose or noninfringement therefor. Further, the FreeBSD Project and the FreeBSD Foundation do not warrant, guarantee, or make any representations regarding the use, or the results of the use, of the FreeBSD software, the SBOM or any other written materials in terms of correctness, accuracy, reliability, or otherwise.\n\nLimitation of Liability\n\nin addition, the FreeBSD Project and the FreeBSD Foundation shall not be responsible or liable with respect to any use of the FreeBSD software or SBOM or any documentation related thereto under any contract, negligence, strict liability or other theory for: (i) for loss or inaccuracy of data or cost of procurement of substitute goods, services or technology; (ii) any indirect, incidental or consequential damages including, but not limited to, loss of profits; or (iii) any matter beyond their reasonable control."
    "element": [
        urn:FreeBSD:SPDX:software:software_Sbom:FreeBSD
    ]
    "name": "FreeBSD-src SBOM"
    "rootElement": [
        urn:FreeBSD:SPDX:software:software_Sbom:FreeBSD
    ]
    "spdxId": "urn:FreeBSD:SPDX:Core:SpdxDocument:1",
}

```

# Class /Software/Sbom
JSON-LD type: **software_Sbom**

|  A  | Name                                           | More info         |
|:---:|:-----------------------------------------------|-------------------|
| [x] | [creationInfo]()                               |                   |
| [x] | [element]() ([/Software/Package]())            |                   |
| [x] | [rootElement](element) ([/Software/Package]()) |                   |
| [x] | [sbomType]()                                   |                   |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |

## /Software/Sbom example

```json
{
    "@type": "software_Sbom",
    "creationInfo": "_:creationinfo_1",
    "rootElement": [
        "urn:FreeBSD:SPDX:software:software_Package/cat"
    ],
    "element": [
        "urn:FreeBSD:SPDX:software:software_Package/cat"
    ],
    "software_sbomType": [
        "build"
    ],
    "spdxId": "urn:FreeBSD:SPDX:software:software_Sbom:cat"
},
```

# Class /Software/Package
JSON-LD type: **software_Package**.

* For every /Software/Package object MUST exist exactly one /Core/Relationship object of type hasConcludedLicense.
* For every /Software/Package object MUST exist exactly one /Core/Relationship object of type hasDeclaredLicense.

|  A  | Name                                           | More info         |
|:---:|:-----------------------------------------------|-------------------|
| [ ] | [builtTime]()                                  |                   |
| [ ] | [copyrightText]()                              | NOASSERTION       |
| [x] | [creationInfo]()                               |                   |
| [ ] | [downloadLocation]()                           | [FreeBSD package download URI](#freebsd-package-download-uri) |
| [x] | [homepage]()                                   | [FreeBSD package homepage URI](#freebsd-package-homepage-uri) |
| [x] | [name]()                                       |                   |
| [ ] | [packageVersion]()                             | [FreeBSD package version](#freebsd-package-version) |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |
| [x] | [suppliedBy]() ([/Core/Agent]())               |                   |

# Class /Software/Package example

```json
{
    "@type": "software_Package",
    "builtTime": "20260126T01:01:01Z",
    "creationInfo": "_:creationinfo_1",
    "name": "cat",
    "software_copyrightText": "NOASSERTION",
    "software_downloadLocation": "https://cgit.freebsd.org/src/tree/bin/cat?h=release/15.0.0",
    "software_homePage": "https://man.freebsd.org/cgi/man.cgi?query=cat&manpath=FreeBSD+15.0-RELEASE"
    "software_packageVersion": "15.0"
    "spdxId": "urn:FreeBSD:SPDX:software:software_Package/cat",
    "suppliedBy": [
        "urn:FreeBSD:Core:Agent:Default"
    ]
},
{
    "@type": "Relationship",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:SPDX:Core:Relationship:cat:hasDeclaredLicense",
    "from": "urn:FreeBSD:SPDX:software:software_Package:cat"
    "to": [
        "urn:FreeBSD:SPDXSimpleLicensing:simplelicensing_LicenseExpression:BSD-3-Clause"
    ],
    "relationshipType": "hasDeclaredLicense"
},
{
    "@type": "Relationship",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:SPDX:Core:Relationship:cat:hasConcludedLicense",
    "from": "urn:FreeBSD:SPDX:software:software_Package:cat"
    "to": [
        "urn:FreeBSD:SPDXSimpleLicensing:simplelicensing_LicenseExpression:BSD-3-Clause"
    ],
    "relationshipType": "hasConcludedLicense"
}

```

# Class /Core/Hash
JSON-LD type: For File-type it's **Hash** or for Package-type it's **PackageVerificationCode**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [ ] | [algorithm]()                                  | sha1 for Git compliance |
| [ ] | [hashValue]()                                  |                         |

# Class /Core/Hash example

```
{
      "@type" : "PackageVerificationCode",
      "algorithm" : "sha1",
      "hashValue" : "41acac4b846ee388cb6c1234f04489ccd5daa5a5"
}
```

or within Package

```json
{
    "@type": "software_Package",
    "builtTime": "20260126T01:01:01Z",
    "creationInfo": "_:creationinfo_1",
    "name": "cat",
    "software_copyrightText": "NOASSERTION",
    "software_downloadLocation": "https://cgit.freebsd.org/src/tree/bin/cat?h=release/15.0.0",
    "software_homePage": "https://man.freebsd.org/cgi/man.cgi?query=cat&manpath=FreeBSD+15.0-RELEASE"
    "software_packageVersion": "15.0"
    "spdxId": "urn:FreeBSD:SPDX:software:software_Package/cat",
    "suppliedBy": [
        "urn:FreeBSD:Core:Agent:Default"
    ],
    "verifiedUsing" [
		{
	        "@type" : "PackageVerificationCode",
		    "algorithm" : "sha1",
		    "hashValue" : "41acac4b846ee388cb6c1234f04489ccd5daa5a5"
		}
    ]
}
```

# Class /SimpleLicensing/LicenseExpression
JSON-LD type: For File-type it's **Hash** or for Package-type it's **PackageVerificationCode**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [x] | [creationInfo]()                               |                         |
| [x] | [licenseExpression]()                          | [SPDX License List]()   |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |


# Class /SimpleLicensing/LicenseExpression example

```
{
    "@type": "simplelicensing_LicenseExpression",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:SPDXSimpleLicensing:simplelicensing_LicenseExpression:BSD-3-Clause",
    "simplelicensing_licenseExpression": "BSD-3-Clause"
}
```

# Class /SimpleLicensing/SimpleLicensingText
JSON-LD type: For File-type it's **Hash** or for Package-type it's **PackageVerificationCode**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [x] | [creationInfo]()                               |                         |
| [x] | [licenseText]()                                |                         |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |

# Class /SimpleLicensing/LicenseExpression example

```
{
    "@type": "simplelicensing_LicenseExpression",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:SPDXSimpleLicensing:simplelicensing_licenseText:cat:1",
    "simplelicensing_licenseText": "Copyright (c) 1989, 1993\n     The Regents of the University of California.  All rights reserved.\n\nThis code is derived from software contributed to Berkeley by\nKevin Fall.\n\nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions\nare met:\n1. Redistributions of source code must retain the above copyright\n   notice, this list of conditions and the following disclaimer.\n2. Redistributions in binary form must reproduce the above copyright\n   notice, this list of conditions and the following disclaimer in the\n   documentation and/or other materials provided with the distribution.\n3. Neither the name of the University nor the names of its contributors\n   may be used to endorse or promote products derived from this software\n   without specific prior written permission.\n\nTHIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND\nANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE\nIMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE\nARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE\nFOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,\nEXEMPLARY, OR CONSEQUENTIAL\nDAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS\nOR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)\nHOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT\nLIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY\nOUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF\nSUCH DAMAGE."
}
```

# Class /Core/Agent
JSON-LD type: For machines and other agents type is **Agent** or for humans type is **Person**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [x] | [creationInfo]()                               | SHOULD be “BlankNode”   |
| [x] | [name]()                                       |                         |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |

# Class /Core/Agent example

```
{
    "@type": "Agent",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:Core:Agent:Default",
    "name": "Default"
}
```

# Class /Core/CreationInfo

JSON-LD type: For machines and other agents type is **Agent** or for humans type is **Person**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [x] | [created]()                                    | Date string is similar to: YYYY-MM-DDTHH:MM:SSZ or ISO-8601 formated date |
| [x] | [createdBy]()                                  |                         |
| [x] | [specVersion]()                                | SPDX version 3.0.1      |

# Class /Core/CreationInfo example
```
{
    "@type": "CreationInfo",
    "@id": "_:creationinfo_1",
    "created": "2026-01-22T09:30:01Z",
    "createdBy": [
        "urn:FreeBSD:Core:Agent:Default"
    ],
    "specVersion": "3.0.1"
}

```

# Class /Core/Relationship
JSON-LD type: **Relationship**

|  A  | Name                                           | More info               |
|:---:|:-----------------------------------------------|-------------------------|
| [x] | [creationInfo]()                               |                         |
| [x] | [from]()                                       |                         |
| [x] | [relationshipType]()                           |                         |
| [x] | [spdxId]()                                     | [FreeBSD SPDX ID](#freebsd-spdx-id) |
| [x] | [to]()                                         |                         |

# Class /Core/Relationship example

```
{
    "@type": "Relationship",
    "creationInfo": "_:creationinfo_1",
    "spdxId": "urn:FreeBSD:SPDX:Core:Relationship:cat:dependsOn",
    "from": "https://github.com/pkgconf/pkgconf/Package/cat",
    "to": [
        "urn:FreeBSD:SPDX:software:software_Package:csu"
    ],
    "relationshipType": "dependsOn"
},

```

## APPENDIX

# FreeBSD SPDX ID

With SPDX 3.0, the `spdxId` field has changed to type `xsd:anyURI`, which means that it should be a Uniform Resource Identifier (URI) such as:

- http://example.com
- mailto:example@example.com
- urn:example:org

As explained on the [URN Wikipedia page](https://en.wikipedia.org/wiki/Uniform_Resource_Name), a Uniform Resource Name (URN) is a type of URI that uses the `urn` scheme. URNs are globally unique persistent identifiers assigned within defined namespaces, intended to remain available for long periods even if the resource they identify ceases to exist or becomes unavailable.

FreeBSD's SPDX ID follows the URN scheme: `urn:FreeBSD:SPDX:model:class:identifier`

Examples:
- urn:FreeBSD:SPDX:Core:SpdxDocument:1
- urn:FreeBSD:SPDX:software:software_Package/cat
- urn:FreeBSD:SPDX:Core:Relationship:cat:dependsOn:csu

# FreeBSD Package Download URI

For third-party software, the download URI is neither the package version that's imported to FreeBSD nor a specific GIT commit. If there is significant divergence between the original third-party software and the one in the FreeBSD git repository, the source should be considered forked (see the Alpha-Omega Beach Cleaning Project for more information).

For software developed within FreeBSD, the download URI for packages typically points to the corresponding GIT location and tag where the package source can be downloaded. Examples include:

- https://cgit.freebsd.org/src/tree/bin/cat?h=release/15.0.0

# FreeBSD Package Homepage URI

The homepage for a package should not point to its man page location or, for third-party software, simply the URI for the official homepage.

# FreeBSD Package Version

For third-party software, the version is the upstream version number. For software developed within FreeBSD, it can be:

- A release tag like **15.0.0**
- A Git hash that it refers to
- For non-released branch builds: `<release_tag>.<git branch>.<short_commit_hash>` such as **15.0.0.fix_dri.abcef01234**

# FreeBSD Attorney text
> Disclaimer
>
> The FreeBSD software and this Software Bill of Materials (SBOM) are provided to users “AS IS” and without warranty of any kind, whether express or implied, and the FreeBSD Project and the FreeBSD Foundation specifically disclaim any implied warranties of merchantability or fitness for a particular purpose or  noninfringement therefor. Further, the FreeBSD Project and the FreeBSD Foundation do not warrant, guarantee, or make any representations regarding the use, or the results of the use, of the FreeBSD software, the SBOM or any other written materials in terms of correctness, accuracy, reliability, or otherwise. 
>
> Limitation of Liability
>
> in addition, the FreeBSD Project and the FreeBSD Foundation shall not be responsible or liable with respect to any use of the FreeBSD software or SBOM or any documentation related thereto under any contract, negligence, strict liability or other theory for: (i) for loss or inaccuracy of data or cost of procurement of substitute goods, services or technology; (ii) any indirect, incidental or consequential damages including, but not limited to, loss of profits; or (iii) any matter beyond their reasonable control.

[/Core/Agent]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Classes/Agent/
[/Core/CreationInfo]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Classes/CreationInfo/
[/Core/Hash]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Classes/Hash/
[/Core/Relationship]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Classes/Relationship/
[/Software/Sbom]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Classes/Sbom/
[/Core/SpdxDocument]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Classes/SpdxDocument/
[/Software/Sbom]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Classes/Sbom/
[/SimpleLicensing/LicenseExpression]: https://spdx.github.io/spdx-spec/v3.0.1/model/SimpleLicensing/Classes/LicenseExpression/
[/SimpleLicensing/SimpleLicensingText]: https://spdx.github.io/spdx-spec/v3.0.1/model/SimpleLicensing/Classes/SimpleLicensingText/
[/Software/Package]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Classes/Package/
[algorithm]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/algorithm/
[builtTime]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/builtTime/
[copyrightText]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/copyrightText/
[created]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/created/
[creationInfo]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/creationInfo/
[dataLicense]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/dataLicense/
[downloadLocation]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/downloadLocation/
[element]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/element/
[from]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/from/
[homepage]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/homePage/
[licenseExpression]: https://spdx.github.io/spdx-spec/v3.0.1/model/SimpleLicensing/Classes/LicenseExpression/
[licenseText]: https://spdx.github.io/spdx-spec/v3.0.1/model/SimpleLicensing/Properties/licenseText/
[name]: https://tutorialreference.com/xml/xsd/datatypes/xsd-datatype-string
[relationshipType]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/relationshipType/
[sbomType]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/sbomType/
[spdxId]: https://datypic.com/sc/xsd/t-xsd_anyURI.html
[to]: https://spdx.github.io/spdx-spec/v3.0.1/model/Core/Properties/to/
[packageVersion]: https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/packageVersion/
[URN Wikipedia]: https://en.wikipedia.org/wiki/Uniform_Resource_Name
[SPDX License List]: https://spdx.org/licenses/
[pkgconf]: https://github.com/pkgconf/pkgconf