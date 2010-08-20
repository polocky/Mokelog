package Mokelog::FVL::Rule;
use warnings;
use strict;

sub members {
    my $text = shift;
    return ( $text =~ /^[a-z0-9_\,]+$/ ) ? 1 : 0;
}



1;
