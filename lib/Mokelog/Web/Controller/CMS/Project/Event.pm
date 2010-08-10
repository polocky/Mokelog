package Mokelog::Web::Controller::CMS::Project::Event;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
use Mokelog::Data::Event;

sub endpoint :Chained('/cms/project/endpoint') :PathPart('event') :CaptureArgs(1) {
    my ($self, $c, $event_id ) = @_;
    my $project_obj = $c->stash->{project_obj};
    my $event_obj 
        = Mokelog::Data::Event->single({ event_id => $event_id, project_id => $project_obj->id } ) or $c->detach('/error');
    $c->stash->{event_obj} = $event_obj;
    return 1;
}

sub add :Chained('/cms/project/endpoint') :PathPart('event/add') { 
	my ( $self , $c ) = @_;
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_add');
    }
}

sub do_add : Private {
    my ( $self , $c ) = @_;
    my $project_obj = $c->stash->{project_obj} ;
    my $form 
        = $c->form({
            required => [qw/title description/],
        });
    return if $form->has_error ;
    my $v = $form->valid;
    my $event_obj = Mokelog::Data::Event->new(%$v,project_id => $project_obj->id , created_by => $c->req->user );
    $event_obj->save;
    $c->redirect('/project/' . $project_obj->id . '/' );
}

__POLOCKY__ ;
