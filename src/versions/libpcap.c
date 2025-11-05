#include <stdio.h>
#include <pcap.h>

int main(void)
{
#if defined(PCAP_AVAILABLE_1_10)
	printf("%s\n", "Components");
	printf("  - %s\n", "Network Libraries");
	printf("    %s\n", "libpcap");
	printf("    - version: 1.10.x\n");
#endif
	return 0;
}
