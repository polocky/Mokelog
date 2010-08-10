package Mokelog::Data::Response;
use strict;
use warnings;
use base qw(Mokelog::Data::BaseObject );
use Mokelog::ObjectDriver;

__PACKAGE__->install_properties({
        columns => [ qw/response_id event_id description icon created_by created_at updated_at/ ],
        datasource => 'response',
        primary_key => 'response_id',
        driver => Mokelog::ObjectDriver->driver,
        });

__PACKAGE__->setup_alias({
        id => 'response_id',
        });

sub icon_path {
    my $self = shift;
    sprintf("/static/image/icon/%03d.gif",$self->icon);
}
1;
