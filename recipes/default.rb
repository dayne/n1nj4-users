#
# Cookbook Name:: n1nj4-users
# Recipe:: default
#

include_recipe 'users'

# groups_databag_bucket = groups
# groups_databag_name   = home
groups = data_bag_item(node['groups_databag_bucket'], node['groups_databag_name'])

group 'sysadmin' do |g|
  gid groups[g]
  action [ :create ]
end

if not node['user']['limit_sysadmin']
  %w( sysadmin ).each do |group|
    users_manage group do
      group_id groups[group]
      action [ :remove, :create ]
    end
  end
end

# node.default['authorization']['sudo']['passwordless'] = true
include_recipe 'sudo::default'
