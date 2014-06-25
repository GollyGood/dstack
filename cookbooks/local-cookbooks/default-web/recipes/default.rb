#
# Cookbook Name:: default-web
# Recipe:: default

include_recipe "lamp"

def token_default_replace(to_replace, vlamp)
  return to_replace.sub '<default>', vlamp[:hostname]
end

def get_aliases(site, vlamp)
  aliases = []

  if site.has_key?(:aliases)
    site[:aliases].each do |site_alias|
      aliases << token_default_replace(site_alias, vlamp)
    end
  end

  return aliases
end

vlamp = JSON.parse(node[:vlamp], {:symbolize_names => true})
vlamp[:sites].each_pair do |key, value|
  server_name = token_default_replace(key.to_s, vlamp)
  aliases = get_aliases(value, vlamp)

  web_app server_name do
    allow_override "All"
    docroot value[:guest_docroot]
    server_aliases aliases
    server_name server_name
  end
end
