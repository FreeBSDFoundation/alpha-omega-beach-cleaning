#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

int main(void)
{
	const char * progname = "diff";
	const char * command = "/usr/bin/diff --version";
	FILE * fp;
	char buf[1024];
	char version[16] = "";

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "FreeBSD diff %15[^ \n]\n", version) == 1)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	fclose(fp);
	if(strlen(version) == 0)
		return 3;
	_report("System Tools", progname, version);
	return 0;
}
