package Mokelog::Data::Project;
use strict;
use warnings;
use base qw(Mokelog::Data::BaseObject );
use Mokelog::ObjectDriver;

__PACKAGE__->install_properties({
        columns => [ qw/project_id title description created_at updated_at/ ],
        datasource => 'project',
        primary_key => 'project_id',
        driver => Mokelog::ObjectDriver->driver,
        });

__PACKAGE__->setup_alias({
        id => 'project_id',
        });

1;
