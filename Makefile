.PHONY: all
all: edumail.pdf nymutt.pdf

LATEXFLAGS+=	-shell-escape
TEX_PYTHONTEX=	yes

edumail.pdf: edumail.tex didactic.sty
edumail.pdf: abstract.tex preamble.tex
edumail.pdf: edumail

edumail.tex: edumail.nw noweb_lexer.py

nymutt.pdf: nymutt.tex didactic.sty
nymutt.pdf: preamble.tex
nymutt.pdf: nymutt edumail .muttrc.nytid labels.rules

nymutt.tex: nymutt.nw noweb_lexer.py


.PHONY:
all: edumail nymutt mutt .muttrc.nytid labels.rules

edumail.sh: edumail.nw
edumail: edumail.sh
	cp $^ $@
	chmod +x $@

nymutt.sh mutt.sh: nymutt.nw
	${NOTANGLE.sh}

.muttrc.nytid labels.rules: nymutt.nw
	${NOTANGLE.sh}

nymutt: nymutt.sh
	cp $^ $@
	chmod +x $@

mutt: mutt.sh
	cp $^ $@
	chmod +x $@


.PHONY: clean
clean:
	${RM} edumail edumail.sh edumail.pdf edumail.tex
	${RM} nymutt nymutt.sh mutt mutt.sh
	${RM} .muttrc.nytid labels.rules nymutt.pdf nymutt.tex


.PHONY: install
PREFIX=${HOME}
install: edumail nymutt mutt .muttrc.nytid labels.rules
	install -m 755 edumail nymutt mutt ${PREFIX}/bin
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
