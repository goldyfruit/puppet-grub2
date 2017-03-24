# puppet-grub2

[![Build Status](https://travis-ci.org/goldyfruit/puppet-grub2.svg?branch=master)](https://travis-ci.org/goldyfruit/puppet-grub2)
[![Puppet Forge](http://img.shields.io/puppetforge/v/goldyfruit/grub2.svg)](https://forge.puppetlabs.com/goldyfruit/grub2)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

This module manages GRUB 2 bootloader

## Supported distributions
- Ubuntu
- Debian
- Red Hat
- CentOS
- Gentoo
- SLES / OpenSuse
- Arch Linux

## Parameters

#### background_image
 - Specify a path to a background image
 - **STRING** : *Empty by default*

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

#### cmdline_linux_recovery
- Arguments passed to the kernel
- **STRING** : *Empty by default*

#### cmdline_xen
- Arguments passed to Xen
- **STRING** : *Empty by default*

#### default_entry
- Define on which kernel the system will boot
- **STRING** : *'0'*

#### device_install
- Define on which hard drive the MBR will be write
- **ARRAY** : *Empty by default*

#### disable_uuid
- Define if GRUB should use the UUID in the root= path
- **BOOL** : *false*

#### disable_os_prober
- Define if GRUB should add the results of os-prober to the menu
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
- **BOOL** : *false*

#### install_binary
- Path to GRUB installation command
- **ABSOLUTE_PATH** : *Value depends on Linux distribution*

#### update_binary
- Path to GRUB configuration file update command
- **ABSOLUTE_PATH** : *Value depends on Linux distribution*

#### install_grub
- Install the GRUB packages and install GRUB in the MBR
- **BOOL** : *false*

#### package_ensure
- Puppet stuff, define in which state should be the GRUB packages
- **STRING** : *'present'*

#### password
- Enable password to protect the GRUB configuration
- **BOOL** : *false*

#### password_username
- Set the username that will be able to edit the GRUB configuration
- **STRING** : *Empty by default*

#### password_pbkdf2_hash
- Set PBKDF2 password hash generated via grub-mkpasswd-pbkdf2 or grub2-mkpasswd-pbkdf2 commands
- **STRING** : *Empty by default*

#### recordfail_timeout
- Set default timeout value for GRUB2.
  Useful to stop headless machines stalling during boot.
- **INTEGER** : *5*

#### save_default
- If true, the last selected entry will become the new default one
  GRUB_DEFAULT should be set to "saved" and not to 0
- **BOOL** : *false*

#### serial_command
- Set settings for the serial console
- **STRING** : *Empty by default*

#### suse_btrfs_snapshot_booting
- Whether the root disk is a btrfs snapshot or not
- **BOOL** : *false*

#### terminal
- Define on which terminal the ouput should be display
- **STRING** : *Empty by default*

#### timeout
- Define how long (in seconds) that the menu should appear
- **INTEGER** : *5*

#### tune
- Define if GRUB should make a beep when he starts
- **STRING** : *Empty by default*

#### update_grub
- Regenerate the GRUB configuration after updates
- **BOOL** : *true*

### Example
```ruby
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
      device_install            => ['/dev/sda'],
      hidden_timeout            => 0,
      hidden_timeout_quiet      => false,
      recordfail_timeout        => 5,
      password                  => true,
      password_username         => 'chewbacca',
      password_pbkdf2_hash      => 'grub.pbkdf2.sha512.10000.EDBE1B820072D36A7B0059C7C33A2AA8B9D60888B0A44E7A566CB92E35F16A0F20770E79FB2E283680715ED916498D59B72F02599B461E4A087704E5E8A2A92D.911F2E7867A16DE76C170AD6E1C14D3F0AE2B7E1B58D1D967F98CEC9F2C2EAF7397ADE15CFB661CA94F6B7963A9C98BEFFB3026A4285FC04DB9F4118BDA39D58',
    }
```
### Hiera support

This module also supports the configuration of the parameters it exposes
using Hiera. You can do this by namespacing around `grub2`. For instance, to
set the value of `timeout` to `10`, you would use something like that in
your Hiera files:
```yaml
grub2::timeout: 10
```
