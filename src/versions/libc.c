#include <sys/utsname.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

#ifndef PROGNAME
# define PROGNAME	"libc"
#endif
#ifndef SECTION
# define SECTION	"Internal"
#endif

int main(void)
{
	const char * progname = PROGNAME;
	struct utsname u;
	char * p;

	if(uname(&u) != 0)
	{
		fprintf(stderr, "%s: uname: %s\n", progname, strerror(errno));
		return 2;
	}
	if((p = strchr(u.release, '-')) != NULL)
		*p = '\0';
	return _report(SECTION, PROGNAME, u.release);
}
