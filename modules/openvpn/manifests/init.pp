class openvpn::install {
    package { openvpn: ensure => installed }
}

class openvpn::config {
    File {
        require => Class["openvpn::install"],
        owner   => "root",
        group   => "root",
        mode    => 644
    }

    file {
        "/etc/openvpn/keys":
            ensure  => directory;
        "/etc/openvpn/dh1024.pem":
            source => "puppet:///modules/openvpn/dh1024.pem";
    }
}

class openvpn {
    include openvpn::config, openvpn::install
}