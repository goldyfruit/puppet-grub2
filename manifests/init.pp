# == Class: grub2
#
# This module manages GRUB 2 bootloader
#
# === Parameters
#
# [*background_image*]
#   Specify a path to a background image
#   STRING : Empty by default
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
# [*cmdline_linux_recovery*]
#   Arguments passed to the kernel
#   STRING : Empty by default
#
# [*cmdline_xen*]
#   Arguments passed to Xen
#   STRING : Empty by default
#
# [*default_entry*]
#   Define on which kernel the system will boot
#   INTEGER : 0
#
# [*device_install*]
#   Define on which hard drive the MBR will be write
#   ARRAY : Empty by default
#
# [*disable_uuid*]
#   Define if GRUB should use the UUID in the root= path
#   BOOL : false
#
# [*disable_os_prober*]
#   Define if GRUB should add the results of os-prober to the menu
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
#   BOOL : false
#
# [*install_binary*]
#   Path to GRUB installation command
#   ABSOLUTE_PATH : Value depends on Linux distribution
#
# [*update_binary*]
#   Path to GRUB configuration file update command
#   ABSOLUTE_PATH : Value depends on Linux distribution
#
# [*install_grub*]
#   Install the GRUB packages and install GRUB in the MBR
#   BOOL : false
#
# [*package_ensure*]
#   Puppet stuff, define in which state should be the GRUB packages
#   STRING : 'present'
#
# [*password*]
#   Enable password to protect the GRUB configuration
#   BOOL : false
#
# [*password_username*]
#   Super user allowed to edit the GRUB configuration
#   STRING : 'present'
#
# [*password_pbkdf2_hash*]
#   Password hash generated via grub-mkpasswd-pbkdf2 or grub2-mkpasswd-pbkdf2 commands
#   STRING : 'present'
#
# [*recordfail_timeout*]
#   Set default timeout value for GRUB.
#   Without this set, headless machines may stall during boot
#   INTEGER : 5
#
# [*save_default*]
#   Save the last selected entry as the new default one
#   BOOL : false
#
# [*serial_command*]
#   Set settings for the serial console
#   STRING : Empty by default
#
# [*suse_btrfs_snapshot_booting*]
#   Whether the root disk is a btrfs snapshot or not
#   BOOL : false
#
# [*terminal*]
#   Define on which terminal the ouput should be display
#   STRING : Empty by default
#
# [*timeout*]
#   Define how long (in seconds) that the menu should appear
#   INTEGER : 5
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
#   device_install            => ['/dev/sda'],
#   password                  => true,
#   password_username         => 'chewbacca',
#   password_pbkdf2_hash      => 'grub.pbkdf2.sha512.10000.EDBE1B820072D36A7B0059C7C33A2AA8B9D60888B0A44E7A566CB92E35F16A0F20770E79FB2E283680715ED916498D59B72F02599B461E4A087704E5E8A2A92D.911F2E7867A16DE76C170AD6E1C14D3F0AE2B7E1B58D1D967F98CEC9F2C2EAF7397ADE15CFB661CA94F6B7963A9C98BEFFB3026A4285FC04DB9F4118BDA39D58',
# }
#
# === Authors
#
# Gaetan Trellu - goldyfruit <gaetan.trellu@incloudus.com>
#
# === Copyright
#
# Copyright 2014-2016 Gaetan Trellu
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
  $background_image            = $grub2::params::background_image,
  $badram                      = $grub2::params::badram,
  $cmdline_linux               = $grub2::params::cmdline_linux,
  $cmdline_linux_default       = $grub2::params::cmdline_linux_default,
  $cmdline_linux_recovery      = $grub2::params::cmdline_linux_recovery,
  $cmdline_xen                 = $grub2::params::cmdline_xen,
  $config_file                 = $grub2::params::config_file,
  $config_template             = $grub2::params::config_template,
  $default_entry               = $grub2::params::default_entry,
  $device_install              = $grub2::params::device_install,
  $disable_os_prober           = $grub2::params::disable_os_prober,
  $disable_recovery            = $grub2::params::disable_recovery,
  $disable_submenu             = $grub2::params::disable_submenu,
  $disable_uuid                = $grub2::params::disable_uuid,
  $distributor                 = $grub2::params::distributor,
  $gfxmode                     = $grub2::params::gfxmode,
  $hidden_timeout              = $grub2::params::hidden_timeout,
  $hidden_timeout_quiet        = $grub2::params::hidden_timeout_quiet,
  $install_binary              = $grub2::params::install_binary,
  $install_grub                = $grub2::params::install_grub,
  $package_ensure              = $grub2::params::package_ensure,
  $package_name                = $grub2::params::package_name,
  $password                    = $grub2::params::password,
  $password_username           = $grub2::params::password_username,
  $password_pbkdf2_hash        = $grub2::params::password_pbkdf2_hash,
  $recordfail_timeout          = $grub2::params::recordfail_timeout,
  $save_default                = $grub2::params::save_default,
  $serial_command              = $grub2::params::serial_command,
  $suse_btrfs_snapshot_booting = $grub2::params::suse_btrfs_snapshot_booting,
  $terminal                    = $grub2::params::terminal,
  $timeout                     = $grub2::params::timeout,
  $tune                        = $grub2::params::tune,
  $update_binary               = $grub2::params::update_binary,
  $update_grub                 = $grub2::params::update_grub,
) inherits grub2::params {

  validate_string($background_image)
  validate_string($badram)
  validate_string($cmdline_linux)
  validate_string($cmdline_linux_default)
  validate_string($cmdline_linux_recovery)
  validate_string($cmdline_xen)
  validate_absolute_path($config_file)
  validate_string($config_template)
  validate_string($default_entry)
  if is_string($device_install) {
    validate_string($device_install)
    warning('String type for this parameter is deprecated, please use an Array instead. See documentation at https://github.com/goldyfruit/puppet-grub2#device_install.')
  } else {
    validate_array($device_install)
  }
  validate_bool($disable_os_prober)
  validate_bool($disable_recovery)
  validate_bool($disable_submenu)
  validate_bool($disable_uuid)
  validate_string($distributor)
  validate_string($gfxmode)
  validate_string($hidden_timeout)
  validate_bool($hidden_timeout_quiet)
  validate_absolute_path($install_binary)
  validate_bool($install_grub)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_bool($password)
  validate_string($password_username)
  validate_string($password_pbkdf2_hash)
  validate_integer($recordfail_timeout)
  validate_bool($save_default)
  validate_string($serial_command)
  validate_bool($suse_btrfs_snapshot_booting)
  validate_string($terminal)
  validate_integer($timeout)
  validate_string($tune)
  validate_absolute_path($update_binary)
  validate_bool($update_grub)

  anchor { 'grub2::begin': } ->
  class { '::grub2::install': } ->
  class { '::grub2::config': } ~>
  class { '::grub2::update': } ->
  anchor { 'grub2::end': }

}
