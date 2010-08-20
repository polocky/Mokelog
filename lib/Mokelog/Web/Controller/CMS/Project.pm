package Mokelog::Web::Controller::CMS::Project;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
use Mokelog::Data::Project;

sub endpoint :Chained('/') :PathPart('cms/project') :CaptureArgs(1) {
    my ($self, $c, $project_id ) = @_;
    my $project_obj = Mokelog::Data::Project->lookup($project_id) or $c->detach('/error');
    $project_obj->is_authorized($c->req->user) or $c->detach('/error');
    $c->stash->{project_obj} = $project_obj;
    return 1;
}


sub edit : Chained('endpoint') :PathPart('edit') {
	my ( $self , $c ) = @_;
    $c->stash->{template} = 'cms/project/edit.tt';
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_edit');
    }
    else {
        my $project_obj = $c->stash->{project_obj};
        my $fdat = $project_obj->as_fdat;
        $c->set_fillform( $fdat );
    }
}

sub do_edit : Private {
    my ( $self , $c ) = @_;
    my $form 
        = $c->form({
            required => [qw/title description/],
            optional => [qw/members/],
        });
    return if $form->has_error ;
    my $v = $form->valid;
    $v->{members} ||= '';
    my $project_obj = $c->stash->{project_obj};
    $project_obj->update_from_v( $v );
    $project_obj->save;
    $c->redirect('/');
}

sub add : Local {
	my ( $self , $c ) = @_;
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_add');
    }
}

sub do_add : Private {
    my ( $self , $c ) = @_;
    my $form 
        = $c->form({
            required => [qw/title description/],
            optional => [qw/members/],
        });
    return if $form->has_error ;
    my $v = $form->valid;
    $v->{created_by} =  $c->req->user;
    my $project_obj = Mokelog::Data::Project->new(%$v);
    $project_obj->save;
    $c->redirect('/');
}

__POLOCKY__ ;
