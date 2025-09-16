TARGETS	= $(OBJDIR)aobc-generate$(EXEEXT)
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
BINDIR	= $(PREFIX)/bin
SBINDIR	= $(PREFIX)/sbin
GO	= go
GOFLAGSF=
GOFLAGS	=
EXEEXT	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

aobc-generate_OBJS =
aobc-generate_GOFLAGS = $(GOFLAGSF) $(GOFLAGS)

$(OBJDIR)aobc-generate$(EXEEXT): cmd/aobc-generate/aobc-generate.go
	$(GO) build $(aobc-generate_GOFLAGS) -o $(OBJDIR)aobc-generate$(EXEEXT) cmd/aobc-generate/aobc-generate.go

clean:
	$(RM) -- $(aobc-generate_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

install: all

uninstall:

.PHONY: all clean distclean install uninstall
