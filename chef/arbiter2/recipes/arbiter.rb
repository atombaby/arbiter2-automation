#
# Cookbook:: arbiter2
# Recipe:: arbiter
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'arbiter2'

service 'arbiter2' do
  action :nothing
end

execute 'reload systemd' do
  command '/bin/systemctl daemon-reload'
  action :nothing
end

directory '/etc/systemd/system/arbiter2.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/systemd/system/arbiter2.service.d/override.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'etc/systemd/system/arbiter2.service.d/override.conf.erb'
  variables(
    lazy do
      { 'arb_uid' => Etc.getpwnam('arbiter').uid }
    end
  )
  notifies :run, 'execute[reload systemd]', :immediate
end

directory '/etc/arbiter' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/arbiter/config.toml' do
  source '/etc/arbiter/config.toml.erb'
  variables(
    'config' => node['arbiter']['config']
  )
  notifies :start, 'service[arbiter2]', :delayed
end

template \
  node['arbiter']['config']['processes']['whitelist_file'] do
  source '/etc/arbiter/whitelist.txt.erb'
  variables(
    'whitelisted_processes' => \
    node['arbiter']['whitelisted_processes']
  )
end

template '/etc/arbiter/templates/warning_email_template.txt' do
  source '/etc/arbiter/templates/warning_email_template.txt.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/arbiter/templates/nice_email_template.txt' do
  source '/etc/arbiter/templates/nice_email_template.txt.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/var/lib/arbiter/integrations.py' do
  source '/var/lib/arbiter/integrations.py.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
