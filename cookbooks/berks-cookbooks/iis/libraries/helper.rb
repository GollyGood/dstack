#
# Cookbook Name:: iis
# Library:: helper
#
# Author:: Julian C. Dunn <jdunn@chef.io>
# Author:: Justin Schuhmann <jmschu02@gmail.com>
#
# Copyright 2013, Chef Software, Inc.
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

module Opscode
  module IIS
    # Contains functions that are used throughout this cookbook
    module Helper
      @iis_version = nil

      if RUBY_PLATFORM =~ /mswin|mingw32|windows/
        require 'chef/win32/version'
        require 'win32/registry'
      end

      require 'rexml/document'
      require 'chef/mixin/shell_out'

      include Chef::Mixin::ShellOut
      include REXML
      include Windows::Helper

      def self.older_than_windows2008r2?
        if RUBY_PLATFORM =~ /mswin|mingw32|windows/
          win_version = Chef::ReservedNames::Win32::Version.new
          win_version.windows_server_2008? ||
            win_version.windows_vista? ||
            win_version.windows_server_2003_r2? ||
            win_version.windows_home_server? ||
            win_version.windows_server_2003? ||
            win_version.windows_xp? ||
            win_version.windows_2000?
        end
      end

      def self.older_than_windows2012?
        if RUBY_PLATFORM =~ /mswin|mingw32|windows/
          win_version = Chef::ReservedNames::Win32::Version.new
          win_version.windows_7? ||
            win_version.windows_server_2008_r2? ||
            win_version.windows_server_2008? ||
            win_version.windows_vista? ||
            win_version.windows_server_2003_r2? ||
            win_version.windows_home_server? ||
            win_version.windows_server_2003? ||
            win_version.windows_xp? ||
            win_version.windows_2000?
        end
      end

      def windows_cleanpath(path)
        path = if defined?(Chef::Util::PathHelper.cleanpath).nil?
                 win_friendly_path(path)
               else
                 Chef::Util::PathHelper.cleanpath(path)
               end
        # Remove any trailing slashes to prevent them from accidentally escaping any quotes.
        path.chomp('/').chomp('\\')
      end

      def new_value?(document, xpath, value_to_check)
        XPath.first(document, xpath).to_s != value_to_check.to_s
      end

      def new_or_empty_value?(document, xpath, value_to_check)
        value_to_check.to_s != '' && new_value?(document, xpath, value_to_check)
      end

      def appcmd(node)
        @appcmd ||= begin
          "#{node['iis']['home']}\\appcmd.exe"
        end
      end

      def iis_version
        if @iis_version.nil?
          version_string = Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\Microsoft\InetStp').read('VersionString')[1]
          version_string.slice! 'Version '
          @iis_version = version_string
        end
        @iis_version
      end
    end
  end
end
