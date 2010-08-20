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

sub is_not_user {
    my $username = shift;
    my $file = Polocky::Utils::config->auth('htpasswd_file');
    my $htpasswd = Apache::Htpasswd->new({
            passwdFile => $file,
            ReadOnly   => 1
        });
    return defined $htpasswd->fetchInfo($username) ? 1 : 0 ;
}

sub user_add {
    my $username = shift;
    my $password = shift;
    my $file = Polocky::Utils::config->auth('htpasswd_file');
    my $htpasswd = Apache::Htpasswd->new({
            passwdFile => $file,
            ReadOnly   => 0,
        });

    $htpasswd->htpasswd( $username , $password );

    1;
}
1;
