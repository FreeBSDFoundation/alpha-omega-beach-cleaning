#include <stdio.h>
#include <bsnmp/asn1.h>
#include <bsnmp/snmp.h>
#include "common.c"

int main(void)
{
	char version[16];

	snprintf(version, sizeof(version), "%u.%u", BSNMP_MAJOR, BSNMP_MINOR);
	version[sizeof(version) - 1] = '\0';
	_report("Network Libraries", "bsnmp", version);
	return 0;
}
