#include <dialog.h>
#include "common.c"

int main(void)
{
	return _report("System Libraries", "libdialog", dialog_version());
}
