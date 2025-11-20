#include <security/openpam_version.h>
#include "common.c"
#define STRINGIFY(x) #x
#define TO_STRING(x) STRINGIFY(x)

int main(void)
{
	_report("System Libraries", "OpenPAM", TO_STRING(OPENPAM_VERSION));
	return 0;
}
