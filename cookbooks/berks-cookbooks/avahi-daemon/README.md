

Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-avahi-daemon.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-avahi-daemon) 

Description
===========

Installs/enables or Uninstalls/disables the avahi-daemon service.

Requirements
============

This cookbook currently supports the following platforms:

Debian, Ubuntu

Attributes
==========

Set the avahi-daemon service name.
<pre><code>
default['avahi-daemon']['service']['name'] = "avahi-daemon"
</pre></code>

Usage
=====

Apply recipe avahi-daemon::enable to install/enable all avahi-daemon related services.

Recipe avahi-daemon::default takes no action.

avahi-daemon::disable recipe
============================

Use a knife command to remove avahi-daemon components from your system like so

knife node run_list add <node name> avahi-daemon::disable 
