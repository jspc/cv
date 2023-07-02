GITHUB_REF ?= main
GITHUB_SHORT_REF := $(lastword $(subst /, ,$(GITHUB_REF)))

CVS :=  dist/jamescondron_ic_cv.pdf   \
	dist/jamescondron_management_cv.pdf

INCLUDES := includes/headpiece.tex  \
	    includes/systems.tex    \
	    includes/portfolio.tex  \
	    includes/languages.tex  \
	    includes/employment.tex \
	    includes/education.tex

build: dist $(CVS)

urls: .tag-ref

dist:
	mkdir -p dist

.tag-ref:
	printf $(GITHUB_SHORT_REF) > $@

dist/jamescondron_%_cv.pdf: %/cv.tex $(INCLUDES) | dist
	xelatex -jobname=$(basename $@) $<
