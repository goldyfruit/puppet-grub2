# class: grub2::update: See README for documentation
class grub2::update inherits grub2 {
  if $grub2::password {
    $exec_subscribe = [File[$grub2::config_file], File[$grub2::password_file],]
  } else {
    $exec_subscribe = File[$grub2::config_file]
  }

  if $grub2::update_grub {
    exec { 'Update GRUB':
      command     => $grub2::update_binary,
      subscribe   => $exec_subscribe,
      refreshonly => true,
    }
  }
}
