#
JEKYLL ?= bundler exec jekyll
PYTHON ?= /opt/local/bin/python2.7

.PHONY: boot

# Install Jekyll and SAAS
boot:
	bundler install
	bundle exec rougify style base16.solarized > css/syntax.css
	mkdir -p javascripts fonts _sass
	ln -svf `bundler show bootstrap-sass`/assets/stylesheets/{_bootstrap.scss,bootstrap} _sass/
	rsync -rav `bundler show bootstrap-sass`/assets/javascripts/{bootstrap.min.js,bootstrap} javascripts/
	rsync -rav `bundler show bootstrap-sass`/assets/fonts/bootstrap fonts/
	ln -svf `bundler show jquery-rails`/vendor/assets/javascripts/jquery.min.js javascripts/

_site/index.html: $(deps) pub.html _data/pub.yaml
	$(JEKYLL) build

serve:
	$(JEKYLL) serve --watch

build:
	$(JEKYLL) build

