# File: 1-install_a_package.pp

exec { 'install_pip3':
  command => 'apt-get update && apt-get install -y python3-pip',
  path    => '/usr/bin:/bin',
  creates => '/usr/bin/pip3',
  unless  => 'which pip3',
}

exec { 'update_pip3':
  command => '/usr/bin/pip3 install --upgrade pip',
  path    => '/usr/bin',
  unless  => '/usr/bin/pip3 show pip | grep -q "Version: 21."',
  require => Exec['install_pip3'],
}

exec { 'install_flask_and_dependencies':
  command => '/usr/bin/pip3 install Flask==1.1.4 Werkzeug==0.16.1 Jinja2==2.11.3 MarkupSafe==1.1.1',
  path    => '/usr/bin',
  unless  => '/usr/bin/pip3 show Flask | grep -q "Version: 1.1.4" && /usr/bin/pip3 show Werkzeug | grep -q "Version: 0.16.1" && /usr/bin/pip3 show Jinja2 | grep -q "Version: 2.11.3" && /usr/bin/pip3 show MarkupSafe | grep -q "Version: 1.1.1"',
  require => Exec['update_pip3'],
}
