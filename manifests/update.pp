class grub2::update inherits grub2 {

  if $update_grub {
    exec { 'Update GRUB':
      command => $update_binary,
    }
  }

}
