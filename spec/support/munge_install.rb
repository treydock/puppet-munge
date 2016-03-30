shared_context "munge::install" do

  context 'with package_manage_repo => true' do
    let(:params) {{ :package_manage_repo => true }}

    it { should contain_class('epel') }

    it do
      should contain_package('munge').only_with({
        :ensure   => 'present',
        :name     => 'munge',
        :require  => 'Yumrepo[epel]',
      })
    end

    it { should_not contain_package('munge-devel') }

    context 'and install_dev => true' do
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

  context 'with package_manage_repo => false' do
    let(:params) {{ :package_manage_repo => false }}

    it { should_not contain_class('epel') }

    it do
      should contain_package('munge').only_with({
        :ensure   => 'present',
        :name     => 'munge',
      })
    end

    it { should_not contain_package('munge-devel') }

    context 'and install_dev => true' do
      let(:params) {{
        :install_dev         => true,
        :package_manage_repo => false,
      }}

      it do
        should contain_package('munge-devel').only_with({
          :ensure   => 'present',
          :name     => 'munge-devel',
        })
      end
    end
  end

end
