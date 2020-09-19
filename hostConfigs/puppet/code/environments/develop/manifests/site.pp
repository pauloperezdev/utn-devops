node default {}

node 'develop.utn-devops.int' {
    if versioncmp($::puppetversion, '3.6.0') >= 0 {
        Package {
            allow_virtual => false,
        }
    }
    $app = {
        name => 'develop-devops-utn',
        env => 'develop',
        key => 'base64:DGFz2h4n4IqTeSE783XpyLtbrM9s2tNpdL8ftjxClQ4=',
        debug => 'true',
        log_level => 'debug',
        url => 'http://develop.utn-devops.int:8081',
        db_database => 'develop_devops_app',
        db_username => 'root',
        db_password => 'root',
        workdir => '/var/www/utn-devops-app',
        domain => 'utn-develop.int',
        user => 'service-app-user-01',
        group => 'service-app-user-01',
        hostname => 'develop',
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