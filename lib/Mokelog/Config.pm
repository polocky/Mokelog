package Mokelog::Config;
use base qw(Polocky::Config);

sub auth {
    my $self = shift;
    my $section = shift; 
    return $self->_get( 'auth' , $section );
}  

sub database {
    my $self = shift;
    my $section = shift;
    return $self->_get( 'database' );
}
1;

