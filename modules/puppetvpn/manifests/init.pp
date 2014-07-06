class puppetvpn::install {
    package { openvpn: ensure => installed }
}

class puppetvpn::config {
    File {
        require => Class["puppetvpn::install"],
        owner   => "root",
        group   => "root",
        mode    => 644
    }

    file {
        "/etc/openvpn/keys":
            ensure  => directory;
        "/etc/openvpn/dh1024.pem":
            source => "puppet:///modules/puppetvpn/dh1024.pem";
    }
}

class puppetvpn {
    include puppetvpn::config, puppetvpn::install
}
