.PHONY: dependencies install_gems install_chef_cookbooks update_chef_cookbooks tests

all: development

development: install-gems

install-gems:
	bundle install

install-vendor-cookbooks:
	if [ ! -d "cookbooks/berks-cookbooks" ]; then \
		cd cookbooks && bundle exec berks vendor ;\
	fi

refresh-vendor-cookbooks: delete-vendor-cookbooks
	cd cookbooks && bundle exec berks update && bundle exec berks vendor

delete-vendor-cookbooks:
	rm -r cookbooks/berks-cookbooks

test:
	cd dstack && make
