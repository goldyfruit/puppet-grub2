require 'spec_helper_acceptance'

describe 'grub2 class' do
  let(:manifest) do
    <<~MANIFEST
      class { 'grub2':
        update_grub => false,
      }
    MANIFEST
  end

  it 'applies idempotently' do
    idempotent_apply(manifest)
  end
end
