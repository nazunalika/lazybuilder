lazybuilder
===========

The lazybuilder lazily builds RPMs whether for bootstrapping purposes or otherwise. This is the role part of the lazy builder.

This is not a normal role. The `main.yml` does not do anything (as of this writing). You will need to use the `include_role` ansible builtin and pick the right initial task.

In the event that it *does* do something, it will be reliant on tags and modes specified by the vars. This is highly unlikely to happen.

Requirements
------------

This will require your systems to have the appropriate packages installed or at the very least the right `/bin`'s to go to perform the work. For example:

* `mock` 
* `koji`
* `pungi`
* `git`
* `createrepo_c`

Dependencies
------------

No dependencies currently.

License
-------

MIT

Author Information
------------------

Louis Abel @nazunalika <label@rockylinux.org>
