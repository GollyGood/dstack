.PHONY: dependencies install_gems install_chef_cookbooks update_chef_cookbooks

development: install_gems install_chef_cookbooks

install_gems:
	bundle install

install_chef_cookbooks:
	if [ ! -d "chef/cookbooks/berks-cookbooks" ]; then \
		cd chef/cookbooks && berks vendor ;\
	fi

update_chef_cookbooks:
	cd chef/cookbooks && berks update
