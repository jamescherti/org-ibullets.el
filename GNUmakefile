######################################################################
#                            GNU MAKEFILE                            #
######################################################################

# clear out suffix list
.SUFFIXES:

EMACS = emacs
ELC = $(EMACS) -Q -batch -L .
EFLAGS =

######################################################################
### Rules
######################################################################
.PHONY: org-bullets clean test-run
# define main goal of make

org-bullets: org-bullets.elc

%.elc: %.el
	$(ELC) -f batch-byte-compile $<

test-run: org-bullets
	$(EMACS) -Q -l org-bullets.el $(EFLAGS) README.org

clean:
	-rm *.elc
