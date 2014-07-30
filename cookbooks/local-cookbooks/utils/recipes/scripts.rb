#
# Cookbook Name:: utils
# Recipe:: scripts

utils_config = JSON.parse(node['dstack']['utils'])
scripts = utils_config['scripts']

base_path = node['utils']['scripts']['base_path']
install_tracker = node['utils']['scripts']['install_tracker']
is_installed = File.exists?(install_tracker)

config_file = node['utils']['scripts']['config_file']
config = node.to_hash

def run_script(path, config_file)
  puts path
  execute path do
    command "#{path} #{config_file}"
    action :run
    user 'vagrant'
  end
end

def get_script_path(path, base_path)
  return path.index('/') === 0 ? path : base_path + path
end

file config_file do
  content config.to_json
  mode '0644'
  owner 'vagrant'
  group 'vagrant'
end

if not is_installed
  scripts['post-install'].each do |script|
    run_script(get_script_path(script, base_path), config_file)
  end

  file install_tracker do
    content Time.now.getlocal.inspect
    mode '0644'
    owner 'vagrant'
    group 'vagrant'
  end
end

scripts['post-up'].each do |script|
  run_script(get_script_path(script, base_path), config_file)
end
