#include <stdio.h>
#include <edit/readline/readline.h>

int main(void)
{
	printf("%s\n", "Components");
	printf("  - %s\n", "System Libraries");
	printf("    %s\n", "libedit");
	printf("    - version: %d.%d\n",
			RL_READLINE_VERSION >> 8, RL_READLINE_VERSION & 0xff);
	return 0;
}
