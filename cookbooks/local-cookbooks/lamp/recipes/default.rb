#
# Cookbook Name:: lamp
# Recipe:: default

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'cron'
include_recipe 'database'
include_recipe 'openssl'
include_recipe 'php'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'database::mysql'
include_recipe 'php::module_apc'
include_recipe 'php::module_gd'
include_recipe 'php::module_mysql'
include_recipe 'php::module_curl'

# Load php config.
template "#{node['lamp']['php']['apache_conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# Load apc config.
template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

php_pear "uploadprogress" do
  action :install
end
