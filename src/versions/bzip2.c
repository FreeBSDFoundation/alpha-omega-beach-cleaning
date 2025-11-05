#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(void)
{
	const char * progname = "bzip2";
	const char * filename = "/usr/include/bzlib.h";
	FILE * fp;
	char buf[1024];
	char * p;
	char * version;

	if((fp = fopen(filename, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, filename,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if((p = strstr(buf, " version ")) != NULL)
		{
			version = p + 9;
			if((p = strchr(version, ' ')) != NULL)
				*p = '\0';
			break;
		}
	}
	fclose(fp);
	printf("%s\n", "Sections");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "bzip2");
	printf("    - version: %s\n", version);
	return 0;
}
