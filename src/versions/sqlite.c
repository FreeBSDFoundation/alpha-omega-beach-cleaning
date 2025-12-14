#include <sqlite3.h>
#include "common.c"

int main(void)
{
	return _report("System Libraries", "SQLite", SQLITE_VERSION);
}
