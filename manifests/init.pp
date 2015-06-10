# == Class: grub2
#
# This module manages GRUB 2 bootloader
#
# === Parameters
#
# [*badram*]
#   Define some memory addresses for BadRAM filtering
#   STRING : Empty by default
#
# [*config_template*]
#   Template used for GRUB config file
#   STRING : 'grub2/default_grub.erb'
#
# [*cmdline_linux*]
#   Arguments passed to the kernel
#   STRING : Empty by default
#
# [*cmdline_linux_default*]
#   Arguments passed to the kernel
#   STRING : Empty by default
#
# [*cmdline_xen*]
#   Arguments passed to Xen
#   STRING : Empty by default
#
# [*default_entry*]
#   Define on which kernel the system will boot
#   STRING : 0
#
# [*device_install*]
#   Define on which hard drive the MBR will be write
#   STRING : Empty by default
#
# [*disable_uuid*]
#   Define if GRUB should use the UUID in the root= path
#   BOOL : false
#
# [*disable_recovery*]
#   Define if GRUB should display the recovery entry in the menu
#   BOOL : false
#
# [*disable_submenu*]
#   Define if GRUB should use the submenu
#   BOOL : false
#
# [*gfxmode*]
#   Define which resolution should be used if VBE is used
#   STRING : Empty by default
#
# [*hidden_timeout*]
#   Define how long (in seconds) grub should wait for a user to enter the menu
#   STRING : undef
#
# [*hidden_timeout_quiet*]
#   Define if the hidden timeout is quiet or not
#   BOOL : undef
#
# [*install_grub*]
#   Install the GRUB packages and install GRUB in the MBR
#   BOOL : False
#
# [*package_ensure*]
#   Puppet stuff, define in which state should be the GRUB packages
#   STRING : 'present'
#
# [*recordfail_timeout*]
#   Set default timeout value for GRUB2.
#   Without this set, headless machines may stall during boot.
#   STRING : undef
#
# [*serial_command*]
#   Set settings for the serial console
#   STRING : Empty by default
#
# [*terminal*]
#   Define on which terminal the ouput should be display
#   STRING : Empty by default
#
# [*timeout*]
#   Define how long (in seconds) that the menu should appear
#   STRING : 5
#
# [*tune*]
#   Define if GRUB should make a beep when he starts
#   STRING : Empty by default
#
# [*update_grub*]
#   Regenerate the GRUB configuration after updates
#   BOOL : true
#
# === Example
#
# class { 'grub2':
#   update_grub               => false,
#   install_grub              => false,
#   cmdline_linux_default     => 'quiet crashkernel=256M nmi_watchdog=0 console=tty0 console=ttyS1,115200n8',
#   terminal                  => 'serial console',
#   default_entry             => 0,
#   timeout                   => 5,
#   serial_command            => 'serial --speed=115200 --unit=1 --word=8 --parity=no --stop=1',
#   disable_uuid              => true,
#   disable_recovery          => true,
#   tune                      => '480 440 1',
#   device_install            => '/dev/sda',
# }
#
# === Authors
#
# Gaetan Trellu - goldyfruit <gaetan.trellu@incloudus.com>
#
# === Copyright
#
# Copyright 2014-2015 Gaetan Trellu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class grub2 (
  $badram                = $grub2::params::badram,
  $cmdline_linux         = $grub2::params::cmdline_linux,
  $cmdline_linux_default = $grub2::params::cmdline_linux_default,
  $cmdline_xen           = $grub2::params::cmdline_xen,
  $config_file           = $grub2::params::config_file,
  $config_template       = $grub2::params::config_template,
  $default_entry         = $grub2::params::default_entry,
  $device_install        = $grub2::params::device_install,
  $disable_recovery      = $grub2::params::disable_recovery,
  $disable_submenu       = $grub2::params::disable_submenu,
  $disable_uuid          = $grub2::params::disable_uuid,
  $distributor           = $grub2::params::distributor,
  $gfxmode               = $grub2::params::gfxmode,
  $hidden_timeout        = $grub2::params::hidden_timeout,
  $hidden_timeout_quiet  = $grub2::params::hidden_timeout_quiet,
  $install_binary        = $grub2::params::install_binary,
  $install_grub          = $grub2::params::install_grub,
  $package_ensure        = $grub2::params::package_ensure,
  $package_name          = $grub2::params::package_name,
  $recordfail_timeout    = $grub2::params::recordfail_timeout,
  $serial_command        = $grub2::params::serial_command,
  $terminal              = $grub2::params::terminal,
  $timeout               = $grub2::params::timeout,
  $tune                  = $grub2::params::tune,
  $update_binary         = $grub2::params::update_binary,
  $update_grub           = $grub2::params::update_grub,
) inherits grub2::params {

  validate_string($badram)
  validate_string($cmdline_linux)
  validate_string($cmdline_linux_default)
  validate_string($cmdline_xen)
  validate_absolute_path($config_file)
  validate_string($config_template)
  validate_string($default_entry)
  validate_string($device_install)
  validate_bool($disable_recovery)
  validate_bool($disable_submenu)
  validate_bool($disable_uuid)
  validate_string($distributor)
  validate_string($gfxmode)
  validate_string($hidden_timeout)
  validate_string($hidden_timeout_quiet)
  validate_string($install_binary)
  validate_bool($install_grub)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_integer($recordfail_timeout)
  validate_string($serial_command)
  validate_string($terminal)
  validate_string($timeout)
  validate_string($tune)
  validate_string($update_binary)
  validate_bool($update_grub)

  anchor { 'grub2::begin': } ->
  class { '::grub2::install': } ->
  class { '::grub2::config': } ~>
  class { '::grub2::update': } ->
  anchor { 'grub2::end': }

}
