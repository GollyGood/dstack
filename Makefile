.PHONY: dependencies install_gems install_chef_cookbooks update_chef_cookbooks tests

all: development

development: install_gems install_chef_cookbooks

install_gems:
	bundle install

install_chef_cookbooks:
	if [ ! -d "cookbooks/berks-cookbooks" ]; then \
		cd cookbooks && berks vendor ;\
	fi

update_chef_cookbooks:
	cd cookbooks && berks update

test:
	cd dstack && make
