PACKAGE	= alpha-omega-beach-cleaning
VERSION	= 20250922
VENDOR	= FreeBSD-Foundation
SUBDIRS	= src
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
MKDIR	= mkdir -m 0755 -p
INSTALL	= install
RM	= rm -f
TARGETS	= $(OBJDIR)dependencies.md format merge-versions $(OBJDIR)plan.md $(OBJDIR)security.md spdx $(OBJDIR)versions.yml
RM	= rm -f
LN	= ln -f
TAR	= tar
TGZEXT	= .tar.gz
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: subdirs $(OBJDIR)dependencies.md $(OBJDIR)plan.md $(OBJDIR)security.md

subdirs:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		([ -d "$(OBJDIR)$$i" ] || $(MKDIR) -- "$(OBJDIR)$$i") && \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/"; \
		else $(MAKE); fi) || exit; done

$(OBJDIR)dependencies.md: $(OBJDIR)src/aobc-generate database.yml
	$(OBJDIR)src/aobc-generate

format:
	go fmt src/cmd/aobc-generate/aobc-generate.go

merge-versions: versions.yml
	(yq eval-all 'select(fileIndex == 0) * select(fileindex == 1)' database.yml versions.yml)

$(OBJDIR)plan.md: $(OBJDIR)src/aobc-generate database.yml
	$(OBJDIR)src/aobc-generate

$(OBJDIR)security.md: $(OBJDIR)src/aobc-generate database.yml
	$(OBJDIR)src/aobc-generate

spdx: dependencies.md security.md tools/spdx.sh
	./tools/spdx.sh -P "$(PREFIX)" -- "spdx"

$(OBJDIR)versions.yml: all
	(cd src/versions; echo "Sections:"; ./bmake; ./byacc; ./dtc; ./unifdef; ./libc; ./lyaml; ./mkuzip; ./acpi; ./ipfilter; ./zfs; ./zstd; ./bsnmp; ./ldns; ./libpcap; ./dma; ./ntp; ./openssh; ./sendmail; ./unbound; ./wireguard; ./wpa_supplicant; ./tcpdump; ./openssl; ./bsddialog; ./bzip2; ./flex; ./heimdal; ./libarchive; ./libedit; ./libevent; ./libexpat; ./liblzma; ./libxo; ./file; ./ncurses; ./openpam; ./sqlite; ./tzdata; ./zlib; ./awk; ./bc; ./diff; ./less; ./lua; ./patch; ./pkg; ./kyua) > versions.yml

clean:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" clean; \
		else $(MAKE) clean; fi) || exit; done
	./tools/spdx.sh -c -P "$(PREFIX)" -- "spdx"

distclean:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" distclean; \
		else $(MAKE) distclean; fi) || exit; done
	./tools/spdx.sh -c -P "$(PREFIX)" -- "spdx"
	$(RM) -- $(OBJDIR)dependencies.md $(OBJDIR)plan.md $(OBJDIR)security.md $(OBJDIR)versions.yml

