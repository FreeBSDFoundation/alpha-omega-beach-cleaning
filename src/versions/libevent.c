#include <sys/time.h>
#include <stdio.h>
#include <event.h>

int main(void)
{
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "System Libraries");
	printf("    %s:\n", "libevent");
	printf("    - version: %s\n", event_get_version());
	return 0;
}
