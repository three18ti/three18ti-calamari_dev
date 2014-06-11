# encoding: utf-8
# Cookbook Name:: calamari_dev
# Recipe:: calamari-client
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

potentially_at_compile_time do
  package 'nodejs'
  package 'npm'
end

link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end

directory node['calamari']['webapp_dir'] do
  owner "root"
  group "root"
  action :create
  recursive true
end

git node['calamari']['client_dir'] do
  repository 'https://github.com/ceph/calamari-clients.git'
end

#bash "install calamari client deps" do
#  cwd "#{node['calamari']['calamari_path']}/webapp/content"
#  code <<-EOH
#    npm install -g grunt-cli
#    npm install -g bower --config.interactive=false
#    /opt/chef/embedded/bin/gem install compass
#    make dist
#  EOH
#end

# rsync won't copy anything if there are no differences...
#bash "copy webapp content to working dir" do
#  cwd node['calamari']['calamari_path']
#  environment 'SOURCE_PATH' => node['calamari']['client_dir']
#  environment 'INSTALL_PATH' => node['calamari']['webapp_content_dir']
#  code <<-EOH
#    for unit in dashboard admin login manage
#    do
#      rsync -rahP ${SOURCE_PATH}/${unit}/dist/ ${INSTALL_PATH}/${unit}
#    done
#    EOH
#end

#bash "configure virtualenv" do
#  cwd node['calamari']['calamari_path']
#  code <<-EOH
#    VIRTUAL_ENV=/opt/workspace/calamari
#    pip install -r requirements/debian/requirements.txt
#    pip install -r requirements/debian/requirements.force.txt
#    pip install carbon --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"      
#    pip install git+https://github.com/ceph/graphite-web.git@calamari --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/$
#
#    EOH
#  environment 'PIP_DOWNLOAD_CACHE' => node['calamari']['PIP_DOWNLOAD_CACHE']
#end
