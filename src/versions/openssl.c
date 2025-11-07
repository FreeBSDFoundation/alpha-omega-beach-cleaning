#include <stdio.h>
#include <openssl/crypto.h>

int main(void)
{
	printf("%s:\n", "Sections");
	printf("  - %s:\n", "Security Infrastructure");
	printf("    %s:\n", "OpenSSL");
	printf("    - version: %u.%u.%u\n", OPENSSL_version_major(),
			OPENSSL_version_minor(), OPENSSL_version_patch());
	return 0;
}
