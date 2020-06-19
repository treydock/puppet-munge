require 'spec_helper_acceptance'

describe 'munge class:' do
  if (fact('os.family') == 'RedHat' && fact('os.release.major').to_i >= 7) ||
     (fact('os.name') == 'Ubuntu' && fact('os.release.full') == '16.04')
    let(:user) { 'root' }
  else
    let(:user) { 'munge' }
  end

  case fact('os.family')
  when 'RedHat'
    dev_package = 'munge-devel'
  when 'Debian'
    dev_package = 'libmunge-dev'
  end

  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'munge': munge_key_source => 'puppet:///modules/site_munge/munge.key' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('munge') do
      it { is_expected.to be_installed }
    end

    describe package('munge-devel') do
      it { is_expected.not_to be_installed }
    end

    describe service('munge') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file('/etc/munge/munge.key') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 400 }
      it { is_expected.to be_owned_by user }
      it { is_expected.to be_grouped_into user }
    end
  end

  context 'when install_dev => true' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'munge':
        install_dev       => true,
        munge_key_source  => 'puppet:///modules/site_munge/munge.key',
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package(dev_package) do
      it { is_expected.to be_installed }
    end
  end
end
