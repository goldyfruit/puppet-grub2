# class: grub2::install: See README for documentation
class grub2::install inherits grub2 {

  if $grub2::install_grub {
    package { $grub2::package_name:
      ensure => $grub2::package_ensure,
    }

    if !empty($grub2::device_install) {
      each($grub2::device_install) |$device| {
        exec { "Install GRUB on ${device}":
          command => "${grub2::install_binary} ${device}",
        }
      }
    }
  }

}
