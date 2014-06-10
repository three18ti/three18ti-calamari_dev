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

default['calamari']['VIRTUAL_ENV_PATH'] = File.join(node['calamari']['workspace'], 'calamari_venv')

default['calamari']['webapp_logdir'] = File.join(node['calamari']['VIRTUAL_ENV_PATH'], 'storage', 'log', 'webapp')

default['calamari']['PIP_DOWNLOAD_CACHE'] = '/tmp/pip_cache'
