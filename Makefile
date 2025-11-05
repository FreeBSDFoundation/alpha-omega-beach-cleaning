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
TARGETS	= $(OBJDIR)dependencies.md format merge-versions $(OBJDIR)plan.md $(OBJDIR)security.md spdx
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

merge-versions:
	(cd src/versions && $(MAKE) versions.yml) && yq database.yml src/versions/versions.yml

$(OBJDIR)plan.md: $(OBJDIR)src/aobc-generate database.yml
	$(OBJDIR)src/aobc-generate

$(OBJDIR)security.md: $(OBJDIR)src/aobc-generate database.yml
	$(OBJDIR)src/aobc-generate

spdx: dependencies.md security.md tools/spdx.sh
	./tools/spdx.sh -P "$(PREFIX)" -- "spdx"

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
	$(RM) -- $(OBJDIR)dependencies.md $(OBJDIR)plan.md $(OBJDIR)security.md

dist:
	$(RM) -r -- $(OBJDIR)$(PACKAGE)-$(VERSION)
	$(LN) -s -- "$$PWD" $(OBJDIR)$(PACKAGE)-$(VERSION)
	@cd $(OBJDIR). && $(TAR) -czvf $(PACKAGE)-$(VERSION)$(TGZEXT) -- \
		$(PACKAGE)-$(VERSION)/src/cmd/aobc-generate/aobc-generate.go \
		$(PACKAGE)-$(VERSION)/src/Makefile \
		$(PACKAGE)-$(VERSION)/src/go.mod \
		$(PACKAGE)-$(VERSION)/src/go.sum \
		$(PACKAGE)-$(VERSION)/src/project.conf \
		$(PACKAGE)-$(VERSION)/src/versions/bsddialog.c \
		$(PACKAGE)-$(VERSION)/src/versions/byacc.c \
		$(PACKAGE)-$(VERSION)/src/versions/bzip2.c \
		$(PACKAGE)-$(VERSION)/src/versions/dtc.c \
		$(PACKAGE)-$(VERSION)/src/versions/file.c \
		$(PACKAGE)-$(VERSION)/src/versions/flex.c \
		$(PACKAGE)-$(VERSION)/src/versions/libarchive.c \
		$(PACKAGE)-$(VERSION)/src/versions/libcbor.c \
		$(PACKAGE)-$(VERSION)/src/versions/libdialog.c \
		$(PACKAGE)-$(VERSION)/src/versions/libedit.c \
		$(PACKAGE)-$(VERSION)/src/versions/libevent.c \
		$(PACKAGE)-$(VERSION)/src/versions/liblzma.c \
		$(PACKAGE)-$(VERSION)/src/versions/libpcap.c \
		$(PACKAGE)-$(VERSION)/src/versions/ncurses.c \
		$(PACKAGE)-$(VERSION)/src/versions/openssl.c \
		$(PACKAGE)-$(VERSION)/src/versions/patch.c \
		$(PACKAGE)-$(VERSION)/src/versions/tcpdump.c \
		$(PACKAGE)-$(VERSION)/src/versions/Makefile \
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
