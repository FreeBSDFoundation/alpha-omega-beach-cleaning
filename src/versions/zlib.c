#include <zlib.h>
#include "common.c"

int main(void)
{
	return _report("Kernel", "zlib", ZLIB_VERSION);
}
