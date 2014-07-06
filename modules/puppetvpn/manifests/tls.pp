define puppetvpn::tls(
    $local_host='', $local_port='',
    $remote_host='', $remote_port='',
    $role,
    $local_addr, $remote_addr,
    $comp_lzo='yes',
    $ping='10',
    $ping_restart='60',
    $ca='/var/lib/puppet/ssl/certs/ca.pem',
    $cert="/var/lib/puppet/ssl/certs/${certname}.pem",
    $key="/var/lib/puppet/ssl/private_keys/${certname}.pem",
    $dh='dh1024.pem') {

    $tls_remote = $name

    File {
        owner   => root,
        group   => root,
        mode    => 644,
        require => Class["puppetvpn::config"]
    }

    file {
        "/etc/openvpn/$name.conf":
            content => template("puppetvpn/tls.erb");
    }
}
