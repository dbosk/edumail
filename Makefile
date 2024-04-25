.PHONY: all
all: edumail.pdf

LATEXFLAGS+=	-shell-escape

edumail.pdf: edumail.tex didactic.sty
edumail.pdf: abstract.tex
edumail.pdf: edumail

edumail.tex: edumail.nw


.PHONY:
all: edumail

edumail.sh: edumail.nw
edumail: edumail.sh
	cp $^ $@
	chmod +x $@


.PHONY: clean
clean:
	${RM} edumail edumail.sh edumail.pdf edumail.tex


.PHONY: install
PREFIX=${HOME}
install: edumail
	install -m 755 $^ ${PREFIX}/bin


INCLUDE_MAKEFILES=./makefiles
include ${INCLUDE_MAKEFILES}/tex.mk
include ${INCLUDE_MAKEFILES}/noweb.mk
INCLUDE_DIDACTIC=./didactic
include ${INCLUDE_DIDACTIC}/didactic.mk
