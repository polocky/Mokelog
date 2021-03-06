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

sub default_values { +{
    members => '',
}; }

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
    my $members = ',' .  $self->members . ',';
    return $members =~ /\,$user\,/ ? 1 : 0;
}

1;
