class rancher_tools (
  $install_cli     = true,
  $cli_version     = '0.4.1',
  $compose_version = '0.12.2',
  $platform        = downcase($facts["kernel"]),
  $install_compose = true,
  $extract_path    = '/opt',
  $archive_type    = 'tar.gz',
  )
{
  file {'/usr/local/bin':
    ensure => 'directory',
  }
  # download and extract the cli archive
  # https://github.com/rancher/cli/releases/download/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz
  if $install_cli == true
  {
    archive { "/tmp/rancher-${platform}-amd64-v${cli_version}.${archive_type}":
      ensure       => present,
      extract      => true,
      extract_path => $extract_path,
      source       => "https://github.com/rancher/cli/releases/download/v${cli_version}/rancher-${platform}-amd64-v${cli_version}.${archive_type}",
      creates      => "${extract_path}/rancher-v0.4.1"
    }

    file { '/usr/local/bin/rancher':
      ensure => 'link',
      target => "/opt/rancher-v${cli_version}/rancher",
    }
  }

  # download and extract the compose archive
  # https://github.com/rancher/rancher-compose/releases/download/v0.12.2/rancher-compose-linux-amd64-v0.12.2.tar.gz
  if $install_compose == true
  {
    archive { "/tmp/rancher-compose-${platform}-amd64-v${compose_version}.${archive_type}":
      ensure       => present,
      extract      => true,
      extract_path => $extract_path,
      source       => "https://github.com/rancher/rancher-compose/releases/download/v${compose_version}/rancher-compose-${platform}-amd64-v${compose_version}.${archive_type}",
      creates      => "${extract_path}/rancher-compose-v${compose_version}"
    }

    file { '/usr/local/bin/rancher-compose':
      ensure => 'link',
      target => "/opt/rancher-compose-v${compose_version}/rancher-compose",
    }
  }
}
