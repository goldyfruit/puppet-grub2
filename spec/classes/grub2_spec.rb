require 'spec_helper'

describe 'grub2' do
  stable_facts = on_supported_os(
    supported_os: [
      { 'operatingsystem' => 'Debian', 'operatingsystemrelease' => ['12'] },
      { 'operatingsystem' => 'Ubuntu', 'operatingsystemrelease' => ['24.04'] },
      { 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['9'] },
    ],
  )

  stable_facts.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.with_all_deps }
    end
  end

  [
    { name: 'Debian 13', facts: { os: { family: 'Debian', name: 'Debian', release: { major: '13', full: '13' } }, efi: false } },
    { name: 'Debian 11', facts: { os: { family: 'Debian', name: 'Debian', release: { major: '11', full: '11' } }, efi: false } },
    { name: 'Ubuntu 25.10', facts: { os: { family: 'Debian', name: 'Ubuntu', release: { major: '25', full: '25.10' } }, efi: false } },
    { name: 'Ubuntu 25.04', facts: { os: { family: 'Debian', name: 'Ubuntu', release: { major: '25', full: '25.04' } }, efi: false } },
    { name: 'Ubuntu 24.10', facts: { os: { family: 'Debian', name: 'Ubuntu', release: { major: '24', full: '24.10' } }, efi: false } },
    { name: 'RedHat 10', facts: { os: { family: 'RedHat', name: 'RedHat', release: { major: '10', full: '10' } }, efi: false } },
    { name: 'RedHat 8', facts: { os: { family: 'RedHat', name: 'RedHat', release: { major: '8', full: '8' } }, efi: false } },
    { name: 'Rocky 10', facts: { os: { family: 'RedHat', name: 'Rocky', release: { major: '10', full: '10' } }, efi: false } },
    { name: 'Rocky 8', facts: { os: { family: 'RedHat', name: 'Rocky', release: { major: '8', full: '8' } }, efi: false } },
    { name: 'AlmaLinux 10', facts: { os: { family: 'RedHat', name: 'AlmaLinux', release: { major: '10', full: '10' } }, efi: false } },
    { name: 'AlmaLinux 8', facts: { os: { family: 'RedHat', name: 'AlmaLinux', release: { major: '8', full: '8' } }, efi: false } },
    { name: 'Fedora 43', facts: { os: { family: 'RedHat', name: 'Fedora', release: { major: '43', full: '43' } }, efi: false } },
    { name: 'Arch Linux (rolling)', facts: { os: { family: 'Archlinux', name: 'Archlinux', release: { major: 'rolling', full: 'rolling' } }, efi: false } },
    { name: 'SLES 15', facts: { os: { family: 'Suse', name: 'SLES', release: { major: '15', full: '15' } }, efi: false } },
    { name: 'SLES 16', facts: { os: { family: 'Suse', name: 'SLES', release: { major: '16', full: '16' } }, efi: false } },
    { name: 'openSUSE Leap 15.6', facts: { os: { family: 'Suse', name: 'OpenSuSE', release: { major: '15', full: '15.6' } }, efi: false } },
  ].each do |os_data|
    context "on #{os_data[:name]}" do
      let(:facts) { os_data[:facts] }

      it { is_expected.to compile.with_all_deps }
    end
  end

  context 'on an unsupported operating system' do
    let(:facts) do
      {
        os: {
          family: 'Unsupported',
        },
      }
    end

    it 'fails compilation' do
      expect { catalogue }.to raise_error(%r{not supported})
    end
  end
end
