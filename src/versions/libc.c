#include <sys/utsname.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

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
	printf("%s:\n", "Sections");
	printf("  - %s:\n", SECTION);
	printf("    %s:\n", PROGNAME);
	printf("    - version: %s\n", u.release);
	return 0;
}
