#!/bin/bash
################################################################################
# Mock wrapper
#
# This is a template to do mock builds on a system (instead of directly calling
# mock with shell or command in ansible). It's just easier to address possible
# command line arguments this way via vars.
#
# Any possible configuration for the rpmbuild will be contained within the mock
# configuration file. Changes can be made by passing vars that override the
# defaults set out by this role.
#

/usr/bin/mock \
  --isolation=auto \
  --root /home/rpmbuild/rocky-8-x86_64.cfg \
  --localrepo /var/lib/mock/389-ds \
  /home/rpmbuild/rpmbuild/SRPMS/389-ds-base-1.4.3.16-19.el8.src.rpm \
  --chain
