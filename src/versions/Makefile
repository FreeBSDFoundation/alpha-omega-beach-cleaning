TARGETS	= $(OBJDIR)bsddialog$(EXEEXT) $(OBJDIR)byacc$(EXEEXT) $(OBJDIR)bzip2$(EXEEXT) $(OBJDIR)file$(EXEEXT) $(OBJDIR)libarchive$(EXEEXT) $(OBJDIR)libcbor$(EXEEXT) $(OBJDIR)libdialog$(EXEEXT) $(OBJDIR)libedit$(EXEEXT) $(OBJDIR)libevent$(EXEEXT) $(OBJDIR)libpcap$(EXEEXT) $(OBJDIR)ncurses$(EXEEXT) $(OBJDIR)patch$(EXEEXT) $(OBJDIR)tcpdump$(EXEEXT) $(OBJDIR)versions.yml
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
BINDIR	= $(PREFIX)/bin
SBINDIR	= $(PREFIX)/sbin
EXEEXT	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(OBJDIR)bsddialog$(EXEEXT) $(OBJDIR)byacc$(EXEEXT) $(OBJDIR)bzip2$(EXEEXT) $(OBJDIR)file$(EXEEXT) $(OBJDIR)libarchive$(EXEEXT) $(OBJDIR)libedit$(EXEEXT) $(OBJDIR)libevent$(EXEEXT) $(OBJDIR)libpcap$(EXEEXT) $(OBJDIR)ncurses$(EXEEXT) $(OBJDIR)patch$(EXEEXT) $(OBJDIR)tcpdump$(EXEEXT)

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

file_OBJS = $(OBJDIR)file.o
file_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
file_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)file$(EXEEXT): $(file_OBJS)
	$(CC) -o $(OBJDIR)file$(EXEEXT) $(file_OBJS) $(file_LDFLAGS)

libarchive_OBJS = $(OBJDIR)libarchive.o
libarchive_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libarchive_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libarchive$(EXEEXT): $(libarchive_OBJS)
	$(CC) -o $(OBJDIR)libarchive$(EXEEXT) $(libarchive_OBJS) $(libarchive_LDFLAGS)

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

libpcap_OBJS = $(OBJDIR)libpcap.o
libpcap_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
libpcap_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libpcap$(EXEEXT): $(libpcap_OBJS)
	$(CC) -o $(OBJDIR)libpcap$(EXEEXT) $(libpcap_OBJS) $(libpcap_LDFLAGS)

ncurses_OBJS = $(OBJDIR)ncurses.o
ncurses_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
ncurses_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)ncurses$(EXEEXT): $(ncurses_OBJS)
	$(CC) -o $(OBJDIR)ncurses$(EXEEXT) $(ncurses_OBJS) $(ncurses_LDFLAGS)

patch_OBJS = $(OBJDIR)patch.o
patch_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
patch_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)patch$(EXEEXT): $(patch_OBJS)
	$(CC) -o $(OBJDIR)patch$(EXEEXT) $(patch_OBJS) $(patch_LDFLAGS)

tcpdump_OBJS = $(OBJDIR)tcpdump.o
tcpdump_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
tcpdump_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)tcpdump$(EXEEXT): $(tcpdump_OBJS)
	$(CC) -o $(OBJDIR)tcpdump$(EXEEXT) $(tcpdump_OBJS) $(tcpdump_LDFLAGS)

$(OBJDIR)versions.yml: bsddialog byacc bzip2 file libarchive libedit libevent libpcap ncurses patch tcpdump
	(./bsddialog; ./byacc; ./bzip2; ./file; ./libarchive; ./libedit; ./libevent; ./libpcap; ./ncurses; ./patch; ./tcpdump) > versions.yml

$(OBJDIR)bsddialog.o: bsddialog.c
	$(CC) $(bsddialog_CFLAGS) -o $(OBJDIR)bsddialog.o -c bsddialog.c

$(OBJDIR)byacc.o: byacc.c
	$(CC) $(byacc_CFLAGS) -o $(OBJDIR)byacc.o -c byacc.c

$(OBJDIR)bzip2.o: bzip2.c
	$(CC) $(bzip2_CFLAGS) -o $(OBJDIR)bzip2.o -c bzip2.c

$(OBJDIR)file.o: file.c
	$(CC) $(file_CFLAGS) -o $(OBJDIR)file.o -c file.c

$(OBJDIR)libarchive.o: libarchive.c
	$(CC) $(libarchive_CFLAGS) -o $(OBJDIR)libarchive.o -c libarchive.c

$(OBJDIR)libcbor.o: libcbor.c
	$(CC) $(libcbor_CFLAGS) -o $(OBJDIR)libcbor.o -c libcbor.c

$(OBJDIR)libdialog.o: libdialog.c
	$(CC) $(libdialog_CFLAGS) -o $(OBJDIR)libdialog.o -c libdialog.c

$(OBJDIR)libedit.o: libedit.c
	$(CC) $(libedit_CFLAGS) -o $(OBJDIR)libedit.o -c libedit.c

$(OBJDIR)libevent.o: libevent.c
	$(CC) $(libevent_CFLAGS) -o $(OBJDIR)libevent.o -c libevent.c

$(OBJDIR)libpcap.o: libpcap.c
	$(CC) $(libpcap_CFLAGS) -o $(OBJDIR)libpcap.o -c libpcap.c

$(OBJDIR)ncurses.o: ncurses.c
	$(CC) $(ncurses_CFLAGS) -o $(OBJDIR)ncurses.o -c ncurses.c

$(OBJDIR)patch.o: patch.c
	$(CC) $(patch_CFLAGS) -o $(OBJDIR)patch.o -c patch.c

$(OBJDIR)tcpdump.o: tcpdump.c
	$(CC) $(tcpdump_CFLAGS) -o $(OBJDIR)tcpdump.o -c tcpdump.c

clean:
	$(RM) -- $(bsddialog_OBJS) $(byacc_OBJS) $(bzip2_OBJS) $(file_OBJS) $(libarchive_OBJS) $(libcbor_OBJS) $(libdialog_OBJS) $(libedit_OBJS) $(libevent_OBJS) $(libpcap_OBJS) $(ncurses_OBJS) $(patch_OBJS) $(tcpdump_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

install: all

uninstall:

.PHONY: all clean distclean install uninstall
