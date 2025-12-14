#include <stdio.h>
#include "common.c"

int main(void)
{
	char version[16];

	snprintf(version, sizeof(version), "%d.%d.%d", cbor_major_version,
			cbor_minor_version, cbor_patch_version);
	version[sizeof(version) - 1] = '\0';
	return _report("System Libraries", "libcbor", version);
}
