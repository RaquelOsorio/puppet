class hola_mundo {
#	exec{"cp /var/named/named.localhost /var/named/db.127.0.0 && cp /var/named/named.localhost /var/named/db.linux.org":
#		command => '/bin/cp /var/named/named.localhost /var/named/db.127.0.0 && /bin/cp /var/named/named.localhost /var/named/db.linux.org',
#
#	}
#	exec{"cp /var/named/named.localhost /var/named/db.linux.org":
#		command => '/bin/cp /var/named/named.localhost /var/named/db.linux.org',
#	}
	file{"/etc/sysconfig/network-scripts/ifcfg-enp0s3":
		content => template("/etc/puppet/modules/hola_mundo/templates/sys.erb"),
	}
	file { "/etc/dhcp/dhcpd.conf" :
		content => template("/etc/puppet/modules/hola_mundo/templates/confdhcp.erb"),
	}
	file {"/etc/named.rfc1912.zones":
		content => template("/etc/puppet/modules/hola_mundo/templates/namedrfc.erb")
	}
	file {"/var/named/db.linux.org":
		ensure => present,
		content => template("/etc/puppet/modules/hola_mundo/templates/db1.erb"),
	}
	file {"/var/named/db.127.0.0":
		ensure => present,
		content => template("/etc/puppet/modules/hola_mundo/templates/db2.erb"),
	}
#	file {"/var/named/db.linux.org":
#		content => template("/etc/puppet/modules/hola_mundo/templates/db1.erb"),
#	}
}
