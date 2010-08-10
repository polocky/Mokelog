package Mokelog::Utils;
use warnings;
use strict;
use Polocky::Utils;
use Apache::Htpasswd ();

sub authenticator {
    my($username, $password) = @_;
    my $file = Polocky::Utils::config->auth('htpasswd_file');
    my $htpasswd = Apache::Htpasswd->new({
            passwdFile => $file,
            ReadOnly   => 1
        });
    return $htpasswd->htCheckPassword( $username ,$password );
}

1;
