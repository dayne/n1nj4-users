#
# Cookbook Name:: n1nj4-users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


# simplify sudo at home
node.default['authorization']['sudo']['passwordless'] = true
node.default['authorization']['sudo']['include_sudoers_d'] = true

node.default['user']['limit_sysadmin'] = true

groups = data_bag_item(node['groups_databag_bucket'],node['groups_databag_name'])

%w( home ).each do |group|
  users_manage group do
    group_id groups[group]
    action [ :remove, :create ]
  end
end

# TODO: manage pi by locking password and putting pi keys in place

# TODO: remove chef account
users_manage 'chef' do
  action [ :remove ]
end

include_recipe 'n1nj4-users::default'
include_recipe 'sudo::default'
