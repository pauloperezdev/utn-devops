node default {}

node 'test.utn-devops.int' {
    if versioncmp($::puppetversion, '3.6.0') >= 0 {
        Package {
            allow_virtual => false,
        }
    }

    $app = {
        name => 'test-devops-utn',
        env => 'test',
        key => 'base64:DGFz2h4n4IqTeSE783XpyLtbrM9s2tNpdL8ftjxClQ4=',
        debug => 'false',
        log_level => 'debug',
        url => 'http://test.utn-devops.int:8081',
        db_database => 'test_devops_app',
        db_username => 'root',
        db_password => 'rootabcd',
        workdir => '/var/www/utn-devops-app',
        domain => 'utn-devops.int',
        user => 'service-app-user-01',
        group => 'service-app-user-01',
        hostname => 'test',
    }
    class {'app_config':
        app => $app
    }

    class { 'docker_install':
        variables => {
            compose_version => "1.25.4"
        }
    }

    class { 'docker_install::certificates':
        variables => $app
    }
}