# class: grub2::update: See README for documentation
class grub2::update inherits grub2 {

  if $grub2::update_grub {
    exec { 'Update GRUB':
      command     => $grub2::update_binary,
      refreshonly => true,
    }
  }

}
