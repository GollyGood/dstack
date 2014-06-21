#
# Cookbook Name:: default-web
# Recipe:: default

include_recipe "lamp"

# Create virtual host and enable site.
web_app "foobar.lamp" do
  allow_override "All"
  docroot "/home/vagrant/htdocs"
  server_aliases []
  server_name "foobar.lamp"
end
