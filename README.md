calamari_dev Cookbook
=====================
Cookbook to install packages for Calamari development environment.

see: https://github.com/ceph/calamari

the whole point is to do everything such that you have a running dev environment after running this recipe.

At the moment, this recipe checks everything out, but then you need to run the "commands" manually

See: https://gist.github.com/three18ti/fdfeb1c6950481414591 (you can skip anything that says "git" I think npm should also be able to be uncommented)

Need to figure out how to make this recipe idempotent.

!!!DON'T FORGET TO ACTIVATE YOUR VIRTUAL ENVIRONMENT!!!

Requirements
------------

#### packages

Attributes
----------
Coming Soon

e.g.
#### calamari_dev::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['calamari_dev']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['workspace']</tt></td>
    <td>File Path</td>
    <td>Where we're working</td>
    <td><tt>/opt/workspace</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['calamari_path']</tt></td>
    <td></td>
    <td></td>
    <td><tt>File.join(node['calamari']['workspace'], 'calamari')</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['VIRTUAL_ENV_PATH']</tt></td>
    <td></td>
    <td></td>
    <td><tt>File.join(node['calamari']['calamari_path'], 'calamari_venv')</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['webapp_log_dir']</tt></td>
    <td></td>
    <td></td>
    <td><tt>File.join(node['calamari']['VIRTUAL_ENV_PATH'], 'storage', 'log', 'webapp')</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['webapp_dir']</tt></td>
    <td></td>
    <td></td>
    <td><tt>File.join(node['calamari']['calamari_path'], 'webapp' )</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['client_dir']</tt></td>
    <td></td>
    <td></td>
    <td><tt> = File.join(node['calamari']['workspace'], 'calamari-client')</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['webapp_content_dir']</tt></td>
    <td></td>
    <td></td>
    <td><tt>File.join(node['calamari']['webapp_dir'], 'content')</tt></td>
  </tr>
  <tr>
    <td><tt>['calamari']['PIP_DOWNLOAD_CACHE']</tt></td>
    <td></td>
    <td></td>
    <td><tt>/tmp/pip_cache</tt></td>
  </tr>
</table>

Usage
-----
#### calamari_dev::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `calamari_dev` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[calamari_dev]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT

Authors: three18ti
