puppet-grub2
============

[![Build Status](https://travis-ci.org/goldyfruit/puppet-grub2.svg?branch=master)](https://travis-ci.org/goldyfruit/puppet-grub2)
[![Puppet Forge](http://img.shields.io/puppetforge/v/goldyfruit/grub2.svg)](https://forge.puppetlabs.com/goldyfruit/grub2)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

This module manages GRUB 2 bootloader

## Parameters

#### badram
 - Define some memory addresses for BadRAM filtering
 - **STRING** : *Empty by default*

#### config_template
- Template used for GRUB config file
- **STRING** : *'grub2/default_grub.erb'*

#### cmdline_linux
- Arguments passed to the kernel
- **STRING** : *Empty by default*

#### cmdline_linux_default
- Arguments passed to the kernel
- **STRING** : *Empty by default*

#### cmdline_xen
- Arguments passed to Xen
- **STRING** : *Empty by default*

#### default_entry
- Define on which kernel the system will boot
- **STRING** : *0*

#### device_install
- Define on which hard drive the MBR will be write
- **STRING** : *Empty by default*

#### disable_uuid
- Define if GRUB should use the UUID in the root= path
- **BOOL** : *false*

#### disable_recovery
- Define if GRUB should display the recovery entry in the menu
- **BOOL** : *false*

#### disable_submenu
- Define if GRUB should display the submenu
- **BOOL** : *false*

#### gfxmode
- Define which resolution should be used if VBE is used
- **STRING** : *Empty by default*

#### hidden_timeout
- Define how long (in seconds) grub should wait for a user to enter the menu
- **STRING** : *Not present in config file by default*

#### hidden_timeout_quiet
- Define if the hidden timeout is quiet or not
- **BOOL** : *Not present in config file unless explicitly defined with true or false* 

#### install_grub
- Install the GRUB packages and install GRUB in the MBR
- **BOOL** : *False*

#### package_ensure
- Puppet stuff, define in which state should be the GRUB packages
- **STRING** : *'present'*

####  recordfail_timeout
- Set default timeout value for GRUB2.
  Useful to stop headless machines stalling during boot.
- **INTEGER** : *Empty by default*

####  serial_command
- Set settings for the serial console
- **STRING** : *Empty by default*

#### terminal
- Define on which terminal the ouput should be display
- **STRING** : *Empty by default*

#### timeout
- Define how long (in seconds) that the menu should appear
- **STRING** : *5*

#### tune
- Define if GRUB should make a beep when he starts
- **STRING** : *Empty by default*

#### update_grub
- Regenerate the GRUB configuration after updates
- **BOOL** : *true*

### Example

    class { 'grub2':
      update_grub               => false,
      install_grub              => false,
      cmdline_linux_default     => 'quiet crashkernel=256M nmi_watchdog=0 console=tty0 console=ttyS1,115200n8',
      terminal                  => 'serial console',
      default_entry             => 0,
      timeout                   => 5,
      serial_command            => 'serial --speed=115200 --unit=1 --word=8 --parity=no --stop=1',
      disable_uuid              => true,
      disable_recovery          => true,
      tune                      => '480 440 1',
      device_install            => '/dev/sda',
      hidden_timeout            => 0,
      hidden_timeout_quiet      => false,
      recordfail_timeout        => 5,
    }

### Hiera support

This module also supports the configuration of the parameters it exposes
using Hiera. You can do this by namespacing around `grub2`. For instance, to
set the value of `timeout` to `10`, you would use `grub2::timeout: 10` in
your Hiera files.
