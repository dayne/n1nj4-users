#
# Cookbook:: n1nj4-users
# Recipe:: pi
#
# Copyright:: 2017, The Authors, All Rights Reserved.

pi_users = search(:users, 'groups:pi')

pi_ssh_keys = []
pi_users.each do |userinfo|
  next if userinfo['action'] && userinfo['action'].include?('remove')
  pi_ssh_keys += userinfo['ssh_keys'] if userinfo['ssh_keys']
end

include_recipe 'users'

user_account 'pi' do
  ssh_keys pi_ssh_keys
  action [ :lock ]
  only_if { File.exists?('/home/pi') }
  not_if { ENV['TEST_KITCHEN'] }
end
