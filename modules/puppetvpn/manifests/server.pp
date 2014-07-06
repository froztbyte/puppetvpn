define puppetvpn::server(
    $server_ip='',
    $port='',
    $role='server',
    $comp_lzo='yes',
    $device='tun',
    $c2c=true,
    $ccd='',
    $keepalive='10 120',
    $resolvretry='infinite',
    $duplicate_cn=true,
    $ca='/var/lib/puppet/ssl/certs/ca.pem',
    $cert="/var/lib/puppet/ssl/certs/${fqdn}.pem",
    $key="/var/lib/puppet/ssl/private_keys/${fqdn}.pem",
    $dh='dh1024.pem') {

    File {
        owner   => root,
        group   => root,
        mode    => 644,
        require => Class["puppetvpn::config"]
    }

    file {
        "/etc/openvpn/$name.conf":
            content => template("puppetvpn/ovpn.erb");
    }
}
