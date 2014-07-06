define puppetvpn::client(
    $remote_host='', $remote_port='1194',
    $role='client',
    $comp_lzo='yes',
    $device='tun',
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
            content => template("openvpn/ovpn.erb");
    }
}
