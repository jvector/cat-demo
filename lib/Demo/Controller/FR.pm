package Demo::Controller::FR;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Demo::Controller::FR - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for Feature Requests.

=head1 METHODS

list : list all existing FRs
new  : allow a new FR to be created
edit/{id}   : allow an existing FR to be updated
close/{id}  : close an existing FR
upvote/{id}   : increment FR's upvote count
downvote/{id} : increment FR's downvote count

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Demo::Controller::FR in FR.');
}

sub list :Local {
    my ( $self, $c ) = @_;

    # Retrieve all FRs and store in stash (eventually)....
    $c->stash(FRs => [$c->model('DB::FR')->all]);
    # template will show upvote,downvote buttons if FR userID is not the current userid
    # template will show Edit button if FR userID is the current userid    

    # just for debug...
    #$c->stash(userid => 11);
    #$c->stash(FRs => [
#		  { id=>1, title=> 'dummy1', detail => 'detail dummy1', upvotes => 3, downvotes => 4, userid => 22},
#		  { id=>2, title=> 'dummy2', detail => 'detail dummy2', upvotes => 2, downvotes => 2, userid => 11},
#	      ]);
    
    $c->stash(template=>'fr_list.tt');
}


=encoding utf8

=head1 AUTHOR

Victor Churchill,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
