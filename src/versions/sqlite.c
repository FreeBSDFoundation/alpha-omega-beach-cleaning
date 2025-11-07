#include <stdio.h>
#include <sqlite3.h>

int main(void)
{
	printf("%s\n", "Sections");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "SQLite");
	printf("    - version: %s\n", SQLITE_VERSION);
	return 0;
}
