package Mokelog::ObjectDriver;
use warnings;
use strict;
use Data::ObjectDriver::Driver::DBI;
use Mokelog::Config;

sub driver {
    my $self = shift;
    my $config = Mokelog::Config->instance->database;
    Data::ObjectDriver::Driver::DBI->new( %$config );
}

1;
