#
# Cookbook Name:: avahi-daemon
# Recipe:: disable
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Stop & disable the avahi-daemon service
service "avahi-daemon" do
  service_name node['avahi-daemon']['service']['name']
  action [ :stop, :disable ]
end

# Remove server components for Debian
case node['platform']
  when "debian","ubuntu"
    %w{ avahi-daemon libnss-mdns }.each do |pkg|
    package pkg do
      action :purge
    end
  end
end

# Remove avahi-daemon::disable from node run list
ruby_block "remove avahi-daemon::disable from run list" do
  block do
    node.run_list.remove("recipe[avahi-daemon::disable]")
  end
end
