# @summary Render GRUB defaults and optional password fragments.
# @param config_file Path to write the defaults.
# @param config_template Template used for defaults.
# @param password Whether to manage password file.
# @param password_file Path to password file.
# @param password_template Template used for password file.
# @param default_entry GRUB default entry index/name.
# @param timeout_style Timeout style.
# @param timeout_style_disable Whether hidden timeout overrides timeout_style.
# @param timeout Menu timeout seconds.
# @param hidden_timeout Hidden timeout seconds.
# @param hidden_timeout_quiet Hidden timeout quiet flag.
# @param distributor Distributor string for GRUB menus.
# @param cmdline_linux_default Kernel command line for normal boot.
# @param cmdline_linux_recovery Kernel command line for recovery.
# @param cmdline_linux Kernel command line (always set).
# @param recordfail_timeout Timeout for recordfail.
# @param badram BadRAM filtering string.
# @param terminal Terminal list.
# @param serial_command Serial console definition.
# @param gfxmode Video mode.
# @param disable_uuid Disable UUID usage in root=.
# @param disable_recovery Hide recovery entries.
# @param disable_submenu Disable submenu creation.
# @param enable_cryptodisk Enable cryptodisk support.
# @param tune Beep tune string.
# @param cmdline_xen Xen hypervisor command line.
# @param disable_os_prober Disable OS prober integration.
# @param suse_btrfs_snapshot_booting Enable SUSE btrfs snapshot booting.
# @param save_default Persist last booted entry as default.
# @param background_image Path to a background image.
# @param preload_modules Modules to preload.
# @param enable_blscfg Enable BootLoaderSpec configuration.
class grub2::config (
  Stdlib::Absolutepath $config_file,
  String $config_template,
  Boolean $password,
  Stdlib::Absolutepath $password_file,
  String $password_template,
  String $default_entry,
  String $timeout_style,
  Boolean $timeout_style_disable,
  Integer $timeout,
  Optional[String] $hidden_timeout,
  Optional[Boolean] $hidden_timeout_quiet,
  String $distributor,
  String $cmdline_linux_default,
  String $cmdline_linux_recovery,
  String $cmdline_linux,
  Optional[Integer] $recordfail_timeout,
  String $badram,
  String $terminal,
  String $serial_command,
  String $gfxmode,
  Boolean $disable_uuid,
  Boolean $disable_recovery,
  Boolean $disable_submenu,
  Boolean $enable_cryptodisk,
  String $tune,
  String $cmdline_xen,
  Boolean $disable_os_prober,
  Boolean $suse_btrfs_snapshot_booting,
  Boolean $save_default,
  String $background_image,
  String $preload_modules,
  Boolean $enable_blscfg,
) {
  file { $config_file:
    ensure  => file,
    content => template($config_template),
  }

  if $password {
    file { $password_file:
      ensure  => file,
      content => template($password_template),
      mode    => '0755',
    }
  }
}
