# @summary Manage GRUB 2 bootloader defaults and configuration across multiple Linux families.
# @param background_image Path to a background image.
# @param badram BadRAM filtering string.
# @param enable_blscfg Enable BootLoaderSpec configuration.
# @param cmdline_linux Kernel command line (always set).
# @param cmdline_linux_default Kernel command line for normal boot entries.
# @param cmdline_linux_recovery Kernel command line for recovery entries.
# @param cmdline_xen Xen hypervisor command line.
# @param config_file Absolute path to the defaults file.
# @param config_template Template used for the defaults file.
# @param default_entry GRUB default entry index/name.
# @param device_install Devices to install GRUB to (MBR/EFI).
# @param disable_os_prober Disable OS prober integration.
# @param disable_recovery Hide recovery entries.
# @param disable_submenu Disable submenu creation.
# @param disable_uuid Disable UUID usage in root=.
# @param distributor Distributor string for GRUB menus.
# @param enable_cryptodisk Enable cryptodisk support.
# @param gfxmode Video mode.
# @param hidden_timeout Deprecated hidden timeout seconds.
# @param hidden_timeout_quiet Deprecated hidden timeout quiet flag.
# @param install_binary Path to grub install binary (bios/efi).
# @param install_grub Whether to manage packages and run install.
# @param remove_grub_legacy Ensure legacy GRUB is absent.
# @param package_ensure Package ensure state.
# @param package_name Package names for GRUB2.
# @param package_name_legacy Legacy package name.
# @param password Enable GRUB superuser password.
# @param password_file Path to password fragment file.
# @param password_template Template for password fragment.
# @param password_username GRUB superuser name.
# @param password_pbkdf2_hash PBKDF2 hash for GRUB password.
# @param preload_modules Modules to preload.
# @param recordfail_timeout Timeout for recordfail.
# @param save_default Persist last booted entry as default.
# @param serial_command Serial console definition.
# @param suse_btrfs_snapshot_booting Enable SUSE btrfs snapshot booting.
# @param terminal Terminal list (e.g. serial console).
# @param timeout Menu timeout seconds.
# @param timeout_style Timeout style (e.g. countdown).
# @param tune Beep tune string.
# @param update_binary Path to grub-mkconfig/grub2-mkconfig.
# @param update_grub Whether to regenerate grub.cfg on changes.
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
#   password_pbkdf2_hash      => 'grub.pbkdf2.sha512.10000.EDBE1B820072D36A7B0059C7C33A2AA8B9D60888B039D58',
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
  String $background_image                          = $grub2::params::background_image,
  Optional[String] $badram                          = $grub2::params::badram,
  Boolean $enable_blscfg                            = $grub2::params::enable_blscfg,
  String $cmdline_linux                             = $grub2::params::cmdline_linux,
  String $cmdline_linux_default                     = $grub2::params::cmdline_linux_default,
  String $cmdline_linux_recovery                    = $grub2::params::cmdline_linux_recovery,
  String $cmdline_xen                               = $grub2::params::cmdline_xen,
  Stdlib::Absolutepath $config_file                 = $grub2::params::config_file,
  String $config_template                           = $grub2::params::config_template,
  String $default_entry                             = $grub2::params::default_entry,
  Array[Stdlib::Absolutepath] $device_install       = $grub2::params::device_install,
  Boolean $disable_os_prober                        = $grub2::params::disable_os_prober,
  Boolean $disable_recovery                         = $grub2::params::disable_recovery,
  Boolean $disable_submenu                          = $grub2::params::disable_submenu,
  Boolean $disable_uuid                             = $grub2::params::disable_uuid,
  String $distributor                               = $grub2::params::distributor,
  Boolean $enable_cryptodisk                        = $grub2::params::enable_cryptodisk,
  String $gfxmode                                   = $grub2::params::gfxmode,
  Optional[String] $hidden_timeout                  = $grub2::params::hidden_timeout,
  Optional[Boolean] $hidden_timeout_quiet           = $grub2::params::hidden_timeout_quiet,
  String $install_binary                            = $grub2::params::install_binary,
  Boolean $install_grub                             = $grub2::params::install_grub,
  Boolean $remove_grub_legacy                       = $grub2::params::remove_grub_legacy,
  String $package_ensure                            = $grub2::params::package_ensure,
  Array[String] $package_name                       = $grub2::params::package_name,
  Optional[String] $package_name_legacy             = $grub2::params::package_name_legacy,
  Boolean $password                                 = $grub2::params::password,
  Stdlib::Absolutepath $password_file               = $grub2::params::password_file,
  String $password_template                         = $grub2::params::password_template,
  String $password_username                         = $grub2::params::password_username,
  String $password_pbkdf2_hash                      = $grub2::params::password_pbkdf2_hash,
  Variant[String, Array[String]] $preload_modules   = $grub2::params::preload_modules,
  Integer $recordfail_timeout                       = $grub2::params::recordfail_timeout,
  Boolean $save_default                             = $grub2::params::save_default,
  String $serial_command                            = $grub2::params::serial_command,
  Boolean $suse_btrfs_snapshot_booting              = $grub2::params::suse_btrfs_snapshot_booting,
  String $terminal                                  = $grub2::params::terminal,
  Integer $timeout                                  = $grub2::params::timeout,
  String $timeout_style                             = $grub2::params::timeout_style,
  String $tune                                      = $grub2::params::tune,
  String $update_binary                             = $grub2::params::update_binary,
  Boolean $update_grub                              = $grub2::params::update_grub,
) inherits grub2::params {
  # Warn if timeout_style and either of the hidden_timout values are set, and respect old syntax
  $timeout_style_disable = if ($hidden_timeout_quiet =~ Boolean or $hidden_timeout =~ String) {
    warning('Newer timeout_style and at least one of deprecated hidden_timeout(_quiet)? defined at the same time. You should fix this.')
    true
  } else {
    false
  }

  $preload_modules_string = $preload_modules ? {
    Array  => join($preload_modules, ' '),
    default => $preload_modules,
  }

  anchor { 'grub2::begin': }
  -> class { 'grub2::install':
    device_install      => $device_install,
    install_grub        => $install_grub,
    install_binary      => $install_binary,
    package_ensure      => $package_ensure,
    package_name        => $package_name,
    remove_grub_legacy  => $remove_grub_legacy,
    package_name_legacy => $package_name_legacy,
  }
  ~> class { 'grub2::config':
    config_file                 => $config_file,
    config_template             => $config_template,
    password                    => $password,
    password_file               => $password_file,
    password_template           => $password_template,
    default_entry               => $default_entry,
    timeout_style               => $timeout_style,
    timeout_style_disable       => $timeout_style_disable,
    timeout                     => $timeout,
    hidden_timeout              => $hidden_timeout,
    hidden_timeout_quiet        => $hidden_timeout_quiet,
    distributor                 => $distributor,
    cmdline_linux_default       => $cmdline_linux_default,
    cmdline_linux_recovery      => $cmdline_linux_recovery,
    cmdline_linux               => $cmdline_linux,
    recordfail_timeout          => $recordfail_timeout,
    badram                      => $badram,
    terminal                    => $terminal,
    serial_command              => $serial_command,
    gfxmode                     => $gfxmode,
    disable_uuid                => $disable_uuid,
    disable_recovery            => $disable_recovery,
    disable_submenu             => $disable_submenu,
    enable_cryptodisk           => $enable_cryptodisk,
    tune                        => $tune,
    cmdline_xen                 => $cmdline_xen,
    disable_os_prober           => $disable_os_prober,
    suse_btrfs_snapshot_booting => $suse_btrfs_snapshot_booting,
    save_default                => $save_default,
    background_image            => $background_image,
    preload_modules             => $preload_modules_string,
    enable_blscfg               => $enable_blscfg,
  }
  -> class { 'grub2::update':
    password      => $password,
    config_file   => $config_file,
    password_file => $password_file,
    update_grub   => $update_grub,
    update_binary => $update_binary,
  }
  anchor { 'grub2::end': }
}
