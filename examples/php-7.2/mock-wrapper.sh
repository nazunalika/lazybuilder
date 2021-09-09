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
  --localrepo /var/lib/mock/php \
  /home/rpmbuild/rpmbuild/SRPMS/libzip-1.5.1-2.el8.src.rpm \
  /home/rpmbuild/rpmbuild/SRPMS/php-7.2.24-1.el8.src.rpm \
  /home/rpmbuild/rpmbuild/SRPMS/php-pear-1.10.5-9.el8.src.rpm \
  /home/rpmbuild/rpmbuild/SRPMS/php-pecl-apcu-5.1.12-2.el8.src.rpm \
  /home/rpmbuild/rpmbuild/SRPMS/php-pecl-zip-1.15.3-1.el8.src.rpm \
  --chain
