#
# Cookbook Name:: utils
# Recipe:: xdebug

include_recipe 'php'

php_pear "xdebug" do
  zend_extensions ['xdebug.so']
  action :install
  directives node['utils']['xdebug']['directives']
end
