require 'spec_helper'

describe 'munge' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to create_class('munge') }
      it { is_expected.to contain_class('munge::params') }

      it { is_expected.to contain_anchor('munge::start').that_comes_before('Class[munge::user]') }
      it { is_expected.to contain_class('munge::user').that_comes_before('Class[munge::repo]') }
      it { is_expected.to contain_class('munge::repo').that_comes_before('Class[munge::install]') }
      it { is_expected.to contain_class('munge::install').that_comes_before('Class[munge::config]') }
      it { is_expected.to contain_class('munge::config').that_notifies('Class[munge::service]') }
      it { is_expected.to contain_class('munge::service').that_comes_before('Anchor[munge::end]') }
      it { is_expected.to contain_anchor('munge::end') }

      context 'munge::user' do
        it do
          is_expected.to contain_group('munge').with(ensure: 'present',
                                                     name: 'munge',
                                                     gid: nil,
                                                     system: 'true',
                                                     forcelocal: 'true')
        end

        it do
          is_expected.to contain_user('munge').with(ensure: 'present',
                                                    name: 'munge',
                                                    uid: nil,
                                                    gid: 'munge',
                                                    shell: '/sbin/nologin',
                                                    home: '/var/run/munge',
                                                    managehome: 'false',
                                                    comment: "Runs Uid 'N' Gid Emporium",
                                                    system: 'true',
                                                    forcelocal: 'true')
        end

        context 'when munge_group_gid defined' do
          let(:params) { { munge_group_gid: 99 } }

          it { is_expected.to contain_group('munge').with_gid('99') }
        end

        context 'when munge_user_uid defined' do
          let(:params) { { munge_user_uid: 99 } }

          it { is_expected.to contain_user('munge').with_uid('99') }
        end

        context 'when manage_user => false' do
          let(:params) { { manage_user: false } }

          it { is_expected.not_to contain_group('munge') }
          it { is_expected.not_to contain_user('munge') }
        end
      end

      context 'munge::repo' do
        it do
          is_expected.to contain_class('epel')
        end

        context 'when manage_repo => false' do
          let(:params) { { manage_repo: false } }

          it { is_expected.not_to contain_class('epel') }
        end
      end

      context 'munge::install' do
        it do
          is_expected.to contain_package('munge').only_with(ensure: 'present',
                                                            name: 'munge')
        end

        it { is_expected.not_to contain_package('munge-devel') }

        context 'when install_dev => true' do
          let(:params) { { install_dev: true } }

          it do
            is_expected.to contain_package('munge-devel').only_with(ensure: 'present',
                                                                    name: 'munge-devel')
          end
        end
      end

      context 'munge::config' do
        it do
          is_expected.to contain_file('/etc/munge/munge.key').only_with(ensure: 'file',
                                                                        path: '/etc/munge/munge.key',
                                                                        owner: 'munge',
                                                                        group: 'munge',
                                                                        mode: '0400')
        end
      end

      context 'munge::service' do
        it do
          is_expected.to contain_service('munge').only_with(ensure: 'running',
                                                            enable: 'true',
                                                            name: 'munge',
                                                            hasstatus: 'true',
                                                            hasrestart: 'true')
        end
      end
    end
  end
end
