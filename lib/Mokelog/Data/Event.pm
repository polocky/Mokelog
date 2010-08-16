package Mokelog::Data::Event;
use strict;
use warnings;
use base qw(Mokelog::Data::BaseObject );
use Mokelog::ObjectDriver;
use Mokelog::Data::Response;

__PACKAGE__->install_properties({
        columns => [ qw/event_id project_id title description created_by created_at updated_at/ ],
        datasource => 'event',
        primary_key => 'event_id',
        driver => Mokelog::ObjectDriver->driver,
        });

__PACKAGE__->has_a({ class => 'Mokelog::Data::Project', column => 'project_id' });

__PACKAGE__->setup_alias({
        id => 'event_id',
        });

__PACKAGE__->add_trigger(
    post_save => sub {
        my ( $obj,$orig_obj) = @_;
        my $project_obj = $obj->project_obj;
        $project_obj->updated_at($obj->updated_at);
        $project_obj->save;
        1;
    }
);

sub response_objs {
    my $self = shift;
    return Mokelog::Data::Response->search({event_id => $self->id},{ sort => 'created_at' ,direction => 'descend' } );
}

sub sexy_description {
    my $self = shift;
    my $text = Mokelog::Text->instance();
    $text->parse( $self->description , { name => 'event_' . $self->id } );
}

1;
