#include <stdio.h>
#include <curses.h>

int main(void)
{
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "System Libraries");
	printf("    %s:\n", "ncurses");
	printf("    - version: %s\n", NCURSES_VERSION);
	return 0;
}
