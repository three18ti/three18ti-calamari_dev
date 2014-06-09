calamari_dev Cookbook
=====================
Cookbook to install packages for Calamari development environment.

see: https://github.com/ceph/calamari

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
