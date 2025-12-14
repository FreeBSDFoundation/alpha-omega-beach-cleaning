#include "common.c"

char const * ldns_version(void);

int main(void)
{
	return _report("Network Libraries", "ldns", ldns_version());
}
