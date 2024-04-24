.PHONY: all
all: edumail.pdf

LATEXFLAGS+=	-shell-escape

edumail.pdf: edumail.tex didactic.sty
edumail.pdf: abstract.tex

edumail.tex: edumail.nw


.PHONY:
all: edumail

edumail.py: edumail.nw
edumail: edumail.py
	cp $^ $@
	chmod +x $@


.PHONY: clean
clean:
	${RM} edumail edumail.py edumail.pdf edumail.tex


PKG_NAME-main= 			edumail
PKG_INSTALL_FILES-main=	edumail
PKG_PREFIX-main= 		/usr/local
PKG_INSTALL_DIR-main=	/bin
PKG_TARBALL_FILES-main= ${PKG_FILES-main} Makefile


INCLUDE_MAKEFILES=./makefiles
include ${INCLUDE_MAKEFILES}/tex.mk
include ${INCLUDE_MAKEFILES}/noweb.mk
include ${INCLUDE_MAKEFILES}/pkg.mk
INCLUDE_DIDACTIC=./didactic
include ${INCLUDE_DIDACTIC}/didactic.mk
