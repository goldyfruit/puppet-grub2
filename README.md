puppet-grub2
============

This module manages GRUB 2 bootloader

### Parameters

**badram**
&nbsp;&nbsp;&nbsp;&nbsp;Define some memory addresses for BadRAM filtering
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**config_template**
&nbsp;&nbsp;&nbsp;&nbsp;Template used for GRUB config file
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *'grub2/default_grub.erb'*

**cmdline_linux**
&nbsp;&nbsp;&nbsp;&nbsp;Arguments passed to the kernel
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**cmdline_linux_default**
&nbsp;&nbsp;&nbsp;&nbsp;Arguments passed to the kernel
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**default_entry**
&nbsp;&nbsp;&nbsp;&nbsp;Define on which kernel the system will boot
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *0*

**device_install**
&nbsp;&nbsp;&nbsp;&nbsp;Define on which hard drive the MBR will be write
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**disable_uuid**
&nbsp;&nbsp;&nbsp;&nbsp;Define if GRUB should use the UUID in the root= path
 &nbsp;&nbsp;&nbsp;&nbsp;BOOL : *false*

**disable_recovery**
&nbsp;&nbsp;&nbsp;&nbsp;Define if GRUB should display the recovery entry in the menu
&nbsp;&nbsp;&nbsp;&nbsp;BOOL : *false*

**gfxmode**
&nbsp;&nbsp;&nbsp;&nbsp;Define which resolution shoule be used if VBE is used
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**install_grub**
&nbsp;&nbsp;&nbsp;&nbsp;Install the GRUB packages and install GRUB in the MBR
&nbsp;&nbsp;&nbsp;&nbsp;BOOL : *False*

**package_ensure**
&nbsp;&nbsp;&nbsp;&nbsp;Puppet stuff, define in which state should be the GRUB packages
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *'present'*

**serial_command**
&nbsp;&nbsp;&nbsp;&nbsp;Set settings for the serial console
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**terminal**
&nbsp;&nbsp;&nbsp;&nbsp;Define on which terminal the ouput should be display
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**timeout**
&nbsp;&nbsp;&nbsp;&nbsp;Define how many time (in second) that the menu should appears
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *5*

**tune**
&nbsp;&nbsp;&nbsp;&nbsp;Define if GRUB should make a beep when he starts
&nbsp;&nbsp;&nbsp;&nbsp;STRING : *Empty by default*

**update_grub**
&nbsp;&nbsp;&nbsp;&nbsp;Regenerate the GRUB configuration after updates
&nbsp;&nbsp;&nbsp;&nbsp;BOOL : *true*

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