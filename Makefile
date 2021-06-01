GITHUB_REF ?= main
GITHUB_SHORT_REF := $(lastword $(subst /, ,$(GITHUB_REF)))

CVS :=  dist/jamescondron_dx_cv.pdf   \
	dist/jamescondron_sre_cv.pdf  \
	dist/jamescondron_vpe_cv.pdf

URLFILES := dx/.tag-ref   \
	    sre/.tag-ref  \
	    vpe/.tag-ref

build: dist $(CVS)

urls: $(URLFILES)

dist:
	mkdir -p dist

%/.tag-ref:
	printf $(GITHUB_SHORT_REF) > $@

dist/jamescondron_%_cv.pdf: %/cv.tex dist
	xelatex -jobname=$(basename $@) $<
