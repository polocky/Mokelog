use strict;
use warnings;
use utf8;
use Mokelog::Utils;
return +{
    default => {
        'middlewares' => [
        {
            'module' => '+Mokelog::WAF::Middleware::StackTrace'
        },
        #{
        #    'module' => 'Plack::Middleware::Debug'
        #},
        { 
            'module' => 'Plack::Middleware::Static' ,
            'opts' => {
                root => '__path_to(htdocs)__',
                'path' => '^/static/'
            },
        },
        {
            'module' => 'Plack::Middleware::Auth::Basic',
            opts => {
                authenticator => \&Mokelog::Utils::authenticator,
            },
        },
        ],
        'logger' => {
            'dispatchers' => [
                'screen'
                ],
            'screen' => {
                'stderr' => '1',
                'class' => 'Log::Dispatch::Screen',
                'min_level' => 'debug'
            }
        },
        'plugins' => [
#            'Polocky::WAF::CatalystLike::Plugin::ShowDispatcher',
            'Mokelog::WAF::Plugin::FillInForm',
        {
            'Mokelog::WAF::Plugin::FVL' => {
                yaml_file => '__path_to(conf/dfv.yaml)__',
            },
        },
        ],
    }
}
