#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(void)
{
	const char * progname = "patch";
	const char * command = "patch --version";
	FILE * fp;
	char buf[1024];
	char * p;
	char version[16];

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "patch %15[^ \n]\n", version) == 1)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	fclose(fp);
	printf("%s\n", "Sections");
	printf("  - %s\n", "Compilation Infrastructure");
	printf("    %s\n", "patch");
	printf("    - version: %s\n", version);
	return 0;
}
