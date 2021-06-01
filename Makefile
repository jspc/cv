CDN ?= 37bb669b-1686-42ae-9433-f0d185208cf1
CIRCLE_TAG ?= latest

default: build

build: dist dist/jamescondron_dx_cv.pdf dist/jamescondron_sre_cv.pdf dist/jamescondron_vpe_cv.pdf

dist:
	mkdir -p dist

dist/jamescondron_%_cv.pdf: %/cv.tex dist
	xelatex -jobname=$(basename $@) $<

.PHONY: deploy purge
deploy:
	aws s3 sync dist/ s3://assets-jspc-pw/latest --endpoint=https://fra1.digitaloceanspaces.com --acl=public-read
	aws s3 sync dist/ s3://assets-jspc-pw/$(CIRCLE_TAG) --endpoint=https://fra1.digitaloceanspaces.com --acl=public-read

purge:
	@curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer ${DOTOKEN}" -d '{"files": ["latest/*"]}' "https://api.digitalocean.com/v2/cdn/endpoints/$(CDN)/cache"
