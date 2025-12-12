#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "common.c"

int main(void)
{
	const char * progname = "heimdal";
	const char * command = "/usr/bin/krb5-config --version";
	FILE * fp;
	char buf[1024];
	int release;
	char version[16] = "";

	if((fp = popen(command, "r")) == NULL)
	{
		fprintf(stderr, "%s: %s: %s\n", progname, command,
				strerror(errno));
		return 2;
	}
	while(fgets(buf, sizeof(buf), fp) != NULL)
	{
		if(sscanf(buf, "Kerberos %d release %15[^ \n]\n", &release,
					version) == 2)
		{
			version[sizeof(version) - 1] = '\0';
			break;
		}
	}
	pclose(fp);
	if(strlen(version) == 0)
		return 3;
	_report("System Libraries", "Heimdal Kerberos", version);
	return 0;
}
