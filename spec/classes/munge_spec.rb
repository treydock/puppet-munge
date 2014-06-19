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

end
