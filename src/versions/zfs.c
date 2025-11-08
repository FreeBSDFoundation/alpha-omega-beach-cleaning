#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(void)
{
	const char * progname = "zfs";
	const char * command = "zfs version";
	FILE * fp;
	char buf[1024];
	char version[32] = "";

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "zfs-%31[^ \n]\n", version) == 1)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	fclose(fp);
	if(strlen(version) == 0)
		return 3;
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "Kernel");
	printf("    %s:\n", "zfs");
	printf("    - version: %s\n", version);
	return 0;
}
