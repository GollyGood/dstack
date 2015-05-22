.PHONY: all apply-patches development install-gems install-vendor-cookbooks refresh-vendor-cookbooks delete-vendor-cookbooks test

all: development

apply-patches:
	# Add version detection for retrieving the extensions directory for PECL
	# since PEAR < 1.10.0 doesn't use the configured ext_dir. @see http://pear.php.net/bugs/bug.php?id=18666
	patch -d cookbooks/berks-cookbooks/php -p1 < cookbooks/patches/opscode_php-PECL_version_detection.patch

development: install-gems

install:
	ln -s ~/.vagrant.d/insecure_private_key ~/.ssh/vagrant_insecure_private_key
	chmod 600 ~/.ssh/vagrant_insecure_private_key
	echo "\nHost *.local\n  IdentityFile ~/.ssh/vagrant_insecure_private_key\n  User vagrant" >> ~/.ssh/config

install-gems:
	bundle install

install-vendor-cookbooks:
	if [ ! -d "cookbooks/berks-cookbooks" ]; then \
		cd cookbooks && bundle exec berks vendor ;\
		cd .. && $(MAKE) apply-patches ;\
	fi

refresh-vendor-cookbooks: delete-vendor-cookbooks
	cd cookbooks && bundle exec berks update && bundle exec berks vendor ;\
	cd .. && $(MAKE) apply-patches ;\

delete-vendor-cookbooks:
	rm -r cookbooks/berks-cookbooks

test:
	bundle exec foodcritic cookbooks/local-cookbooks
	bundle exec rubocop
	cd dstack && make
