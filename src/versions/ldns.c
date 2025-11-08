#include <stdio.h>

char const * ldns_version(void);

int main(void)
{
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "Network Libraries");
	printf("    %s:\n", "ldns");
	printf("    - version: %s\n", ldns_version());
	return 0;
}
