# @summary Manage GRUB packages and optional bootloader installation.
# @param device_install Devices to install GRUB to (MBR/EFI).
# @param install_grub Whether to manage packages and run install.
# @param install_binary Path to grub install binary (bios/efi).
# @param package_ensure Package ensure state.
# @param package_name Package names for GRUB2.
# @param remove_grub_legacy Ensure legacy GRUB is absent.
# @param package_name_legacy Legacy package name.
class grub2::install (
  Array[Stdlib::Absolutepath] $device_install,
  Boolean $install_grub,
  String $install_binary,
  String $package_ensure,
  Array[String] $package_name,
  Boolean $remove_grub_legacy,
  Optional[String] $package_name_legacy,
) {
  $real_device_install = any2array($device_install)

  if $install_grub {
    package { $package_name:
      ensure => $package_ensure,
    }

    if !empty($real_device_install) {
      each($real_device_install) |$device| {
        exec { "Install GRUB on ${device}":
          command     => "${install_binary} ${device}",
          subscribe   => Package[$package_name],
          refreshonly => true,
          path        => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
        }
      }
    }
  }

  if $remove_grub_legacy {
    if $package_name_legacy {
      package { $package_name_legacy:
        ensure => absent,
      }
    }
  }
}
