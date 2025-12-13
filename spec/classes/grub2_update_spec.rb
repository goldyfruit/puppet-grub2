require 'spec_helper'

describe 'grub2' do
  let(:facts) { { os: { family: 'Debian', name: 'Debian', release: { major: '13', full: '13' } }, efi: false } }

  context 'with password disabled' do
    it { is_expected.to compile.with_all_deps }

    it 'subscribes update exec to config only' do
      is_expected.to contain_exec('Update GRUB').that_subscribes_to('File[/etc/default/grub]')
    end
  end

  context 'with password enabled' do
    let(:params) do
      {
        password: true,
        password_username: 'root',
        password_pbkdf2_hash: 'grub.pbkdf2.sha512.1.fake',
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'subscribes update exec to config and password file' do
      is_expected.to contain_exec('Update GRUB').that_subscribes_to([
        'File[/etc/default/grub]',
        'File[/etc/grub.d/50_password]',
      ])
    end
  end
end
