package Mokelog::Web::Controller::Root;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
__PACKAGE__->namespace('');

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

sub end  :ActionClass('RenderView') {}

__POLOCKY__;
