#include <sys/time.h>
#include <event.h>
#include "common.c"

int main(void)
{
	return _report("System Libraries", "libevent", event_get_version());
}
