class grub2::config inherits grub2 {

  file { $config_file:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

}
