#include <stdio.h>
#include <archive.h>
#include "common.c"

int main(void)
{
	int major, minor, revision;
	char version[16];

	revision = ARCHIVE_VERSION_NUMBER % 1000;
	minor = ((ARCHIVE_VERSION_NUMBER - revision) / 1000) % 1000;
	major = (ARCHIVE_VERSION_NUMBER - (minor * 1000) - revision) / 1000000;
	snprintf(version, sizeof(version), "%d.%d.%d", major, minor, revision);
	version[sizeof(version) - 1] = '\0';
	_report("System Libraries", "libarchive", version);
	return 0;
}
