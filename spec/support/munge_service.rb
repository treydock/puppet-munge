shared_context "munge::service" do
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
