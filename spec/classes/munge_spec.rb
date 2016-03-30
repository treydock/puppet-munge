require 'spec_helper'

describe 'munge' do
  let :facts do
    {
      :osfamily => 'RedHat',
    }
  end

  it { should create_class('munge') }
  it { should contain_class('munge::params') }

  it { should contain_anchor('munge::start').that_comes_before('Class[munge::install]') }
  it { should contain_class('munge::install').that_comes_before('Class[munge::config]') }
  it { should contain_class('munge::config').that_notifies('Class[munge::service]') }
  it { should contain_class('munge::service').that_comes_before('Anchor[munge::end]') }
  it { should contain_anchor('munge::end') }

  include_context 'munge::install'
  include_context 'munge::config'
  include_context 'munge::service'

  # Test validate_array parameters
  [
    :package_manage_repo,
    :install_dev,
    :service_enable,
  ].each do |p|
    context "when #{p} => 'foo'" do
      let(:params) {{ p => 'foo' }}
      it { expect { should create_class('munge') }.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end

end
