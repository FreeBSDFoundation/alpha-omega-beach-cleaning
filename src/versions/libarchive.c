#include <stdio.h>
#include <archive.h>

int main(void)
{
	int major, minor, revision;

	revision = ARCHIVE_VERSION_NUMBER % 1000;
	minor = ((ARCHIVE_VERSION_NUMBER - revision) / 1000) % 1000;
	major = (ARCHIVE_VERSION_NUMBER - (minor * 1000) - revision) / 1000000;
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "System Libraries");
	printf("    %s:\n", "libarchive");
	printf("    - version: %d.%d.%d\n", major, minor, revision);
	return 0;
}
