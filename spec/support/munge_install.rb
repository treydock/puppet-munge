shared_context "munge::install" do
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
