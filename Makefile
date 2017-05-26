#
sources=$(wildcard *.markdown)

JEKYLL ?= bundler exec jekyll
PYTHON ?= /opt/local/bin/python2.7

.PHONY: boot, serve, build, distclean

all: _site/index.html

# Install Jekyll and SAAS
boot:
	bundler install
	bundle exec rougify style base16.solarized > css/syntax.css
	mkdir -p javascripts fonts _sass
	rsync -rav `bundler show bootstrap-sass`/assets/stylesheets/{_bootstrap.scss,bootstrap} _sass/
	rsync -rav `bundler show bootstrap-sass`/assets/javascripts/{bootstrap.min.js,bootstrap} javascripts/
	rsync -rav `bundler show bootstrap-sass`/assets/fonts/bootstrap fonts/
	rsync -rav `bundler show jquery-rails`/vendor/assets/javascripts/jquery.min.js javascripts/

_site/index.html: $(sources)
	$(JEKYLL) build

serve:
	$(JEKYLL) serve --watch

build:
	$(JEKYLL) build

distclean:
	rm -rf _site
