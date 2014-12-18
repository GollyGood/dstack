.PHONY: dependencies install_gems install_chef_cookbooks update_chef_cookbooks tests

all: development

apply-patches:
	# Add version detection for retrieving the extensions directory for PECL
	# since PEAR < 1.10.0 doesn't use the configured ext_dir. @see http://pear.php.net/bugs/bug.php?id=18666
	patch -d cookbooks/berks-cookbooks/php -p1 < cookbooks/patches/opscode_php-PECL_version_detection.patch

development: install-gems

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
	cd dstack && make
