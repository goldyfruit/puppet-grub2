puppet-grub2
============

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

#### gfxmode
- Define which resolution shoule be used if VBE is used
- **STRING** : *Empty by default*

#### install_grub
- Install the GRUB packages and install GRUB in the MBR
- **BOOL** : *False*

#### package_ensure
- Puppet stuff, define in which state should be the GRUB packages
- **STRING** : *'present'*

####  serial_command
- Set settings for the serial console
- **STRING** : *Empty by default*

#### terminal
- Define on which terminal the ouput should be display
- **STRING** : *Empty by default*

#### timeout
- Define how many time (in second) that the menu should appears
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
    }