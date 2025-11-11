TARGETS	= $(OBJDIR)acpi$(EXEEXT) $(OBJDIR)awk$(EXEEXT) $(OBJDIR)bc$(EXEEXT) $(OBJDIR)bmake$(EXEEXT) $(OBJDIR)bsddialog$(EXEEXT) $(OBJDIR)byacc$(EXEEXT) $(OBJDIR)bzip2$(EXEEXT) $(OBJDIR)diff$(EXEEXT) $(OBJDIR)dma$(EXEEXT) $(OBJDIR)dtc$(EXEEXT) $(OBJDIR)file$(EXEEXT) $(OBJDIR)flex$(EXEEXT) $(OBJDIR)heimdal$(EXEEXT) $(OBJDIR)ipfilter$(EXEEXT) $(OBJDIR)ldns$(EXEEXT) $(OBJDIR)less$(EXEEXT) $(OBJDIR)libarchive$(EXEEXT) $(OBJDIR)libc$(EXEEXT) $(OBJDIR)libcbor$(EXEEXT) $(OBJDIR)libdialog$(EXEEXT) $(OBJDIR)libedit$(EXEEXT) $(OBJDIR)libevent$(EXEEXT) $(OBJDIR)liblzma$(EXEEXT) $(OBJDIR)libpcap$(EXEEXT) $(OBJDIR)libxo$(EXEEXT) $(OBJDIR)llvm$(EXEEXT) $(OBJDIR)mkuzip$(EXEEXT) $(OBJDIR)ncurses$(EXEEXT) $(OBJDIR)openssl$(EXEEXT) $(OBJDIR)patch$(EXEEXT) $(OBJDIR)pkg$(EXEEXT) $(OBJDIR)sendmail$(EXEEXT) $(OBJDIR)sqlite$(EXEEXT) $(OBJDIR)tcpdump$(EXEEXT) $(OBJDIR)unbound$(EXEEXT) $(OBJDIR)unifdef$(EXEEXT) $(OBJDIR)versions.yml $(OBJDIR)zfs$(EXEEXT) $(OBJDIR)zlib$(EXEEXT) $(OBJDIR)zstd$(EXEEXT)
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
BINDIR	= $(PREFIX)/bin
SBINDIR	= $(PREFIX)/sbin
CC	= cc
CPPFLAGSF=
CPPFLAGS=
CFLAGSF	=
CFLAGS	= -W -Wall -g -O2 -fstack-protector
LDFLAGS	= -Wl,-z,relro -Wl,-z,now
EXEEXT	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(OBJDIR)acpi$(EXEEXT) $(OBJDIR)awk$(EXEEXT) $(OBJDIR)bc$(EXEEXT) $(OBJDIR)bmake$(EXEEXT) $(OBJDIR)bsddialog$(EXEEXT) $(OBJDIR)byacc$(EXEEXT) $(OBJDIR)bzip2$(EXEEXT) $(OBJDIR)diff$(EXEEXT) $(OBJDIR)dma$(EXEEXT) $(OBJDIR)dtc$(EXEEXT) $(OBJDIR)file$(EXEEXT) $(OBJDIR)flex$(EXEEXT) $(OBJDIR)heimdal$(EXEEXT) $(OBJDIR)ipfilter$(EXEEXT) $(OBJDIR)ldns$(EXEEXT) $(OBJDIR)less$(EXEEXT) $(OBJDIR)libarchive$(EXEEXT) $(OBJDIR)libc$(EXEEXT) $(OBJDIR)libedit$(EXEEXT) $(OBJDIR)libevent$(EXEEXT) $(OBJDIR)liblzma$(EXEEXT) $(OBJDIR)libpcap$(EXEEXT) $(OBJDIR)libxo$(EXEEXT) $(OBJDIR)llvm$(EXEEXT) $(OBJDIR)mkuzip$(EXEEXT) $(OBJDIR)ncurses$(EXEEXT) $(OBJDIR)openssl$(EXEEXT) $(OBJDIR)patch$(EXEEXT) $(OBJDIR)pkg$(EXEEXT) $(OBJDIR)sendmail$(EXEEXT) $(OBJDIR)sqlite$(EXEEXT) $(OBJDIR)tcpdump$(EXEEXT) $(OBJDIR)unbound$(EXEEXT) $(OBJDIR)unifdef$(EXEEXT) $(OBJDIR)zfs$(EXEEXT) $(OBJDIR)zlib$(EXEEXT) $(OBJDIR)zstd$(EXEEXT)

