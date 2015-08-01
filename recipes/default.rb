#
# Cookbook Name:: n1nj4-users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "users"

node.default['authorization']['sudo']['passwordless'] = true

%w( sysadmin ).each do |group|
  users_manage group do
    group_id 4711
    action [ :create ]
  end
end

#node['managed_user_groups'].each do |group_name, gid|
#  next if !gid
#  users_manage group_name do
#    group_id gid
#    action [:remove, :create]
#  end
#end

include_recipe 'sudo::default'
