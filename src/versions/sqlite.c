#include <sqlite3.h>
#include "common.c"

int main(void)
{
	_report("System Libraries", "SQLite", SQLITE_VERSION);
	return 0;
}