acpi_OBJS = $(OBJDIR)acpi.o
acpi_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
acpi_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)acpi$(EXEEXT): $(acpi_OBJS)
	$(CC) -o $(OBJDIR)acpi$(EXEEXT) $(acpi_OBJS) $(acpi_LDFLAGS)

awk_OBJS = $(OBJDIR)awk.o
awk_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
awk_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)awk$(EXEEXT): $(awk_OBJS)
	$(CC) -o $(OBJDIR)awk$(EXEEXT) $(awk_OBJS) $(awk_LDFLAGS)

bc_OBJS = $(OBJDIR)bc.o
bc_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
bc_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)bc$(EXEEXT): $(bc_OBJS)
	$(CC) -o $(OBJDIR)bc$(EXEEXT) $(bc_OBJS) $(bc_LDFLAGS)

bmake_OBJS = $(OBJDIR)bmake.o
bmake_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
bmake_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)bmake$(EXEEXT): $(bmake_OBJS)
	$(CC) -o $(OBJDIR)bmake$(EXEEXT) $(bmake_OBJS) $(bmake_LDFLAGS)

bsddialog_OBJS = $(OBJDIR)bsddialog.o
bsddialog_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS) -isystem /usr/include/private/bsddialog
bsddialog_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)bsddialog$(EXEEXT): $(bsddialog_OBJS)
	$(CC) -o $(OBJDIR)bsddialog$(EXEEXT) $(bsddialog_OBJS) $(bsddialog_LDFLAGS)

byacc_OBJS = $(OBJDIR)byacc.o
byacc_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
byacc_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)byacc$(EXEEXT): $(byacc_OBJS)
	$(CC) -o $(OBJDIR)byacc$(EXEEXT) $(byacc_OBJS) $(byacc_LDFLAGS)

bzip2_OBJS = $(OBJDIR)bzip2.o
bzip2_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
bzip2_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)bzip2$(EXEEXT): $(bzip2_OBJS)
	$(CC) -o $(OBJDIR)bzip2$(EXEEXT) $(bzip2_OBJS) $(bzip2_LDFLAGS)

diff_OBJS = $(OBJDIR)diff.o
diff_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
diff_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)diff$(EXEEXT): $(diff_OBJS)
	$(CC) -o $(OBJDIR)diff$(EXEEXT) $(diff_OBJS) $(diff_LDFLAGS)

dma_OBJS = $(OBJDIR)dma.o
dma_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
dma_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)dma$(EXEEXT): $(dma_OBJS)
	$(CC) -o $(OBJDIR)dma$(EXEEXT) $(dma_OBJS) $(dma_LDFLAGS)

dtc_OBJS = $(OBJDIR)dtc.o
dtc_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
dtc_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)dtc$(EXEEXT): $(dtc_OBJS)
	$(CC) -o $(OBJDIR)dtc$(EXEEXT) $(dtc_OBJS) $(dtc_LDFLAGS)

file_OBJS = $(OBJDIR)file.o
file_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
file_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)file$(EXEEXT): $(file_OBJS)
	$(CC) -o $(OBJDIR)file$(EXEEXT) $(file_OBJS) $(file_LDFLAGS)

flex_OBJS = $(OBJDIR)flex.o
flex_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
flex_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)flex$(EXEEXT): $(flex_OBJS)
	$(CC) -o $(OBJDIR)flex$(EXEEXT) $(flex_OBJS) $(flex_LDFLAGS)

heimdal_OBJS = $(OBJDIR)heimdal.o
heimdal_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
heimdal_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)heimdal$(EXEEXT): $(heimdal_OBJS)
	$(CC) -o $(OBJDIR)heimdal$(EXEEXT) $(heimdal_OBJS) $(heimdal_LDFLAGS)

