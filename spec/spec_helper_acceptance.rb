require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_module_on(hosts)
install_module_dependencies_on(hosts)
proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
copy_root_module_to(hosts, :source => File.join(proj_root, 'tests/site_munge'), :module_name => 'site_munge', :ignore_list => [])

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation
end
