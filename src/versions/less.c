#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(void)
{
	const char * progname = "less";
	const char * command = "/usr/bin/less --version";
	FILE * fp;
	char buf[1024];
	char version[16] = "";

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s:\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "less %15[^ \n]\n", version) == 1)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	fclose(fp);
	if(strlen(version) == 0)
		return 3;
	printf("%s:\n", "Sections:");
	printf("  - %s:\n", "System Tools");
	printf("    %s:\n", "less");
	printf("    - version: %s\n", version);
	return 0;
}
