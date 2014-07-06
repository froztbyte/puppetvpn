puppetvpn
=========

The point of this module is basically easy-mode openvpn connections, just by reusing the certs which puppet's already created for you.

It's based on original work by @mithrandi, so a fair hattip there as should be noted.

Howto
-----

Point to point VPNs can be defined as below. This will set up a p2p link between `brown` and `yellow`.

```
node 'yellow.example' {
    openvpn::tls {
        'brown.example':
            local_port  => '4434',
            remote_host => 'brown.example',
            remote_port => '4434',
            role        => 'server',
            cert        => '/var/lib/puppet/ssl/certs/yellow.example.pem',
            key         => '/var/lib/puppet/ssl/private_keys/yellow.example.pem',
            local_addr  => '192.0.2.1',
            remote_addr => '192.0.2.2'
    }
}
```

And a more hub-and-spoke setup can be done too. This will make `red` the hub, with `blue` and `green` being clients.

```
node 'red' {
    openvpn::server {
        'red.example':
            port      => '1194',
            server_ip => '192.0.2.1 255.255.255.0'
    }

    openvpn::server {
        'red5.example':
            port      => '1195',
            server_ip => '192.5.2.1 255.255.255.0',
            dev       => 'tun5',
            ccd       => 'ccd'
    }
}
```

```
node 'green.example' {
    openvpn::client {
        'green.example':
            remote_host => 'red.example'
    }

    openvpn::client {
        'green5.example':
            remote_host => 'red.example',
            remote_port => '1195',
            dev         => 'tun5'
    }
}
```

```
node 'blue.example' {
    openvpn::client {
        'blue.example':
            remote_host => 'red.example',
            remote_port => '1195'
    }
}
```
