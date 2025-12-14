#include <stdio.h>
#include <edit/readline/readline.h>
#include "common.c"

int main(void)
{
	char version[16];

	snprintf(version, sizeof(version), "%d.%d",
			RL_READLINE_VERSION >> 8, RL_READLINE_VERSION & 0xff);
	version[sizeof(version) - 1] = '\0';
	return _report("System Libraries", "libedit", version);
}
