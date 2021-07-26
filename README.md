lazybuilder
===========

The lazybuilder lazily builds RPMs whether for bootstrapping purposes or otherwise. This isn't really a role, this isn't really a collection. This thing doesn't really know *what* it is. It's up for you to figure it out.

Ultimately, this is meant to be run by itself on an ansible box or imported as a project into tower (being careful with your tower settings). Right now it is built to be ran on an ansible box that is not tower.

Playbooks will sit in the root.

Requirements
------------

This will require your systems to have the appropriate packages installed or at the very least the right `/bin`'s to go to perform the work. For example:

* mock
* koji
* pungi

Dependencies
------------

No dependencies currently.

Playbook Structure
------------------

At a minimum, a pre task section should be added.

```
  pre_tasks:
    - name: Check if ansible cannot be run here
      stat:
        path: /etc/no-ansible
      register: no_ansible

    - name: Verify if we can run ansible
      assert:
        that:
          - "not no_ansible.stat.exists"
        success_msg: "We are able to run on this node"
        fail_msg: "/etc/no-ansible exists - skipping run on this node"

  # Import roles/tasks here
```

Post tasks for the lazybuilder aren't completely necessary.

Vars
----

It is *highly* recommended that you set vars for the lazy builder. There are some sane defaults that are already available, but sometimes they are not practical or you need to be specific on something. Below is a list of common vars you may want to consider setting from the default.

```
# base defaults
major          -> Major release version (eg, 8, 9...)
minor          -> Minor point release version
dist           -> defaults to el{{major}}
distro         -> defaults ro rocky

# modes
build_mode     -> defaults to mock
module_mode    -> defaults to false, set to true for module streams
transfer_mode  -> defaults to false, assumes the builder also has the repo

# mock settings
mock_arch      -> defaults to x86_64
mock_vendor    -> defaults ro Rocky
mock_packager  -> defaults to "Lazy Builder <releng@rockylinux.org>"
mock_multilib  -> boolean (ignored for non-x86 architectures)
mock_builder   -> defaults to rpmbuild, the user that will build rpms
mock_isolation -> defaults to auto, nspawn and simple are supported
                  simple is recommended for kernels for EL (as of 8)

# module settings
module_tracker -> defaults to file (this tracks the +XXX+ code)
module_stream  -> defaults to 1.0, HIGHLY RECOMMENDED that this is set properly
module_version -> defaults to A0B00YYYYMMDDHHMMSS (major, 0, minor, 0, timestamp)
                  you generally don't need to touch this

# build mode settings
bootstrap      -> defaults to false, use this when bootstrapping a major release
                  or bootstrapping for a new architecture
repo_path      -> defaults to /opt/repo on a given repo system. if the path is
                  different (eg, you are using an NFS mount), you may want to
                  change this value. Local repos (such as for bootstraps or
                  modules) end up in subdirectories here. If they don't exist
                  before mock is ran, they will be be created and createrepo_c
                  is ran.
mock_repo_path -> defaults to file://{{ repo_path }} - if the repos are on a
                  different system hosted by http(s), then you should change
                  this to reflect it as such. only used when bootstrapping.
                  note that module repos stay local first and then are later
                  transferred.
```

License
-------

MIT

Author Information
------------------

Louis Abel @nazunalika <label@rockylinux.org>
