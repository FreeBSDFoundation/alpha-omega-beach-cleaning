#include <stdio.h>
#include <zlib.h>

int main(void)
{
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "System Libraries");
	printf("    %s:\n", "zlib");
	printf("    - version: %s\n", ZLIB_VERSION);
	return 0;
}
