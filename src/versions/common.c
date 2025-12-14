#include <stdio.h>

static int _report(char const * section, char const * name,
		char const * version)
{
	if(strlen(version) == 0)
	{
		fprintf(stderr, "%s: %s\n", name, "version not found");
		return 3;
	}
	printf("  - %s:\n", section);
	printf("    %s:\n", name);
	printf("      version: %s\n", version);
	return 0;
}
