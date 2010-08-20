package Mokelog::WAF::Middleware::AuthBasic;
use strict;
use parent qw(Plack::Middleware);
use Plack::Util::Accessor qw( realm authenticator );
use Scalar::Util;
use MIME::Base64;
use Plack::Request;

sub prepare_app {
    my $self = shift;

    my $auth = $self->authenticator or die 'authenticator is not set';
    if (Scalar::Util::blessed($auth) && $auth->can('authenticate')) {
        $self->authenticator(sub { $auth->authenticate(@_) });
    } elsif (ref $auth ne 'CODE') {
        die 'authenticator should be a code reference or an object that responds to authenticate()';
    }
}

sub call {
    my($self, $env) = @_;

    my $req = Plack::Request->new($env);
    my $user_from_cookie = $req->cookies->{user};
    warn $user_from_cookie;
    $user_from_cookie eq $env->{HTTP_AUTHORIZATION} or return $self->unauthorized;
    my $auth = $env->{HTTP_AUTHORIZATION};

warn 'in';
    if ($auth =~ /^Basic (.*)$/) {
warn 'in2';
        my($user, $pass) = split /:/, (MIME::Base64::decode($1) || ":");
        $pass = '' unless defined $pass;
        if ($self->authenticator->($user, $pass)) {
warn 'in3';
            $env->{REMOTE_USER} = $user;
            my $res = $self->app->($env);
            $res->cookies->{user} = $user;
            warn $user;
            return $res;
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

