class grub2::params {

  $badram                = ''
  $config_template       = 'grub2/default_grub.erb'
  $cmdline_linux         = ''
  $cmdline_linux_default = ''
  $default_entry         = 0
  $device_install        = ''
  $disable_uuid          = false
  $disable_recovery      = false
  $gfxmode               = ''
  $install_grub          = false
  $package_ensure        = 'present'
  $serial_command        = ''
  $terminal              = ''
  $timeout               = 5
  $tune                  = ''
  $update_grub           = true

  case $::osfamily {
    'Debian': {
      $config_file       = '/etc/default/grub'
      $distributor       = 'lsb_release -i -s 2> /dev/null || echo Debian'
      $install_binary    = '/usr/sbin/grub-install'
      $package_name      = [ 'grub-pc', 'grub-common' ]
      $update_binary     = '/usr/sbin/update-grub'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${operatingsystem} distribution.")
    }
  }

}
