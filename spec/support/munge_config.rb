shared_context "munge::config" do
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
