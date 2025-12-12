#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

int main(void)
{
	const char * progname = "lyaml";
	const char * command = "/usr/libexec/flua -e \"print(require('lyaml')._VERSION)\"";
	FILE * fp;
	char buf[1024];
	int i;
	char version[16] = "";

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "yaml library for Lua %d.%d / %15[^ \n]",
					&i, &i, version) == 3)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	pclose(fp);
	if(strlen(version) == 0)
		return 3;
	_report("Internal", progname, version);
	return 0;
}
