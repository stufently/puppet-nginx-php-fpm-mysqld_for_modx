
yumrepo { "epel":
        enabled => 1,
        gpgcheck => 0
}

package {"mc":
        ensure => latest,
}

package {"php-fpm":
        ensure => latest,
}

package {"php":
        ensure => latest,
}

package {"php-mbstring":
        ensure => latest,
}

package {"php-php-gettext":
        ensure => latest,
}

package {"php-pear":
        ensure => latest,
}

package {"php-cli":
        ensure => latest,
}

package {"php-mysql":
        ensure => latest,
}

package {"php-mcrypt":
        ensure => latest,
}


package {"php-xml":
        ensure => latest,
}

package {"php-pdo":
        ensure => latest,
}

package {"php-gd":
        ensure => latest,
}


package {"mysql-server":
        ensure => latest,
}

package {"php-pecl-apc":
        ensure => latest,
}


package {"php-common":
        ensure => latest,
}

package {"nginx":
        ensure => latest,
}

package {"vsftpd":
        ensure => latest,
}

service { "nginx":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => [Package['nginx'],File['/etc/nginx/nginx.conf']],
      subscribe  => [File["/etc/nginx/nginx.conf"],File["/etc/nginx/conf.d/default.conf"]];
}

service { "vsftpd":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => [Package['vsftpd'],File['/etc/vsftpd/vsftpd.conf']],
      subscribe  => [File["/etc/vsftpd/vsftpd.conf"]];
}



service { "php-fpm":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => [Package['php-fpm'],File['/etc/php-fpm.conf'],File['/etc/php.ini']],
      subscribe  => [File["/etc/php-fpm.conf"],File["/etc/php-fpm.d/www.conf"],File['/etc/php.ini']];
}

service { "mysqld":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => [Package['mysql-server'],File['/etc/my.cnf']],
      subscribe  => [File["/etc/my.cnf"]];
}

file { "/etc/my.cnf":
      ensure => present,
      require => Package["mysql-server"],
      source => "puppet:///files/etc/my.cnf";
}


file { "/etc/php-fpm.conf":
      ensure => present,
      require => Package["php-fpm"],
      source => "puppet:///files/etc/php-fpm.conf";
}


file { "/etc/php-fpm.d/www.conf":
      ensure => present,
      require => Package["php-fpm"],
      source => "puppet:///files/etc/php-fpm.d/www.conf";
}


file { "/etc/nginx/nginx.conf":
      ensure => present,
      require => Package["nginx"],
      source => "puppet:///files/etc/nginx/nginx.conf";
}


file { "/etc/nginx/conf.d/default.conf":
      ensure => present,
      require => Package["nginx"],
      source => "puppet:///files/etc/nginx/conf.d/default.conf";
}


file { "/etc/php.d/apc.ini":
      ensure => present,
      require => Package["php-pecl-apc"],
      source => "puppet:///files/etc/php.d/apc.ini";
}

file { "/etc/php.ini":
      ensure => present,
      require => Package["php"],
      source => "puppet:///files/etc/php.ini";
}


file { "/etc/vsftpd/vsftpd.conf":
      ensure => present,
      require => Package["vsftpd"],
      source => "puppet:///files/etc/vsftpd/vsftpd.conf";
}
