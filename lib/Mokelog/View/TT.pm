package Mokelog::View::TT;
use Polocky::Class;
use Mokelog::Constants;
extends 'Polocky::View::TT';

sub fix_config {
    my $self = shift;
    my $config = shift;
    $config->{CONSTANTS}  = Mokelog::Constants->as_hashref();
    $config->{PRE_CHOMP}  = 1;
    $config->{POST_CHOMP} = 1;
}

__POLOCKY__;
