# @summary Trigger grub.cfg regeneration when configuration changes.
# @param password Whether password management is enabled.
# @param config_file Path to defaults file.
# @param password_file Path to password fragment file.
# @param update_grub Whether to regenerate grub.cfg on changes.
# @param update_binary Path to grub-mkconfig/grub2-mkconfig.
class grub2::update (
  Boolean $password,
  Stdlib::Absolutepath $config_file,
  Stdlib::Absolutepath $password_file,
  Boolean $update_grub,
  String $update_binary,
) {
  if $password {
    $exec_subscribe = [File[$config_file], File[$password_file],]
  } else {
    $exec_subscribe = File[$config_file]
  }

  if $update_grub {
    exec { 'Update GRUB':
      command     => $update_binary,
      subscribe   => $exec_subscribe,
      refreshonly => true,
      path        => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    }
  }
}
