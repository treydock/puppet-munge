shared_context "munge::install" do
  it { should contain_class('epel') }

  it do
    should contain_package('munge').only_with({
      :ensure   => 'present',
      :name     => 'munge',
      :require  => 'Yumrepo[epel]',
    })
  end
end
