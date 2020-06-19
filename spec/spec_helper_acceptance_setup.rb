# Hack to work around issues with recent systemd and docker and running services as non-root
if (fact('os.family') == 'RedHat' && fact('os.release.major').to_i >= 7) ||
   (fact('os.name') == 'Ubuntu' && fact('os.release.full') == '16.04')
  service_hack = <<-EOS
[Service]
User=root
Group=root
EOS

  on hosts, 'mkdir -p /etc/systemd/system/munge.service.d'
  create_remote_file(hosts, '/etc/systemd/system/munge.service.d/hack.conf', service_hack)

  hiera_yaml = <<-EOS
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Common"
    path: "common.yaml"
EOS
  common_yaml = <<-EOS
---
munge::manage_user: false
munge::user: root
munge::group: root
munge::lib_dir: /var/lib/munge
munge::log_dir: /var/log/munge
munge::conf_dir: /etc/munge
munge::run_dir: /run/munge
EOS

  create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
  on hosts, 'mkdir -p /etc/puppetlabs/puppet/data'
  create_remote_file(hosts, '/etc/puppetlabs/puppet/data/common.yaml', common_yaml)
end
