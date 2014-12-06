#
# Cookbook Name:: avahi-daemon
# Recipe:: enable
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install server components for Debian
case node['platform']
  when "debian","ubuntu"
    %w{ avahi-daemon libnss-mdns }.each do |pkg|
    package pkg do
      action :install
    end
  end
end

# Start & enable the avahi-daemon service
service "avahi-daemon" do
  service_name node['avahi-daemon']['service']['name']
  action [ :start, :enable ]
end