ipfilter_OBJS = $(OBJDIR)ipfilter.o
ipfilter_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
ipfilter_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)ipfilter$(EXEEXT): $(ipfilter_OBJS)
	$(CC) -o $(OBJDIR)ipfilter$(EXEEXT) $(ipfilter_OBJS) $(ipfilter_LDFLAGS)

ldns_OBJS = $(OBJDIR)ldns.o
ldns_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
ldns_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -lprivateldns

$(OBJDIR)ldns$(EXEEXT): $(ldns_OBJS)
	$(CC) -o $(OBJDIR)ldns$(EXEEXT) $(ldns_OBJS) $(ldns_LDFLAGS)

less_OBJS = $(OBJDIR)less.o
less_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
less_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)less$(EXEEXT): $(less_OBJS)
	$(CC) -o $(OBJDIR)less$(EXEEXT) $(less_OBJS) $(less_LDFLAGS)

libarchive_OBJS = $(OBJDIR)libarchive.o
libarchive_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libarchive_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libarchive$(EXEEXT): $(libarchive_OBJS)
	$(CC) -o $(OBJDIR)libarchive$(EXEEXT) $(libarchive_OBJS) $(libarchive_LDFLAGS)

libc_OBJS = $(OBJDIR)libc.o
libc_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libc_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libc$(EXEEXT): $(libc_OBJS)
	$(CC) -o $(OBJDIR)libc$(EXEEXT) $(libc_OBJS) $(libc_LDFLAGS)

libcbor_OBJS = $(OBJDIR)libcbor.o
libcbor_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libcbor_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -lprivatecbor

$(OBJDIR)libcbor$(EXEEXT): $(libcbor_OBJS)
	$(CC) -o $(OBJDIR)libcbor$(EXEEXT) $(libcbor_OBJS) $(libcbor_LDFLAGS)

libdialog_OBJS = $(OBJDIR)libdialog.o
libdialog_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libdialog_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -ldialog

$(OBJDIR)libdialog$(EXEEXT): $(libdialog_OBJS)
	$(CC) -o $(OBJDIR)libdialog$(EXEEXT) $(libdialog_OBJS) $(libdialog_LDFLAGS)

libedit_OBJS = $(OBJDIR)libedit.o
libedit_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libedit_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libedit$(EXEEXT): $(libedit_OBJS)
	$(CC) -o $(OBJDIR)libedit$(EXEEXT) $(libedit_OBJS) $(libedit_LDFLAGS)

libevent_OBJS = $(OBJDIR)libevent.o
libevent_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS) -isystem /usr/include/private/event1
libevent_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -lprivateevent1

$(OBJDIR)libevent$(EXEEXT): $(libevent_OBJS)
	$(CC) -o $(OBJDIR)libevent$(EXEEXT) $(libevent_OBJS) $(libevent_LDFLAGS)

liblzma_OBJS = $(OBJDIR)liblzma.o
liblzma_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
liblzma_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)liblzma$(EXEEXT): $(liblzma_OBJS)
	$(CC) -o $(OBJDIR)liblzma$(EXEEXT) $(liblzma_OBJS) $(liblzma_LDFLAGS)

libpcap_OBJS = $(OBJDIR)libpcap.o
libpcap_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libpcap_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libpcap$(EXEEXT): $(libpcap_OBJS)
	$(CC) -o $(OBJDIR)libpcap$(EXEEXT) $(libpcap_OBJS) $(libpcap_LDFLAGS)

libxo_OBJS = $(OBJDIR)libxo.o
libxo_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libxo_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libxo$(EXEEXT): $(libxo_OBJS)
	$(CC) -o $(OBJDIR)libxo$(EXEEXT) $(libxo_OBJS) $(libxo_LDFLAGS)

llvm_OBJS = $(OBJDIR)llvm.o
llvm_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
llvm_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)llvm$(EXEEXT): $(llvm_OBJS)
	$(CC) -o $(OBJDIR)llvm$(EXEEXT) $(llvm_OBJS) $(llvm_LDFLAGS)

