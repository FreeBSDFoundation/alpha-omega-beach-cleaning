#include <stdio.h>

static void _report(char const * section, char const * name,
		char const * version)
{
	printf("  - %s:\n", section);
	printf("    %s:\n", name);
	printf("    - version: %s\n", version);
}
