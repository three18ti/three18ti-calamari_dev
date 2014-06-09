#
# Cookbook Name:: calamari_dev
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential-dev'

case node["platform"]
  when "ubuntu"
    potentially_at_compile_time do
      package 'libzmq-dev' 
      package 'python-dev'
      package 'g++' 
      package 'python-cairo'
      package 'python-m2crypto'
      if node["platform_version"].to_f >= 14.04
        package 'postgresql-9.3' 
        package 'postgresql-server-dev-9.3'
      else 
        package 'postgresql-9.1' 
        package 'postgresql-server-dev-9.1'
      end
    end
  when "fedora", "rhel", "centos"
    potentially_at_compile_time do
      package 'python-devel'
      package 'zeromq-devel'
      package 'gcc-c++'
      package 'postgresql-server' 
      package 'postgresql-devel'
      package 'pycairo'
      package 'm2crypto'
    end
  else

end

potentially_at_compile_time do
  package 'git'
  package 'swig' 
  package 'python-virtualenv'
end

git node['calamari']['calamari_path'] do
  repository 'https://github.com/ceph/calamari.git'
end

git "#{node['calamari']['calamari_path']}/webapp/content" do
  repository 'https://github.com/ceph/calamari-clients.git'
end

python_virtualenv node['calamari']['calamari_path'] do
  owner "root"
  group "root"
  options "--system-site-packages"
  action :create
end

bash "configure virtualenv" do
  cwd node['calamari']['calamari_path']
  code <<-EOH
    pip install -r requirements/debian/requirements.txt
    pip install -r requirements/debian/requirements.force.txt
    pip install carbon --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"      
    pip install git+https://github.com/ceph/graphite-web.git@calamari --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"

    EOH
  environment 'PIP_DOWNLOAD_CACHE' => "/tmp"
end
