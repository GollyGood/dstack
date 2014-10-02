#
# Cookbook Name:: utils
# Attributes:: xdebug

default['utils']['xdebug']['directives'] = {
  'profiler_append' => 1,
  'profiler_output_name' => 'cachegrind.out.%t-%s',
  'remote_enable' => 1,
}
