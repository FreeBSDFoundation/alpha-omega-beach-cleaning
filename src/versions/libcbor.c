#include <stdio.h>

int main(void)
{
	printf("%s\n", "Sections");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "libcbor");
	printf("    - version: %d.%d.%d\n", cbor_major_version,
			cbor_minor_version, cbor_patch_version);
	return 0;
}
