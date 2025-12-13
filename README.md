# Puppet Grub2

Tame GRUB 2 with sensible defaults, Hiera data, and distro-aware paths.

## Support Matrix
| Family | Releases | Notes |
| --- | --- | --- |
| Debian | 11, 12, 13 | Uses `/etc/default/grub`, `grub-mkconfig` |
| Ubuntu | 24.04, 24.10, 25.04, 25.10 | Uses `/etc/default/grub`, `grub-mkconfig` |
| Red Hat / Rocky / Alma | 8, 9, 10 | Uses `grub2-mkconfig`, `grub2-install` |
| Fedora | 43 | Uses `grub2-mkconfig`, `grub2-install` |
| SLES | 15, 16 | Uses `grub2-mkconfig`, `grub2-install` |
| OpenSUSE | Leap 15.x | Uses `grub2-mkconfig`, `grub2-install` |
| Arch Linux | rolling | Uses `/etc/default/grub`, `grub-mkconfig` |
| Gentoo | latest | Uses `/etc/default/grub`, `grub-mkconfig` |

Prereqs: the `efi` fact comes from `jcpunk-efi`—ensure that module is present on all hosts so BIOS/EFI is detected correctly.

## Quick start
```puppet
class { 'grub2':
  cmdline_linux_default => 'quiet splash',
  timeout               => 3,
  disable_recovery      => true,
}
```
Handles BIOS/EFI automatically via the `efi` fact, and regenerates `grub.cfg` when settings change.

## Common Options
| Parameter | Default | Purpose |
| --- | --- | --- |
| `cmdline_linux_default` | `'quiet'` | Kernel args for normal boot entries |
| `timeout` | `5` | Seconds before booting default |
| `timeout_style` | `'countdown'` | Prefer over `hidden_timeout*` |
| `install_grub` | `false` | Install GRUB packages and write bootloader |
| `device_install` | `[]` | Target devices (Array[Absolutepath]) |
| `password` | `false` | Enable GRUB superuser |
| `password_username` | `''` | Username for superuser |
| `password_pbkdf2_hash` | `''` | PBKDF2 hash for password |
| `enable_blscfg` | `false` | Enable BootLoaderSpec |
| `enable_cryptodisk` | `false` | Enable cryptodisk support |
| `serial_command` | `''` | Serial console definition |
| `terminal` | `''` | Terminal list (e.g., `serial console`) |
| `update_grub` | `true` | Run `grub-mkconfig`/`grub2-mkconfig` on changes |
| `config_template` | `grub2/default_grub.erb` | Template for defaults |
| `password_template` | `grub2/50_password.erb` | Template for superuser |

Hiera merges: `device_install` and `package_name` merge uniquely.

## Hiera example
```yaml
grub2::timeout: 10
grub2::cmdline_linux_default: "quiet crashkernel=256M"
grub2::device_install:
  - /dev/sda
grub2::save_default: true
grub2::enable_cryptodisk: true
grub2::password: true
grub2::password_username: "root"
grub2::password_pbkdf2_hash: "grub.pbkdf2.sha512...."
```

## Dev & Tests
```shell
bundle install
bundle exec rake spec
bundle exec puppet strings generate --out docs/api.md
# Acceptance (Litmus, Docker):
# Example single run; CI runs a trimmed matrix on known-available images (currently Debian 12, Rocky 9, Ubuntu 24.04). Adjust `.github/workflows/acceptance.yml` to add more when images are available.
bundle exec rake 'litmus:provision[docker,litmusimage/debian:12]'
bundle exec rake litmus:install_agent
bundle exec rake litmus:install_module
bundle exec rake litmus:acceptance:parallel
bundle exec rake litmus:tear_down
```
Unit specs cover additional future releases beyond this acceptance matrix; expand the matrix when images become available if you need runtime validation.

## Troubleshooting
- Missing `efi` fact? Ensure `jcpunk-efi` is installed on the host and rerun facts.
- Command not found (`grub-install`, `grub-mkconfig`/`grub2-mkconfig`)? Override `install_binary`/`update_binary` for the distro’s paths or install the right packages.

## Support
- Issues: https://github.com/goldyfruit/puppet-grub2/issues
- Source: https://github.com/goldyfruit/puppet-grub2
- Forge page: https://forge.puppet.com/modules/goldyfruit/grub2

## License
Apache 2.0.
