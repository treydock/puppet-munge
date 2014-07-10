require 'spec_helper_acceptance'

describe 'munge class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'munge': munge_key_source => 'puppet:///modules/site_munge/munge.key' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('munge') do
      it { should be_installed }
    end

    describe package('munge-devel') do
      it { should_not be_installed }
    end

    describe service('munge') do
      it { should be_enabled }
      it { should be_running }
    end

    describe file('/etc/munge/munge.key') do
      it { should be_file }
      it { should be_mode 400 }
      it { should be_owned_by 'munge' }
      it { should be_grouped_into 'munge' }
    end
  end

  context 'when install_dev => true' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'munge':
        install_dev       => true,
        munge_key_source  => 'puppet:///modules/site_munge/munge.key',
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('munge-devel') do
      it { should be_installed }
    end
  end
end