mkuzip_OBJS = $(OBJDIR)mkuzip.o
mkuzip_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
mkuzip_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)mkuzip$(EXEEXT): $(mkuzip_OBJS)
	$(CC) -o $(OBJDIR)mkuzip$(EXEEXT) $(mkuzip_OBJS) $(mkuzip_LDFLAGS)

ncurses_OBJS = $(OBJDIR)ncurses.o
ncurses_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
ncurses_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)ncurses$(EXEEXT): $(ncurses_OBJS)
	$(CC) -o $(OBJDIR)ncurses$(EXEEXT) $(ncurses_OBJS) $(ncurses_LDFLAGS)

openssl_OBJS = $(OBJDIR)openssl.o
openssl_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
openssl_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -lcrypto

$(OBJDIR)openssl$(EXEEXT): $(openssl_OBJS)
	$(CC) -o $(OBJDIR)openssl$(EXEEXT) $(openssl_OBJS) $(openssl_LDFLAGS)

patch_OBJS = $(OBJDIR)patch.o
patch_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
patch_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)patch$(EXEEXT): $(patch_OBJS)
	$(CC) -o $(OBJDIR)patch$(EXEEXT) $(patch_OBJS) $(patch_LDFLAGS)

pkg_OBJS = $(OBJDIR)pkg.o
pkg_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
pkg_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)pkg$(EXEEXT): $(pkg_OBJS)
	$(CC) -o $(OBJDIR)pkg$(EXEEXT) $(pkg_OBJS) $(pkg_LDFLAGS)

sendmail_OBJS = $(OBJDIR)sendmail.o
sendmail_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
sendmail_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)sendmail$(EXEEXT): $(sendmail_OBJS)
	$(CC) -o $(OBJDIR)sendmail$(EXEEXT) $(sendmail_OBJS) $(sendmail_LDFLAGS)

sqlite_OBJS = $(OBJDIR)sqlite.o
sqlite_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS) -isystem /usr/include/private/sqlite3
sqlite_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)sqlite$(EXEEXT): $(sqlite_OBJS)
	$(CC) -o $(OBJDIR)sqlite$(EXEEXT) $(sqlite_OBJS) $(sqlite_LDFLAGS)

tcpdump_OBJS = $(OBJDIR)tcpdump.o
tcpdump_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
tcpdump_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)tcpdump$(EXEEXT): $(tcpdump_OBJS)
	$(CC) -o $(OBJDIR)tcpdump$(EXEEXT) $(tcpdump_OBJS) $(tcpdump_LDFLAGS)

unbound_OBJS = $(OBJDIR)unbound.o
unbound_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
unbound_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)unbound$(EXEEXT): $(unbound_OBJS)
	$(CC) -o $(OBJDIR)unbound$(EXEEXT) $(unbound_OBJS) $(unbound_LDFLAGS)

unifdef_OBJS = $(OBJDIR)unifdef.o
unifdef_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
unifdef_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)unifdef$(EXEEXT): $(unifdef_OBJS)
	$(CC) -o $(OBJDIR)unifdef$(EXEEXT) $(unifdef_OBJS) $(unifdef_LDFLAGS)

$(OBJDIR)versions.yml: all
	(./acpi; ./awk; ./bc; ./bmake; ./bsddialog; ./byacc; ./bzip2; ./diff; ./dma; ./dtc; ./file; ./flex; ./heimdal; ./ipfilter; ./ldns; ./less; ./libarchive; ./libc; ./libedit; ./libevent; ./liblzma; ./libpcap; ./libxo; ./mkuzip; ./ncurses; ./openssl; ./patch; ./pkg; ./sendmail; ./sqlite; ./tcpdump; ./unbound; ./unifdef; ./zfs; ./zlib; ./zstd) > versions.yml

zfs_OBJS = $(OBJDIR)zfs.o
zfs_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
zfs_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)zfs$(EXEEXT): $(zfs_OBJS)
	$(CC) -o $(OBJDIR)zfs$(EXEEXT) $(zfs_OBJS) $(zfs_LDFLAGS)

zlib_OBJS = $(OBJDIR)zlib.o
zlib_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
zlib_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)zlib$(EXEEXT): $(zlib_OBJS)
	$(CC) -o $(OBJDIR)zlib$(EXEEXT) $(zlib_OBJS) $(zlib_LDFLAGS)

