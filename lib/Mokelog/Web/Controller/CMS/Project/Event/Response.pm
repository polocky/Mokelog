package Mokelog::Web::Controller::CMS::Project::Event::Response;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
use Mokelog::Data::Response;

sub endpoint :Chained('/cms/project/event/endpoint') :PathPart('response') :CaptureArgs(1) {
    my ($self, $c, $response_id ) = @_;
    my $event_obj = $c->stash->{event_obj};
    my $response_obj 
        = Mokelog::Data::Response->single({ response_id => $response_id,event_id => $event_obj->id } ) or $c->detach('/error');
    $c->stash->{response_obj} = $response_obj;
    return 1;
}

sub delete :Chained('endpoint') {
	my ( $self , $c ) = @_;
    my $response_obj = $c->stash->{response_obj};
    $c->detach('/error') unless $response_obj->created_by eq $c->req->user;
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_delete');
    }
}
sub do_delete : Private {
    my ( $self , $c ) = @_;
    my $response_obj = $c->stash->{response_obj};
    my $project_obj = $c->stash->{project_obj};
    $response_obj->remove;
    $c->redirect('/project/' . $project_obj->id . '/' );
}

sub add :Chained('/cms/project/event/endpoint') :PathPart('response/add') { 
	my ( $self , $c ) = @_;
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_add');
    }
}

sub do_add : Private {
    my ( $self , $c ) = @_;
    my $event_obj = $c->stash->{event_obj} ;
    my $form 
        = $c->form({
            required => [qw/description icon/],
        });
    return if $form->has_error ;
    my $v = $form->valid;
    my $response_obj = Mokelog::Data::Response->new(%$v,event_id => $event_obj->id , created_by => $c->req->user );
    $response_obj->save;
    $c->redirect('/project/' . $event_obj->project_id . '/' );
}

__POLOCKY__ ;
