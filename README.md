lazybuilder
===========

![lazybuilder (development)](https://img.shields.io/github/last-commit/nazunalika/lazybuilder/development) ![lazybuilder issues](https://img.shields.io/github/issues/nazunalika/lazybuilder) ![lazybuilder license](https://img.shields.io/badge/license-MIT-brightgreen.svg) ![lazybuilder discussion](https://img.shields.io/badge/Discussions-blue.svg) ![lazybuilder wiki](https://img.shields.io/badge/Wiki-blue.svg)

The lazybuilder lazily builds RPMs whether for bootstrapping purposes or otherwise. This isn't really a role, this isn't really a collection. This thing doesn't really know *what* it is. It's up for you to figure it out.

Ultimately, this is meant to be run by itself on an ansible box or imported as a project into tower (being careful with your tower settings). Right now it is built to be ran on an ansible box that is not tower.

Playbooks will sit in the root.

**Note**: If you are using lazybuilder in module mode, the modules must have simple requirements. Please review the lazybuilder `README.md` for more information.

Requirements
------------

This will require your systems to have the appropriate packages installed or at the very least the right `/bin`'s to go to perform the work.

Note that there are recommended version requirements for mock build hosts.

* `mock` -> `2.10`
* `rpm` -> `4.14` (`4.13` may work on EL7, but is **not** recommended)
* `createrepo_c` -> `0.16`

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
distro         -> defaults to rocky

# modes
build_mode     -> defaults to mock
module_mode    -> defaults to false, set to true for module streams
transfer_mode  -> defaults to false, assumes the builder also has the repo
               -> does nothing when module_mode is true

# mock settings
mock_arch      -> defaults to x86_64
mock_vendor    -> defaults ro Rocky
mock_packager  -> defaults to "Lazy Builder <releng@rockylinux.org>"
mock_multilib  -> boolean (ignored for non-x86 architectures)
mock_builder   -> defaults to rpmbuild, the user that will build rpms
mock_isolation -> defaults to auto, nspawn and simple are supported
                  simple is recommended for kernels for EL (as of 8)

# module settings
module_git_url -> URL slug to group/projects where RPM repos exist
                  eg. https://git.rockylinux.org/staging/rpms
module_git_repo -> git url to where the module data exists
module_git_branch -> set branch name to the stream name, eg r8-stream-1.4
module_tracker -> defaults to file (this tracks the +XXX+ code)

# build mode settings
source_name    -> defaults to "name" which will cause play to end. this should
                  be set to the rpm or module name you plan on building.
                  eg. bash for rpm or 389-ds for module
git_commit_hash -> Full hash or branch name to the RPM that you plan on building
git_source_url -> URL to where sources will be located in hashed form
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

# repo settings
generate_repo  -> defaults to false, set to true to generate repo data after a
                  transfer
```

License
-------

MIT

Author Information
------------------

Louis Abel @nazunalika <tucklesepk@gmail.com> <label@rockylinux.org>
