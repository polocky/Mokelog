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

#XXX somehow generate response_objs redefined warning.
#__PACKAGE__->has_a({ class => 'Mokelog::Data::Event', column => 'event_id' });
use Mokelog::Data::Event;

sub event_obj {
    my $self = shift;
    Mokelog::Data::Event->lookup($self->event_id);
}

__PACKAGE__->setup_alias({
        id => 'response_id',
        });

__PACKAGE__->add_trigger(
    post_save => sub {
        my ( $obj,$orig_obj) = @_;
        my $project_obj =  $obj->event_obj->project_obj;
        $project_obj->updated_at($obj->updated_at);
        $project_obj->save;
        
        1;
    }
);

sub icon_path {
    my $self = shift;
    sprintf("/static/image/icon/%03d.gif",$self->icon);
}
1;
