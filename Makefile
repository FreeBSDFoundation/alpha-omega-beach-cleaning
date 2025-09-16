PACKAGE	= alpha-omega-beach-cleaning
VERSION	= 20250912
VENDOR	= FreeBSD-Foundation
SUBDIRS	= src
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
MKDIR	= mkdir -m 0755 -p
INSTALL	= install
RM	= rm -f
TARGETS	= $(OBJDIR)dependencies.md
RM	= rm -f
LN	= ln -f
TAR	= tar
TGZEXT	= .tar.gz
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: subdirs $(TARGETS)

subdirs:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		([ -d "$(OBJDIR)$$i" ] || $(MKDIR) -- "$(OBJDIR)$$i") && \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/"; \
		else $(MAKE); fi) || exit; done

$(OBJDIR)dependencies.md: $(OBJDIR)src/aobc-generate dependencies.csv
	$(OBJDIR)src/aobc-generate

clean:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" clean; \
		else $(MAKE) clean; fi) || exit; done

distclean:
	@for i in $(SUBDIRS); do (cd "$$i" && \
		if [ -n "$(OBJDIR)" ]; then \
		$(MAKE) OBJDIR="$(OBJDIR)$$i/" distclean; \
		else $(MAKE) distclean; fi) || exit; done
	$(RM) -- $(TARGETS)

dist:
	$(RM) -r -- $(OBJDIR)$(PACKAGE)-$(VERSION)
	$(LN) -s -- "$$PWD" $(OBJDIR)$(PACKAGE)-$(VERSION)
	@cd $(OBJDIR). && $(TAR) -czvf $(PACKAGE)-$(VERSION)$(TGZEXT) -- \
		$(PACKAGE)-$(VERSION)/src/cmd/aobc-generate/aobc-generate.go \
		$(PACKAGE)-$(VERSION)/src/Makefile \
		$(PACKAGE)-$(VERSION)/src/project.conf \
		$(PACKAGE)-$(VERSION)/Makefile \
		$(PACKAGE)-$(VERSION)/README.md \
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

.PHONY: all subdirs clean distclean dist distcheck install uninstall
