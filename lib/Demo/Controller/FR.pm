package Demo::Controller::FR;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Demo::Controller::FR - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for Feature Requests.

We don't have proper session management here, so we end up having to
shuttle the signed-in userid back and forth in the stash in order to
persist the signed-in state, which is rather ugly.

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

use Data::Dumper;

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Demo::Controller::FR in FR.');
}

sub list :Local {
    my ( $self, $c ) = @_;

    # Let template know the current user id:
    # Template will show upvote,downvote buttons if FR userID is not the current userid
    # Template will show Edit button if FR userID is the current userid    

    # Retrieve all FRs and store in stash ((obviously need to page if result set too big)
    $c->stash(FRs => [$c->model('DB::FR')->all]);

    $c->stash(template=>'fr_list.tt');
}

sub edit :Local {
    my ( $self, $c, @args ) = @_;
    my $fr_id = $args[0];
    my $userid = $args[1];
    $c->stash(FR => $c->model('DB::FR')->find($fr_id)); 
    $c->stash(userid => $userid);
    $c->stash(template=>'fr_edit.tt');
}

sub create :Local {
    my ( $self, $c, @args ) = @_;
    my $userid = $args[0];
    warn Dumper("userid is $userid");
    $c->stash(FR => {id=>0,
		     title=>'Give your feature request a title',
		     detail=>'Tell us about your feature'});
    $c->stash(userid => $userid);
    $c->stash(template=>'fr_edit.tt');
}

sub edit_save :Local {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $title     = $c->request->params->{title}     || '(omitted)';
    my $detail    = $c->request->params->{detail}    || '(omitted)';
    my $userid    = $c->request->params->{userid};
    my $id        = $c->request->params->{id};
    my $action    = $c->request->params->{Action};
    delete $c->request->params->{Action};

    use Data::Dumper; warn Dumper($c->request->params);
    
    if ($action eq 'Update') {
	$c->model( 'DB::FR' )->find($id)->update( $c->request->params );
    }
    elsif ($action eq 'Create') {
	# Delete the fake zero ID from params before create..
	delete $c->request->params->{id}; 
	$c->model('DB::FR')->create( $c->request->params );
    }
    elsif ($action eq 'Close') {
	$c->model( 'DB::FR' )->find($id)->update({ status => 'Closed'});
    }
    else {
	$c->detach('/error/',"unrecognised action $action");
    }
    
    # Back to main list page
    $c->stash(userid => $userid);
    $c->forward('list');    
}

sub upvote :Local {
    my ( $self, $c, @args ) = @_;
    my $id = $args[0];
    my $userid = $args[1];

    # add upvote to ORM -- 
    # the following came from StackOverflow and looks odd, 
    # (and screws emacs' syntax directed colouring :) but hey it works..
    $c->model('DB::FR')->find($id)->update ({upvotes => \'upvotes + 1'});

    $c->stash({userid => $userid});
    $c->forward('list');    
}

sub downvote :Local {
    my ( $self, $c, @args ) = @_;
    my $id = $args[0];
    my $userid = $args[1];

    # add dowvote to ORM -- 
    $c->model('DB::FR')->find($id)->update ({downvotes => \'downvotes + 1'});

    $c->stash({userid => $userid});
    $c->forward('list');    
}

sub signin :Local {
    my ( $self, $c ) = @_;
    $c->stash(template=>'fr_signin.tt');
}

sub signin_save :Local {
    my ($self, $c) = @_;
 
    # Retrieve the name value from the form,
    # create a new user or find an existing one, and stash the user ID
    my $name = $c->request->params->{name};

    my ($user, $userid) ;
    my $user_rs = $c->model('DB::User')->search(name => $name); 

    if ($user = $user_rs->next) { # we exist!
	$userid = $user->id;
	warn "existing user $userid : $name\n";	
    }
    else   # User isn't yet - create one and get its ID
    {
	$user = $c->model('DB::User')->create( {name => $name} );
	$userid = $user->id;
	warn "created user $userid : $name\n";
    }

    $c->stash({userid => $userid, username => $name});
    
    # Back to main list page
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
