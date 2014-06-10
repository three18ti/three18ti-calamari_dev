#
# Cookbook Name:: calamari_dev
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

[ node['calamari']['workspace'], 
  node['calamari']['PIP_DOWNLOAD_CACHE'], 
  node['calamari']['webapp_logdir'],
  node['calamari']['VIRTUAL_ENV_PATH'] ].each do |path|
  directory path do
    owner "root"
    group "root"
    action :create
    recursive true
  end
end

case node["platform"]
  when "ubuntu"
    potentially_at_compile_time do
      package 'libzmq-dev' 
      package 'python-dev'
      package 'g++' 
      package 'python-cairo'
      package 'python-m2crypto'
      package 'libffi-dev'
      package 'libcairo2-dev'
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

python_virtualenv node['calamari']['VIRTUAL_ENV_PATH'] do
  owner "root"
  group "root"
  options "--system-site-packages"
  action :create
end

# reinstall requests if we have to
case node["platform"]
  when "ubuntu"
    if node["platform_version"].to_f >= 14.04
      ruby_block "Rename broken " do
        block do
          File.rename('/usr/lib/python2.7/dist-packages/requests','/usr/lib/python2.7/dist-packages/requests.broken')
        end
        not_if { File.directory?('/usr/lib/python2.7/dist-packages/requests.broken') }
        only_if { File.directory?('/usr/lib/python2.7/dist-packages/requests') }
      end
      bash "reinstall requests" do
        code <<-EOH
          easy_install requests==2.2.1
        EOH
        not_if { File.directory?('/usr/local/lib/python2.7/dist-packages/requests-2.2.1-py2.7.egg') }
      end
    end
end

include_recipe 'calamari_dev::calamari-client'

# pip is broken, this should work otherwise, I *think*...
bash "configure virtualenv" do
  cwd node['calamari']['calamari_path']
  environment 'PIP_DOWNLOAD_CACHE' => node['calamari']['PIP_DOWNLOAD_CACHE']
  environment 'VIRTUAL_ENV' => node['calamari']['VIRTUAL_ENV_PATH']
  code <<-EOH
    source ${VITUAL_ENV}/bin/activate
    pip install -r requirements/debian/requirements.txt
    pip install -r requirements/debian/requirements.force.txt
    pip install carbon --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"      
    pip install git+https://github.com/ceph/graphite-web.git@calamari --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"
    pip install --allow-external pycairo --allow-unverified pycairo pycairo
    EOH
end

bash "link modules to virtualenv" do
  cwd node['calamari']['calamari_path']
  environment 'PIP_DOWNLOAD_CACHE' => node['calamari']['PIP_DOWNLOAD_CACHE']
  environment 'VIRTUAL_ENV' => node['calamari']['VIRTUAL_ENV_PATH']
  code <<-EOH
    source ${VITUAL_ENV}/bin/activate
    pushd calamari-common ; python setup.py develop ; popd
    pushd rest-api ; python setup.py develop ; popd
    pushd cthulhu ; python setup.py develop ; popd
    pushd minion-sim ; python setup.py develop ; popd
    pushd calamari-web ; python setup.py develop ; popd
    EOH
end

