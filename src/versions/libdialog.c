#include <stdio.h>
#include <dialog.h>

int main(void)
{
	printf("%s\n", "Sections");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "libdialog");
	printf("    - version: %s\n", dialog_version());
	return 0;
}
