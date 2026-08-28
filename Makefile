.PHONY: all
all: edumail.pdf muttnytid.pdf

LATEXFLAGS+=	-shell-escape

edumail.pdf: edumail.tex didactic.sty
edumail.pdf: abstract.tex preamble.tex
edumail.pdf: edumail

edumail.tex: edumail.nw noweb_lexer.py

muttnytid.pdf: muttnytid.tex didactic.sty
muttnytid.pdf: preamble.tex
muttnytid.pdf: mutt-nytid edumail .muttrc.nytid

muttnytid.tex: muttnytid.nw noweb_lexer.py


.PHONY:
all: edumail mutt-nytid mutt .muttrc.nytid labels.rules

edumail.sh: edumail.nw
edumail: edumail.sh
	cp $^ $@
	chmod +x $@

mutt-nytid.sh mutt.sh: muttnytid.nw
	${NOTANGLE.sh}

.muttrc.nytid labels.rules: muttnytid.nw
	${NOTANGLE.sh}

mutt-nytid: mutt-nytid.sh
	cp $^ $@
	chmod +x $@

mutt: mutt.sh
	cp $^ $@
	chmod +x $@


.PHONY: clean
clean:
	${RM} edumail edumail.sh edumail.pdf edumail.tex
	${RM} mutt-nytid mutt-nytid.sh mutt mutt.sh
	${RM} .muttrc.nytid labels.rules muttnytid.pdf muttnytid.tex


.PHONY: install
PREFIX=${HOME}
install: edumail mutt-nytid mutt .muttrc.nytid labels.rules
	install -m 755 edumail mutt-nytid mutt ${PREFIX}/bin
	install -m 644 .muttrc.nytid ${HOME}/.muttrc.nytid
	mkdir -p ${HOME}/.config/edumail
	[ -e ${HOME}/.config/edumail/labels.rules ] \
	  || install -m 644 labels.rules ${HOME}/.config/edumail/labels.rules

.PHONY: release
release: edumail.pdf edumail
	gh release create $(shell date +%Y%m%d-%H%M) edumail.pdf edumail


INCLUDE_MAKEFILES=./makefiles
include ${INCLUDE_MAKEFILES}/tex.mk
include ${INCLUDE_MAKEFILES}/noweb.mk
INCLUDE_DIDACTIC=./didactic
include ${INCLUDE_DIDACTIC}/didactic.mk
