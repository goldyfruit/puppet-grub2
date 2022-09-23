# class: grub2::install: See README for documentation
class grub2::install inherits grub2 {
  $real_device_install = any2array($grub2::device_install)

  if $grub2::install_grub {
    package { $grub2::package_name:
      ensure => $grub2::package_ensure,
    }

    if !empty($real_device_install) {
      each($real_device_install) |$device| {
        exec { "Install GRUB on ${device}":
          command     => "${grub2::install_binary} ${device}",
          subscribe   => Package[$grub2::package_name],
          refreshonly => true,
        }
      }
    }
  }

  if $grub2::remove_grub_legacy {
    if $grub2::package_name_legacy {
      package { $grub2::package_name_legacy:
        ensure => absent,
      }
    }
  }
}
