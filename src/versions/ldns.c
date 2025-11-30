#include "common.c"

char const * ldns_version(void);

int main(void)
{
	_report("Network Libraries", "ldns", ldns_version());
	return 0;
}
