#!/usr/bin/env ruby

bash_commands = {
  "configure virtualenv" => <<-EOH,
    source ${VITUAL_ENV}/bin/activate
    pip install -r requirements/debian/requirements.txt
    pip install -r requirements/debian/requirements.force.txt
    pip install carbon --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"
    pip install git+https://github.com/ceph/graphite-web.git@calamari --install-option="--prefix=$VIRTUAL_ENV" --install-option="--install-lib=$VIRTUAL_ENV/lib/python2.7/site-packages"
    pip install --allow-external pycairo --allow-unverified pycairo pycairo
    EOH

  "link modules to virtualenv" => <<-EOH,
    source ${VITUAL_ENV}/bin/activate
    pushd calamari-common ; python setup.py develop ; popd
    pushd rest-api ; python setup.py develop ; popd
    pushd cthulhu ; python setup.py develop ; popd
    pushd minion-sim ; python setup.py develop ; popd
    pushd calamari-web ; python setup.py develop ; popd
    EOH
}

bash_commands.each do |key, value|
    puts "key: #{key}"
    puts "value: #{value}"
end
