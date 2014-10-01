# Class to configure ssl-cert-check on a node.
class tesora_cyclone::ssl_cert_check {
  class { '::ssl_cert_check':
    domainlist_file => '/var/lib/certcheck/ssldomains',
    email           => 'root',
    days            => '30'
  }

  file { '/var/lib/certcheck/ssldomains':
      ensure  => present,
      owner   => 'certcheck',
      group   => 'certcheck',
      mode    => '0444',
      source  => 'puppet:///modules/tesora_cyclone/ssl_cert_check/ssldomains'
  }
}
