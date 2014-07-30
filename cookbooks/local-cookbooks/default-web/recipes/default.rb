#
# Cookbook Name:: default-web
# Recipe:: default

include_recipe "lamp"

def get_aliases(site)
  aliases = []

  if site.has_key?('aliases')
    site['aliases'].each do |site_alias|
      aliases << site_alias
    end
  end

  return aliases
end

vlamp = JSON.parse(node['dstack']['vlamp'])
vagrant = JSON.parse(node['dstack']['vagrant'])

vlamp['sites'].each_pair do |key, value|
  server_name = key
  aliases = get_aliases(value)

  web_app server_name do
    allow_override "All"
    docroot value['guest_docroot']
    server_aliases aliases
    server_name server_name
  end
end

vlamp['databases'].each do |database_name|
  mysql_database database_name do
    connection({
      :host => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password'],
    })
    action :create
  end
end
