#
# Cookbook Name:: default-web
# Recipe:: default

include_recipe "lamp"

def token_default_replace(to_replace, vagrant)
  if vagrant.has_key?('hostname') and vagrant['hostname'] != ''
    to_replace = to_replace.sub '<default>', vagrant['hostname']
  end

  return to_replace
end

def get_aliases(site, vagrant)
  aliases = []

  if site.has_key?('aliases')
    site['aliases'].each do |site_alias|
      aliases << token_default_replace(site_alias, vagrant)
    end
  end

  return aliases
end

vlamp = JSON.parse(node['vlamp'])
vagrant = JSON.parse(node['vagrant'])

vlamp['sites'].each_pair do |key, value|
  server_name = token_default_replace(key.to_s, vagrant)
  aliases = get_aliases(value, vagrant)

  web_app server_name do
    allow_override "All"
    docroot value['guest_docroot']
    server_aliases aliases
    server_name server_name
  end
end

vlamp['databases'].each do |database|
  database_name = token_default_replace(database, vagrant).sub '.', '_'

  # Create a mysql database for homeimprovement.
  mysql_database database_name do
    connection ({
      :host => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password'],
    })
    action :create
  end
end
