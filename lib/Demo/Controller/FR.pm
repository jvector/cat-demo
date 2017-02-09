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

    # Let template know the current user id:
    # Template will show upvote,downvote buttons if FR userID is not the current userid
    # Template will show Edit button if FR userID is the current userid    

    # Just for debug...
    $c->stash(userid => 3);

    # Retrieve all FRs and store in stash ((obviously need to page if result set too big)
    $c->stash(FRs => [$c->model('DB::FR')->all]);

    $c->stash(template=>'fr_list.tt');
}

sub edit :Local {
    my ( $self, $c, @args ) = @_;
    my $fr_id = $args[0];
    $c->stash(FR => $c->model('DB::FR')->find($fr_id));
    $c->stash(template=>'fr_edit.tt');
}

sub edit_save :Local {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $title     = $c->request->params->{title}     || '(none)';
    my $detail    = $c->request->params->{detail}    || '(none)';
 
    # Create the book
    # my $book = $c->model('DB::Book')->create({
    #         title   => $title,
    #         rating  => $rating,
    #     });
    # # Handle relationship with author
    # $book->add_to_book_authors({author_id => $author_id});
    # # Note: Above is a shortcut for this:
    # # $book->create_related('book_authors', {author_id => $author_id});
 
    # # Store new model object in stash and set template
    # $c->stash(book     => $book,
    #           template => 'books/create_done.tt2');
}

sub upvote :Local {
    my ( $self, $c, @args ) = @_;
    warn "upvote called with args $args[0], $args[1]\n";
    # add upvote to ORM
    $c->forward('list');    
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
