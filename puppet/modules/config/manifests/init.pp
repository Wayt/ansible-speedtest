class config {
	file { '/etc/puppet-benchmark':
		ensure	=> 'directory'
	}

	file { '/etc/puppet-benchmark/firewall.conf.1':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.2':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.3':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.4':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.5':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.6':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.7':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.8':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.9':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}

	file { '/etc/puppet-benchmark/firewall.conf.10':
		ensure	=> 'file',
		content	=> template('config/firewall.conf.erb')
	}
}
