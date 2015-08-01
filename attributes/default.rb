default['user']['managed_user_groups'] = { sysadmin: 2300 }
default['user']['ssh_keygen'] = false

# sudo management
# These groups will be given sudo access on the node
default['authorization']['sudo']['groups'] = %w(wheel sysadmin)
# For now all users with sudo access can do it without a password
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['include_sudoers_d'] = true

case node['platform_family']
when 'rhel'
  default['authorization']['sudo']['sudoers_defaults'] = [
    '!visiblepw', 'env_reset',
    'env_keep = "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"',
    'env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"',
    'env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"',
    'env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"',
    'env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"',
    'env_keep += "HOME"', 'always_set_home',
    'secure_path = /sbin:/bin:/usr/sbin:/usr/bin'
  ]
when 'debian'
  if node['platform'] == 'ubuntu'
    default['authorization']['sudo']['sudoers_defaults'] = [
      'env_reset',
      'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
    ]
  end
end
