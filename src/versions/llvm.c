#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

int main(void)
{
	const char * progname = "llvm";
	const char * command = "/usr/bin/clang --version";
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
		if(sscanf(buf, "FreeBSD clang version %15[^ \n]\n", version) == 1)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	pclose(fp);
	return _report("Compilation Infrastructure", "LLVM", version);
}
