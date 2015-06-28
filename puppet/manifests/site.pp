stage{[uno,dos,tres,cuatro]:}
stage[uno] -> stage[dos] -> stage[tres] -> stage[cuatro]
class instalacion{
	exec{"yum -y install bind bind-utils":
		#ensure => present,
		creates => '/var/named',
		command => '/usr/bin/yum -y install bind bind-utils',
	}
}
class instalarDhcp{
	exec{"yum -y install dhcp":
		creates => '/etc/dhcp/dhcpd.conf',
		command => '/usr/bin/yum -y install dhcp',
	}
}
class reiniciarDHCP{
	exec{"service dhcpd restart":
		command => '/sbin/service dhcpd restart',
	}
}

class permisos{
	exec{"chown named:named /var/named/db.linux.org":
		command => '/bin/chown named:named /var/named/db.linux.org',
	} 
	exec{"chown named:named /var/named/db.127.0.0":
		command => '/bin/chown named:named /var/named/db.127.0.0',
	}
	exec{"service named start":
		command => '/sbin/service named start',
	}
	exec {"chkconfig named on":
		command => '/sbin/chkconfig named on',
	}
	exec {"firewall-cmd --permanent --zone=public --add-service=http":
		command => '/bin/firewall-cmd --permanent --zone=public --add-service=http',
	}
	exec{"firewall-cmd --permanent --zone=public --add-service=https":
		command => '/bin/firewall-cmd --permanent --zone=public --add-service=https',
	}
	exec{"firewall-cmd --reload":
		command => '/bin/firewall-cmd --reload',
	}
}

class reiniciarService{
	exec{"service network restart":
		command => '/sbin/service network restart',
	}

}
class configurarResolv{
	file{'/etc/resolv.conf':
		content => "#Generated by NetworkManager
search linux.org
domain linux.org
nameserver 127.0.0.1
"
	}
}

class{ 'instalacion' :stage => uno}
class{ 'instalarDhcp' :stage => dos}
class{ 'configurarResolv' :stage =>  tres}
class{ 'hola_mundo' :stage => cuatro}
node "puppet.linux.org" {
#	class['hola_mundo']~>class['permisos']
	include instalacion
	include instalarDhcp
#	include crearArchivoDB
#	include configurarifcfg
#	include reiniciarService
	include configurarResolv
##	include reiniciarDHCP
##	include crearArchivoDB
##	include crearArchivoDB
	include hola_mundo
	include permisos
#	include reiniciarService
	
}
#node "puppet.linux.org"{
#	include hola_mundo
#	include permisos
#	include reiniciarService
#}