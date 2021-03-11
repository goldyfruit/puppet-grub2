# class: grub2::params: See README for documentation
class grub2::params {

  $background_image            = ''
  $badram                      = ''
  $enable_blscfg               = false
  $config_template             = 'grub2/default_grub.erb'
  $cmdline_linux               = ''
  $cmdline_linux_default       = 'quiet'
  $cmdline_linux_recovery      = ''
  $cmdline_xen                 = ''
  $default_entry               = '0'
  $device_install              = []
  $disable_os_prober           = false
  $disable_recovery            = false
  $disable_submenu             = false
  $disable_uuid                = false
  $enable_cryptodisk           = false
  $gfxmode                     = ''
  $hidden_timeout              = undef
  $hidden_timeout_quiet        = false
  $install_grub                = false
  $remove_grub_legacy          = false
  $package_ensure              = 'present'
  $password                    = false
  $password_file               = '/etc/grub.d/50_password'
  $password_username           = ''
  $password_pbkdf2_hash        = ''
  $password_template           = 'grub2/50_password.erb'
  $preload_modules             = ''
  $recordfail_timeout          = 5
  $save_default                = false
  $serial_command              = ''
  $suse_btrfs_snapshot_booting = false
  $terminal                    = ''
  $timeout                     = 5
  $tune                        = ''
  $update_grub                 = true

  case $::osfamily {
    'Debian': {
      if $efi {
        $install_binary    = '/usr/sbin/grub-install --efi-directory=/boot/efi'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/efi/EFI/ubuntu/grub.cfg'
      } else {
        $install_binary    = '/usr/sbin/grub-install'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg'
      }
      $config_file         = '/etc/default/grub'
      $distributor         = '$(lsb_release -i -s 2> /dev/null || echo Debian)'
      $package_name        = [ 'grub-pc', 'grub-common' ]
      $package_name_legacy = 'grub-legacy'
    }
    'Redhat': {
      if $efi {
        $install_binary    = '/usr/sbin/grub-install --efi-directory=/boot/efi'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/efi/EFI/ubuntu/grub.cfg'
      } else {
        $install_binary    = '/usr/sbin/grub-install'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg'
      }
      $config_file         = '/etc/default/grub'
      $distributor         = "$(sed 's, release .*$,,g' /etc/system-release)"
      $package_name        = [ 'grub2', 'grub2-tools' ]
      $package_name_legacy = undef
    }
    'Gentoo': {
      if $efi {
        $install_binary    = '/usr/sbin/grub2-install --efi-directory=/boot/efi'
        $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/efi/EFI/gentoo/grub.cfg'
      } else {
        $install_binary    = '/usr/sbin/grub2-install'
        $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub/grub.cfg'
      }
      $config_file         = '/etc/default/grub'
      $distributor         = 'Gentoo'
      $package_name        = [ 'sys-boot/grub' ]
      $package_name_legacy = undef
    }
    'Suse': {
      if $efi {
        $install_binary    = '/usr/sbin/grub2-install --efi-directory=/boot/efi'
        $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/efi/EFI/gentoo/grub.cfg'
      } else {
        $install_binary    = '/usr/sbin/grub2-install'
        $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg'
      }
      $config_file         = '/etc/default/grub'
      $distributor         = '$(lsb_release -i -r -s 2> /dev/null || echo SUSE)'
      $package_name        = [ 'grub2' ]
      $package_name_legacy = undef
    }
    'Archlinux': {
      if $efi {
        $install_binary    = '/usr/sbin/grub-install --efi-directory=/boot/efi'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/efi/EFI/ubuntu/grub.cfg'
      } else {
        $install_binary    = '/usr/sbin/grub-install'
        $update_binary     = '/usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg'
      }
      $config_file         = '/etc/default/grub'
      $distributor         = '$(lsb_release -i -r -s 2> /dev/null || echo Archlinux)'
      $package_name        = [ 'grub' ]
      $package_name_legacy = undef
    }
    default: {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }

}