zstd_OBJS = $(OBJDIR)zstd.o
zstd_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
zstd_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)zstd$(EXEEXT): $(zstd_OBJS)
	$(CC) -o $(OBJDIR)zstd$(EXEEXT) $(zstd_OBJS) $(zstd_LDFLAGS)

$(OBJDIR)acpi.o: acpi.c common.c
	$(CC) $(acpi_CFLAGS) -o $(OBJDIR)acpi.o -c acpi.c

$(OBJDIR)awk.o: awk.c common.c
	$(CC) $(awk_CFLAGS) -o $(OBJDIR)awk.o -c awk.c

$(OBJDIR)bc.o: bc.c common.c
	$(CC) $(bc_CFLAGS) -o $(OBJDIR)bc.o -c bc.c

$(OBJDIR)bmake.o: bmake.c common.c
	$(CC) $(bmake_CFLAGS) -o $(OBJDIR)bmake.o -c bmake.c

$(OBJDIR)bsddialog.o: bsddialog.c common.c
	$(CC) $(bsddialog_CFLAGS) -o $(OBJDIR)bsddialog.o -c bsddialog.c

$(OBJDIR)byacc.o: byacc.c common.c
	$(CC) $(byacc_CFLAGS) -o $(OBJDIR)byacc.o -c byacc.c

$(OBJDIR)bzip2.o: bzip2.c common.c
	$(CC) $(bzip2_CFLAGS) -o $(OBJDIR)bzip2.o -c bzip2.c

$(OBJDIR)diff.o: diff.c common.c
	$(CC) $(diff_CFLAGS) -o $(OBJDIR)diff.o -c diff.c

$(OBJDIR)dma.o: dma.c common.c
	$(CC) $(dma_CFLAGS) -o $(OBJDIR)dma.o -c dma.c

$(OBJDIR)dtc.o: dtc.c common.c
	$(CC) $(dtc_CFLAGS) -o $(OBJDIR)dtc.o -c dtc.c

$(OBJDIR)file.o: file.c common.c
	$(CC) $(file_CFLAGS) -o $(OBJDIR)file.o -c file.c

$(OBJDIR)flex.o: flex.c common.c
	$(CC) $(flex_CFLAGS) -o $(OBJDIR)flex.o -c flex.c

$(OBJDIR)heimdal.o: heimdal.c common.c
	$(CC) $(heimdal_CFLAGS) -o $(OBJDIR)heimdal.o -c heimdal.c

$(OBJDIR)ipfilter.o: ipfilter.c common.c
	$(CC) $(ipfilter_CFLAGS) -o $(OBJDIR)ipfilter.o -c ipfilter.c

$(OBJDIR)ldns.o: ldns.c common.c
	$(CC) $(ldns_CFLAGS) -o $(OBJDIR)ldns.o -c ldns.c

$(OBJDIR)less.o: less.c common.c
	$(CC) $(less_CFLAGS) -o $(OBJDIR)less.o -c less.c

$(OBJDIR)libarchive.o: libarchive.c common.c
	$(CC) $(libarchive_CFLAGS) -o $(OBJDIR)libarchive.o -c libarchive.c

$(OBJDIR)libc.o: libc.c common.c
	$(CC) $(libc_CFLAGS) -o $(OBJDIR)libc.o -c libc.c

$(OBJDIR)libcbor.o: libcbor.c common.c
	$(CC) $(libcbor_CFLAGS) -o $(OBJDIR)libcbor.o -c libcbor.c

$(OBJDIR)libdialog.o: libdialog.c common.c
	$(CC) $(libdialog_CFLAGS) -o $(OBJDIR)libdialog.o -c libdialog.c

$(OBJDIR)libedit.o: libedit.c common.c
	$(CC) $(libedit_CFLAGS) -o $(OBJDIR)libedit.o -c libedit.c

$(OBJDIR)libevent.o: libevent.c common.c
	$(CC) $(libevent_CFLAGS) -o $(OBJDIR)libevent.o -c libevent.c

