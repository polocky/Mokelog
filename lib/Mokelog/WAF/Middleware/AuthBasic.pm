package Mokelog::WAF::Middleware::AuthBasic;
use strict;
use parent qw(Plack::Middleware);
use Plack::Util::Accessor qw( realm authenticator );
use Scalar::Util;
use MIME::Base64;

sub prepare_app {
    my $self = shift;

    my $auth = $self->authenticator or die 'authenticator is not set';
    if (Scalar::Util::blessed($auth) && $auth->can('authenticate')) {
        $self->authenticator(sub { $auth->authenticate(@_) });
    } elsif (ref $auth ne 'CODE') {
        die 'authenticator should be a code reference or an object that responds to authenticate()';
    }
}

sub is_allow_path_info {
    my $self = shift;
    my $path_info = shift;
    return $path_info =~ /^\/(logout|register)/ ? 1 : 0;
}

sub call {
    my($self, $env) = @_;
    return $self->app->($env) if $self->is_allow_path_info($env->{PATH_INFO});

    my $auth = $env->{HTTP_AUTHORIZATION}
        or return $self->unauthorized;

    if ($auth =~ /^Basic (.*)$/) {
        my($user, $pass) = split /:/, (MIME::Base64::decode($1) || ":");
        $pass = '' unless defined $pass;
        if ($self->authenticator->($user, $pass)) {
            $env->{REMOTE_USER} = $user;
            return $self->app->($env);
        }
    }

    return $self->unauthorized;
}

sub unauthorized {
    my $self = shift;
    my $body = 'Authorization required';
    return [
        401,
        [ 'Content-Type' => 'text/plain',
          'Content-Length' => length $body,
          'WWW-Authenticate' => 'Basic realm="' . ($self->realm || "restricted area") . '"' ],
        [ $body ],
    ];
}

1;
