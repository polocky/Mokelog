package Mokelog::Data::Project;
use strict;
use warnings;
use base qw(Mokelog::Data::BaseObject );
use Mokelog::ObjectDriver;
use Mokelog::Text;

__PACKAGE__->install_properties({
        columns => [ qw/project_id title description created_by members created_at updated_at/ ],
        datasource => 'project',
        primary_key => 'project_id',
        driver => Mokelog::ObjectDriver->driver,
        });

__PACKAGE__->setup_alias({
        id => 'project_id',
        });

__PACKAGE__->add_trigger(
    pre_save => sub {
        my ( $obj,$orig_obj) = @_;
        if(my $members = $orig_obj->members()){
            $members = ','. $members . ',';
            $obj->members($members);
            $orig_obj->members($members);
        }
    },
);
__PACKAGE__->add_trigger(
    post_load => sub {
        my ( $obj ) = @_;
        if(my $members = $obj->members ){
           $members =~ s/^,//; 
           $members =~ s/,$//; 
           $obj->members($members);
        }
    }
);

sub sexy_description {
    my $self = shift;
    my $text = Mokelog::Text->instance();
    $text->parse( $self->description );
}

sub is_authorized {
    my $self = shift;
    my $user = shift;
    return 1 unless $self->members;
    return 1 if $user eq $self->created_by;
    return $self->members =~ /\,$user\,/ ? 1 : 0;
}

1;
