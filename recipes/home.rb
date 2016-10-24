#
# Cookbook Name:: n1nj4-users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


=begin
include_recipe 'chef-sugar::default'
if raspbian? 
  chef_gem 'ruby-shadow' do
    compile_time false if Chef::Resource::ChefGem.method_defined?(:compile_time)
    action :install
  end
end
=end

include_recipe "users"

# simplify sudo
node.default['authorization']['sudo']['passwordless'] = true

# create sysadmins group
group 'sysadmin' do
  gid 4711
  action [ :create, :modify ]
end

# create dayne account
%w( home ).each do |group|
  users_manage group do
    group_id 4712
    action [ :create ] 
  end
end

# manage pi by locking password and putting pi keys in place

#node['managed_user_groups'].each do |group_name, gid|
#  next if !gid
#  users_manage group_name do
#    group_id gid
#    action [:remove, :create]
#  end
#end

include_recipe 'sudo::default'
