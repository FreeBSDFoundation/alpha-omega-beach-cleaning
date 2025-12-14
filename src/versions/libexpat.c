#include <stdio.h>
#include <bsdxml.h>
#include "common.c"

int main(void)
{
	XML_Expat_Version xev;
	char version[16];

	xev = XML_ExpatVersionInfo();
	snprintf(version, sizeof(version), "%u.%u.%u",
			xev.major, xev.minor, xev.micro);
	version[sizeof(version) - 1] = '\0';
	return _report("System Libraries", "libexpat", version);
}
