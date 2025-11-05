#include <stdio.h>
#include <bsddialog.h>

int main(void)
{
	printf("%s\n", "Sections");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "bsddialog");
	printf("    - version: %s\n", LIBBSDDIALOG_VERSION);
	return 0;
}
