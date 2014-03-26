class grub2::config inherits grub2 {

  file { $grub2::config_file:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($grub2::config_template),
  }

}
