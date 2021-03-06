#backend.pp
define varnish::backend(
  $host,
  $port,
  $max_connections = undef,
  $connect_timeout = undef,
  $first_byte_timeout = undef,
  $between_bytes_timeout = undef,
  $probe = undef,
) {

  validate_re($title,'^[A-Za-z0-9_]*$', "Invalid characters in backend name ${title}. Only letters, numbers and underscore are allowed.")

  if (!is_ip_address($host)) {
    fail("Backend host ${host} is not an IP Address!")
  }

  concat::fragment { "${title}-backend":
    target  => "${varnish::vcl::includedir}/backends.vcl",
    content => template('varnish/includes/backends.vcl.erb'),
    order   => '02',
  }
}
