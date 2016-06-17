# class: grub2::config: See README for documentation
class grub2::config inherits grub2 {

  file { $grub2::config_file:
    ensure  => file,
    content => template($grub2::config_template),
  }

  if $grub2::password {
    file { '/etc/grub.d/50_password':
      ensure  => file,
      content => template($grub2::password_template),
      mode    => '0755',
    }
  }

}