$(OBJDIR)liblzma.o: liblzma.c common.c
	$(CC) $(liblzma_CFLAGS) -o $(OBJDIR)liblzma.o -c liblzma.c

$(OBJDIR)libpcap.o: libpcap.c common.c
	$(CC) $(libpcap_CFLAGS) -o $(OBJDIR)libpcap.o -c libpcap.c

$(OBJDIR)libxo.o: libxo.c common.c
	$(CC) $(libxo_CFLAGS) -o $(OBJDIR)libxo.o -c libxo.c

$(OBJDIR)llvm.o: llvm.c common.c
	$(CC) $(llvm_CFLAGS) -o $(OBJDIR)llvm.o -c llvm.c

$(OBJDIR)mkuzip.o: mkuzip.c libc.c
	$(CC) $(mkuzip_CFLAGS) -o $(OBJDIR)mkuzip.o -c mkuzip.c

$(OBJDIR)ncurses.o: ncurses.c common.c
	$(CC) $(ncurses_CFLAGS) -o $(OBJDIR)ncurses.o -c ncurses.c

$(OBJDIR)openssl.o: openssl.c common.c
	$(CC) $(openssl_CFLAGS) -o $(OBJDIR)openssl.o -c openssl.c

$(OBJDIR)patch.o: patch.c common.c
	$(CC) $(patch_CFLAGS) -o $(OBJDIR)patch.o -c patch.c

$(OBJDIR)pkg.o: pkg.c common.c
	$(CC) $(pkg_CFLAGS) -o $(OBJDIR)pkg.o -c pkg.c

$(OBJDIR)sendmail.o: sendmail.c common.c
	$(CC) $(sendmail_CFLAGS) -o $(OBJDIR)sendmail.o -c sendmail.c

$(OBJDIR)sqlite.o: sqlite.c common.c
	$(CC) $(sqlite_CFLAGS) -o $(OBJDIR)sqlite.o -c sqlite.c

$(OBJDIR)tcpdump.o: tcpdump.c common.c
	$(CC) $(tcpdump_CFLAGS) -o $(OBJDIR)tcpdump.o -c tcpdump.c

$(OBJDIR)unbound.o: unbound.c common.c
	$(CC) $(unbound_CFLAGS) -o $(OBJDIR)unbound.o -c unbound.c

$(OBJDIR)unifdef.o: unifdef.c common.c
	$(CC) $(unifdef_CFLAGS) -o $(OBJDIR)unifdef.o -c unifdef.c

$(OBJDIR)zfs.o: zfs.c common.c
	$(CC) $(zfs_CFLAGS) -o $(OBJDIR)zfs.o -c zfs.c

$(OBJDIR)zlib.o: zlib.c common.c
	$(CC) $(zlib_CFLAGS) -o $(OBJDIR)zlib.o -c zlib.c

$(OBJDIR)zstd.o: zstd.c common.c
	$(CC) $(zstd_CFLAGS) -o $(OBJDIR)zstd.o -c zstd.c

clean:
	$(RM) -- $(acpi_OBJS) $(awk_OBJS) $(bc_OBJS) $(bmake_OBJS) $(bsddialog_OBJS) $(byacc_OBJS) $(bzip2_OBJS) $(diff_OBJS) $(dma_OBJS) $(dtc_OBJS) $(file_OBJS) $(flex_OBJS) $(heimdal_OBJS) $(ipfilter_OBJS) $(ldns_OBJS) $(less_OBJS) $(libarchive_OBJS) $(libc_OBJS) $(libcbor_OBJS) $(libdialog_OBJS) $(libedit_OBJS) $(libevent_OBJS) $(liblzma_OBJS) $(libpcap_OBJS) $(libxo_OBJS) $(llvm_OBJS) $(mkuzip_OBJS) $(ncurses_OBJS) $(openssl_OBJS) $(patch_OBJS) $(pkg_OBJS) $(sendmail_OBJS) $(sqlite_OBJS) $(tcpdump_OBJS) $(unbound_OBJS) $(unifdef_OBJS) $(zfs_OBJS) $(zlib_OBJS) $(zstd_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

install: all

uninstall:

.PHONY: all clean distclean install uninstall
