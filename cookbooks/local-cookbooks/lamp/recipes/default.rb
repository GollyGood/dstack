#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2014 dStack Development Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'apt'

if node['lamp']['php'].key?('repo')
  apt_repository node['lamp']['php']['repo']['name'] do
    uri node['lamp']['php']['repo']['uri']
    distribution node['lsb']['codename']
    components ['main']
    deb_src 'true'
    key node['lamp']['php']['repo']['key']
    keyserver 'keyserver.ubuntu.com'
  end

  # Hack to install apache2 packages.
  if node['lamp']['php']['version'] == '5.5' || node['lamp']['php']['version'] == '5.6'
    execute 'apache2.4 install' do
      command  <<-EOH
        apt-get install libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap liblua5.2-0 libssl1.0.2 liblua5.1-0 -y

        dpkg -i /home/vagrant/assets/apache2/apache2-bin_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-utils_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-data_2.4.16-4+deb.sury.org~precise+4_all.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-dbg_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-dev_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-doc_2.4.16-4+deb.sury.org~precise+4_all.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-suexec-custom_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-suexec-pristine_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2-utils_2.4.16-4+deb.sury.org~precise+4_amd64.deb
        dpkg -i /home/vagrant/assets/apache2/apache2_2.4.16-4+deb.sury.org~precise+4_amd64.deb

        # Install remaining dependencies.
        apt-get -f install -y
        apt-get install ssl-cert
      EOH
    end

    template "/etc/apt/preferences.d/apache2_4-hold" do
      source 'apache2_4-hold.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end
  end
end

include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'cron'
include_recipe 'database'
include_recipe 'openssl'
include_recipe 'php'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_ssl'
include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'database::mysql'
include_recipe 'php::module_apc'
include_recipe 'php::module_gd'
include_recipe 'php::module_mysql'
include_recipe 'php::module_curl'

template "#{node['lamp']['php']['apache_conf_dir']}/php.ini" do
  source 'php.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source 'apc.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

if node['lamp']['php']['version'] == '5.3'
  package 'php5-suhosin' do
    action :install
  end
  template "#{node['php']['ext_conf_dir']}/suhosin.ini" do
    source 'suhosin.ini.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
end
