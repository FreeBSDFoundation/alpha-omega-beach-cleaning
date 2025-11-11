#include <stdio.h>
#include <openssl/crypto.h>
#include "common.c"

int main(void)
{
	char version[16];

	snprintf(version, sizeof(version), "%u.%u.%u", OPENSSL_version_major(),
			OPENSSL_version_minor(), OPENSSL_version_patch());
	version[sizeof(version) - 1] = '\0';
	_report("Security Infrastructure", "OpenSSL", version);
	return 0;
}
