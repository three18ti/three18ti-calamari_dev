#
# Cookbook Name:: calamari_dev
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default['calamari']['workspace'] = '/opt/workspace'

default['calamari']['calamari_path'] = File.join(node['calamari']['workspace'], 'calamari')

default['calamari']['PIP_DOWNLOAD_CACHE'] = '/tmp/pip_cache'
