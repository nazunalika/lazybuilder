lazybuilder
===========

The lazybuilder lazily builds RPMs whether for bootstrapping purposes or otherwise. This is the role part of the lazy builder.

This is not a normal role. The `main.yml` does not do anything (as of this writing). You will need to use the `include_role` ansible builtin and pick the right initial task.

In the event that it *does* do something, it will be reliant on tags and modes specified by the vars. This is highly unlikely to happen.

Requirements
------------

Packages
========

This will require your systems to have the appropriate packages installed or at the very least the right `/bin`'s to go to perform the work. For example:

* `mock`
* `git`
* `createrepo_c`
* `rpm-build`

Minimum recommended versions:

* `mock` -> `2.10`
* `rpm` -> `4.14` (`4.13` may work on EL7, but is **not** recommended)
* `createrepo_c` -> `0.16`

Permissions
===========

lazybuilder requires a properly setup repo root that has correct permissions. The default setup requires:

* rpmbuild user, default is `rpmbuild` (can by defined by `mock_builder`)
* primary repo directory owned by the rpmbuild user, default is `/opt/repo`

Notes
-----

Build Requires
==============

If you are running `module_mode`, your yaml must have simple buildrequires (only **one** list item)

```
  dependencies:
  - buildrequires:
      nodejs:
      - "10"
      platform:
      - el8
    requires:
      platform:
      - el8
  filter:
    rpms: ...
```

Currently it is hardcoded to expect `module_data.data.dependencies[0].buildrequires.platform[0]`. In summary:

* If `module_data.data.dependencies[0].buildrequires.platform[0]` does not match `dist` or `dist.minor.0`, play will end
* Anything more than `[0]` for both `dependencies` and `platform` will be ignored

In the future, this may be fixed to address modularity for both el8 and el9 at the same time.

References
==========

Module yamls typically have git hashes that reference the repo that the RPM comes from. This isn't done by lazybuilder. A separate process creates these yamls with the git hashes. By default, lazybuilder follows the branch name specifically rather than the git hash. If you wish to follow the hashes, set `module_follow_refs: true` for your playbook.

Dependencies
------------

No dependencies currently.

License
-------

MIT

Author Information
------------------

Louis Abel @nazunalika <tucklesepk@gmail.com> <label@rockylinux.org>
