require 'spec_helper'

describe 'grub2' do
  context 'with install enabled on RedHat' do
    let(:facts) { { os: { family: 'RedHat', name: 'RedHat', release: { major: '10', full: '10' } }, efi: false } }
    let(:params) do
      {
        install_grub: true,
        device_install: ['/dev/sda'],
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'manages packages and install exec' do
      is_expected.to contain_package('grub2').with_ensure('present')
      is_expected.to contain_package('grub2-tools').with_ensure('present')
      is_expected.to contain_exec('Install GRUB on /dev/sda').with(
        command: '/usr/sbin/grub2-install /dev/sda',
        refreshonly: true,
      )
    end
  end
end
