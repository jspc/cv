CDN ?= 37bb669b-1686-42ae-9433-f0d185208cf1

.PHONY: default all

default: all

all: dist dist/jamescondron_dx_cv.pdf dist/jamescondron_sre_cv.pdf

dist:
	mkdir -p dist

dist/jamescondron_dx_cv.pdf: dist
	texi2pdf dx/cv.tex -o dist/jamescondron_dx_cv.pdf

dist/jamescondron_sre_cv.pdf: dist
	texi2pdf sre/cv.tex -o dist/jamescondron_sre_cv.pdf

.PHONY: deploy purge
deploy:
	aws s3 sync dist/ s3://assets-jspc-pw --endpoint=https://fra1.digitaloceanspaces.com --acl=public-read

purge:
	curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer ${DOTOKEN}" -d '{"files": ["*"]}' "https://api.digitalocean.com/v2/cdn/endpoints/$(CDN)/cache"
