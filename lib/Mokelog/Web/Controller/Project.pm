package Mokelog::Web::Controller::Project;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
use Mokelog::Data::Project;
use Mokelog::Data::Event;

sub endpoint :Chained('/') :PathPart('project') :CaptureArgs(1) {
    my ($self, $c, $project_id ) = @_;
    my $project_obj = Mokelog::Data::Project->lookup($project_id) or $c->detach('/error');
    $c->stash->{project_obj} = $project_obj;
    return 1;
}

sub view : Chained('endpoint') :PathPart('') {
    my ($self, $c) = @_;
    my $project_obj = $c->stash->{project_obj};
    $c->stash->{template} = 'project/view.tt';
    my @event_objs = Mokelog::Data::Event->search({ project_id => $project_obj->id }, { sort => 'created_at' ,direction => 'descend' } );
    $c->stash->{event_objs} = \@event_objs;
}

__POLOCKY__;