dist:
	$(RM) -r -- $(OBJDIR)$(PACKAGE)-$(VERSION)
	$(LN) -s -- "$$PWD" $(OBJDIR)$(PACKAGE)-$(VERSION)
	@cd $(OBJDIR). && $(TAR) -czvf $(PACKAGE)-$(VERSION)$(TGZEXT) -- \
		$(PACKAGE)-$(VERSION)/src/cmd/aobc-generate/aobc-generate.go \
		$(PACKAGE)-$(VERSION)/src/Makefile \
		$(PACKAGE)-$(VERSION)/src/go.mod \
		$(PACKAGE)-$(VERSION)/src/go.sum \
		$(PACKAGE)-$(VERSION)/src/project.conf \
		$(PACKAGE)-$(VERSION)/src/versions/acpi.c \
		$(PACKAGE)-$(VERSION)/src/versions/awk.c \
		$(PACKAGE)-$(VERSION)/src/versions/bc.c \
		$(PACKAGE)-$(VERSION)/src/versions/bmake.c \
		$(PACKAGE)-$(VERSION)/src/versions/bsddialog.c \
		$(PACKAGE)-$(VERSION)/src/versions/bsnmp.c \
		$(PACKAGE)-$(VERSION)/src/versions/byacc.c \
		$(PACKAGE)-$(VERSION)/src/versions/bzip2.c \
		$(PACKAGE)-$(VERSION)/src/versions/diff.c \
		$(PACKAGE)-$(VERSION)/src/versions/dma.c \
		$(PACKAGE)-$(VERSION)/src/versions/dtc.c \
		$(PACKAGE)-$(VERSION)/src/versions/file.c \
		$(PACKAGE)-$(VERSION)/src/versions/flex.c \
		$(PACKAGE)-$(VERSION)/src/versions/heimdal.c \
		$(PACKAGE)-$(VERSION)/src/versions/ipfilter.c \
		$(PACKAGE)-$(VERSION)/src/versions/kyua.c \
		$(PACKAGE)-$(VERSION)/src/versions/ldns.c \
		$(PACKAGE)-$(VERSION)/src/versions/less.c \
		$(PACKAGE)-$(VERSION)/src/versions/libarchive.c \
		$(PACKAGE)-$(VERSION)/src/versions/libc.c \
		$(PACKAGE)-$(VERSION)/src/versions/libcbor.c \
		$(PACKAGE)-$(VERSION)/src/versions/libdialog.c \
		$(PACKAGE)-$(VERSION)/src/versions/libedit.c \
		$(PACKAGE)-$(VERSION)/src/versions/libevent.c \
		$(PACKAGE)-$(VERSION)/src/versions/libexpat.c \
		$(PACKAGE)-$(VERSION)/src/versions/liblzma.c \
		$(PACKAGE)-$(VERSION)/src/versions/libpcap.c \
		$(PACKAGE)-$(VERSION)/src/versions/libxo.c \
		$(PACKAGE)-$(VERSION)/src/versions/llvm.c \
		$(PACKAGE)-$(VERSION)/src/versions/lua.c \
		$(PACKAGE)-$(VERSION)/src/versions/lyaml.c \
		$(PACKAGE)-$(VERSION)/src/versions/mkuzip.c \
		$(PACKAGE)-$(VERSION)/src/versions/ncurses.c \
		$(PACKAGE)-$(VERSION)/src/versions/ntp.c \
		$(PACKAGE)-$(VERSION)/src/versions/openpam.c \
		$(PACKAGE)-$(VERSION)/src/versions/openssh.c \
		$(PACKAGE)-$(VERSION)/src/versions/openssl.c \
		$(PACKAGE)-$(VERSION)/src/versions/patch.c \
		$(PACKAGE)-$(VERSION)/src/versions/pkg.c \
		$(PACKAGE)-$(VERSION)/src/versions/sendmail.c \
		$(PACKAGE)-$(VERSION)/src/versions/sqlite.c \
		$(PACKAGE)-$(VERSION)/src/versions/tcpdump.c \
		$(PACKAGE)-$(VERSION)/src/versions/tzdata.c \
		$(PACKAGE)-$(VERSION)/src/versions/unbound.c \
		$(PACKAGE)-$(VERSION)/src/versions/unifdef.c \
		$(PACKAGE)-$(VERSION)/src/versions/wireguard.c \
		$(PACKAGE)-$(VERSION)/src/versions/wpa_supplicant.c \
		$(PACKAGE)-$(VERSION)/src/versions/zfs.c \
		$(PACKAGE)-$(VERSION)/src/versions/zlib.c \
		$(PACKAGE)-$(VERSION)/src/versions/zstd.c \
		$(PACKAGE)-$(VERSION)/src/versions/Makefile \
		$(PACKAGE)-$(VERSION)/src/versions/common.c \
		$(PACKAGE)-$(VERSION)/src/versions/project.conf \
		$(PACKAGE)-$(VERSION)/COPYING \
		$(PACKAGE)-$(VERSION)/Makefile \
		$(PACKAGE)-$(VERSION)/README.md \
		$(PACKAGE)-$(VERSION)/database.yml \
		$(PACKAGE)-$(VERSION)/tools/spdx.sh \
		$(PACKAGE)-$(VERSION)/project.conf
	$(RM) -- $(OBJDIR)$(PACKAGE)-$(VERSION)

distcheck: dist
	$(TAR) -xzvf $(OBJDIR)$(PACKAGE)-$(VERSION)$(TGZEXT)
	$(MKDIR) -- $(PACKAGE)-$(VERSION)/objdir
	$(MKDIR) -- $(PACKAGE)-$(VERSION)/destdir
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/"
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" DESTDIR="$$PWD/destdir" install
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" DESTDIR="$$PWD/destdir" uninstall
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" distclean
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) dist
	$(RM) -r -- $(PACKAGE)-$(VERSION)

install: all
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" install; \
		else $(MAKE) install; fi) || exit; done
	$(MKDIR) $(DESTDIR)$(PREFIX)/share/doc/$(PACKAGE)
	$(INSTALL) -m 0644 README.md $(DESTDIR)$(PREFIX)/share/doc/$(PACKAGE)/README.md

uninstall:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" uninstall; \
		else $(MAKE) uninstall; fi) || exit; done
	$(RM) -- $(DESTDIR)$(PREFIX)/share/doc/$(PACKAGE)/README.md

.PHONY: all subdirs clean distclean dist distcheck install uninstall format merge-versions spdx
