# class: grub2::params: See README for documentation
class grub2::params {
  $os_family = $facts['os']['family']
  $is_efi    = $facts['efi'] ? {
    true    => true,
    default => false,
  }

  $family_defaults = {
    'Debian' => {
      'config_file'         => '/etc/default/grub',
      'distributor'         => '$(lsb_release -i -s 2> /dev/null || echo Debian)',
      'install_binary_bios' => '/usr/sbin/grub-install',
      'install_binary_efi'  => '/usr/sbin/grub-install --efi-directory=/boot/efi',
      'package_name'        => ['grub-pc', 'grub-common'],
      'package_name_legacy' => 'grub-legacy',
      'update_binary'       => '/usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg',
    },
    'RedHat' => {
      'config_file'         => '/etc/default/grub',
      'distributor'         => "$(sed 's, release .*$,,g' /etc/system-release)",
      'install_binary_bios' => '/usr/sbin/grub2-install',
      'install_binary_efi'  => '/usr/sbin/grub2-install --efi-directory=/boot/efi',
      'package_name'        => ['grub2', 'grub2-tools'],
      'package_name_legacy' => undef,
      'update_binary'       => '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg',
    },
    'Gentoo' => {
      'config_file'         => '/etc/default/grub',
      'distributor'         => 'Gentoo',
      'install_binary_bios' => '/usr/sbin/grub2-install',
      'install_binary_efi'  => '/usr/sbin/grub2-install --efi-directory=/boot/efi',
      'package_name'        => ['sys-boot/grub'],
      'package_name_legacy' => undef,
      'update_binary'       => '/usr/sbin/grub2-mkconfig -o /boot/grub/grub.cfg',
    },
    'Suse' => {
      'config_file'         => '/etc/default/grub',
      'distributor'         => '$(lsb_release -i -r -s 2> /dev/null || echo SUSE)',
      'install_binary_bios' => '/usr/sbin/grub2-install',
      'install_binary_efi'  => '/usr/sbin/grub2-install --efi-directory=/boot/efi',
      'package_name'        => ['grub2'],
      'package_name_legacy' => undef,
      'update_binary'       => '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg',
    },
    'Archlinux' => {
      'config_file'         => '/etc/default/grub',
      'distributor'         => '$(lsb_release -i -r -s 2> /dev/null || echo Archlinux)',
      'install_binary_bios' => '/usr/bin/grub-install',
      'install_binary_efi'  => '/usr/bin/grub-install --efi-directory=/boot/efi',
      'package_name'        => ['grub'],
      'package_name_legacy' => undef,
      'update_binary'       => '/usr/bin/grub-mkconfig -o /boot/grub/grub.cfg',
    },
  }

  if $family_defaults[$os_family] == undef {
    fail("The ${module_name} module is not supported on ${os_family}")
  }

  $family_data = $family_defaults[$os_family]

  $install_binary_default = $is_efi ? {
    true    => $family_data['install_binary_efi'],
    default => $family_data['install_binary_bios'],
  }

  $background_image            = lookup('grub2::background_image', { 'default_value' => '' })
  $badram                      = lookup('grub2::badram', { 'default_value' => '' })
  $enable_blscfg               = lookup('grub2::enable_blscfg', { 'default_value' => false })
  $config_template             = lookup('grub2::config_template', { 'default_value' => 'grub2/default_grub.erb' })
  $cmdline_linux               = lookup('grub2::cmdline_linux', { 'default_value' => '' })
  $cmdline_linux_default       = lookup('grub2::cmdline_linux_default', { 'default_value' => 'quiet' })
  $cmdline_linux_recovery      = lookup('grub2::cmdline_linux_recovery', { 'default_value' => '' })
  $cmdline_xen                 = lookup('grub2::cmdline_xen', { 'default_value' => '' })
  $default_entry               = lookup('grub2::default_entry', { 'default_value' => '0' })
  $device_install              = lookup('grub2::device_install', { 'default_value' => [] })
  $disable_os_prober           = lookup('grub2::disable_os_prober', { 'default_value' => false })
  $disable_recovery            = lookup('grub2::disable_recovery', { 'default_value' => false })
  $disable_submenu             = lookup('grub2::disable_submenu', { 'default_value' => false })
  $disable_uuid                = lookup('grub2::disable_uuid', { 'default_value' => false })
  $enable_cryptodisk           = lookup('grub2::enable_cryptodisk', { 'default_value' => false })
  $gfxmode                     = lookup('grub2::gfxmode', { 'default_value' => '' })
  $hidden_timeout              = lookup('grub2::hidden_timeout', { 'default_value' => undef })
  $hidden_timeout_quiet        = lookup('grub2::hidden_timeout_quiet', { 'default_value' => undef })
  $install_binary              = lookup('grub2::install_binary', { 'default_value' => $install_binary_default })
  $install_grub                = lookup('grub2::install_grub', { 'default_value' => false })
  $remove_grub_legacy          = lookup('grub2::remove_grub_legacy', { 'default_value' => false })
  $package_ensure              = lookup('grub2::package_ensure', { 'default_value' => 'present' })
  $package_name                = lookup('grub2::package_name', { 'default_value' => $family_data['package_name'] })
  $package_name_legacy         = lookup('grub2::package_name_legacy', { 'default_value' => $family_data['package_name_legacy'] })
  $password                    = lookup('grub2::password', { 'default_value' => false })
  $password_file               = lookup('grub2::password_file', { 'default_value' => '/etc/grub.d/50_password' })
  $password_username           = lookup('grub2::password_username', { 'default_value' => '' })
  $password_pbkdf2_hash        = lookup('grub2::password_pbkdf2_hash', { 'default_value' => '' })
  $password_template           = lookup('grub2::password_template', { 'default_value' => 'grub2/50_password.erb' })
  $preload_modules             = lookup('grub2::preload_modules', { 'default_value' => '' })
  $recordfail_timeout          = lookup('grub2::recordfail_timeout', { 'default_value' => 5 })
  $save_default                = lookup('grub2::save_default', { 'default_value' => false })
  $serial_command              = lookup('grub2::serial_command', { 'default_value' => '' })
  $suse_btrfs_snapshot_booting = lookup('grub2::suse_btrfs_snapshot_booting', { 'default_value' => false })
  $terminal                    = lookup('grub2::terminal', { 'default_value' => '' })
  $timeout                     = lookup('grub2::timeout', { 'default_value' => 5 })
  $timeout_style               = lookup('grub2::timeout_style', { 'default_value' => 'countdown' })
  $tune                        = lookup('grub2::tune', { 'default_value' => '' })
  $update_binary               = lookup('grub2::update_binary', { 'default_value' => $family_data['update_binary'] })
  $update_grub                 = lookup('grub2::update_grub', { 'default_value' => true })
  $config_file                 = lookup('grub2::config_file', { 'default_value' => $family_data['config_file'] })
  $distributor                 = lookup('grub2::distributor', { 'default_value' => $family_data['distributor'] })
}
