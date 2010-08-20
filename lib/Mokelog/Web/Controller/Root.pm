package Mokelog::Web::Controller::Root;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
__PACKAGE__->namespace('');

use Mokelog::Utils;
use Mokelog::Data::Project;

sub default : Path {
    my ( $self, $c ) = @_;
    $c->res->code(404); 
    $c->res->body('>_<'); 
}

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    my @project_objs = Mokelog::Data::Project->search({},{ sort => 'updated_at' ,direction => 'descend' });
    $c->stash->{project_objs} = \@project_objs;
}
sub error : Private {
    my ( $self, $c ) = @_;
    $c->res->status(500);
    $c->res->body('-_-');
}

sub login : Local {
    my ( $self, $c ) = @_;
}
sub logout : Local {
    my ( $self, $c ) = @_;
}
sub register : Local {
    my ( $self, $c ) = @_;
    if( $c->req->method eq 'POST' ) {
        $c->detach('do_register');
    }
}

sub do_register : Private {
    my ( $self, $c ) = @_;

    my $form 
        = $c->form({
            required => [qw/user password/],
        });
    return if $form->has_error ;
    my $v = $form->valid;
    unless( $v->{password} eq $c->req->param('password_confirm') ) {
        $form->custom_invalid('password_confirm_not_much');
        return;
    }

    if( Mokelog::Utils::is_not_user( $v->{user} ) ) {
        Mokelog::Utils::user_add( $v->{user},$v->{password});
    }
    else {
        $form->custom_invalid('already_user');
        return;
    }

    $c->res->redirect('/');

}

sub end  :ActionClass('RenderView') {}

__POLOCKY__;
