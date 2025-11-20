#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

int main(void)
{
	const char * progname = "tzdata";
	const char * filename = "/usr/share/zoneinfo/tzdata.zi";
	FILE * fp;
	char buf[1024];
	char * p;
	char * version = "";

	if((fp = fopen(filename, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, filename,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if((p = strstr(buf, "# version ")) != NULL)
		{
			version = p + 10;
			if((p = strchr(version, ' ')) != NULL)
				*p = '\0';
			break;
		}
	}
	fclose(fp);
	if(strlen(version) == 0)
		return 3;
	_report("System  Libraries", "Time Zone Database", version);
	return 0;
}
