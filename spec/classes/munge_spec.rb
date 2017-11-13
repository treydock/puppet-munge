require 'spec_helper'

describe 'munge' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should create_class('munge') }
      it { should contain_class('munge::params') }

      it { should contain_anchor('munge::start').that_comes_before('Class[munge::install]') }
      it { should contain_class('munge::install').that_comes_before('Class[munge::config]') }
      it { should contain_class('munge::config').that_notifies('Class[munge::service]') }
      it { should contain_class('munge::service').that_comes_before('Anchor[munge::end]') }
      it { should contain_anchor('munge::end') }

      context "munge::install" do
        it { should contain_class('epel') }

        it do
          should contain_package('munge').only_with({
            :ensure   => 'present',
            :name     => 'munge',
            :require  => 'Yumrepo[epel]',
          })
        end

        it { should_not contain_package('munge-devel') }

        context 'when install_dev => true' do
          let(:params) {{ :install_dev => true }}

          it do
            should contain_package('munge-devel').only_with({
              :ensure   => 'present',
              :name     => 'munge-devel',
              :require  => 'Yumrepo[epel]',
            })
          end
        end
      end

      context "munge::config" do
        it do
          should contain_file('/etc/munge/munge.key').only_with({
            :ensure  => 'file',
            :path    => '/etc/munge/munge.key',
            :owner   => 'munge',
            :group   => 'munge',
            :mode    => '0400',
          })
        end
      end

      context "munge::service" do
        it do
          should contain_service('munge').only_with({
            :ensure      => 'running',
            :enable      => 'true',
            :name        => 'munge',
            :hasstatus   => 'true',
            :hasrestart  => 'true',
          })
        end
      end
    end
  end
end
