# Catalyst Feature Request Demo 

## Summary

This Catalyst app allows a user to view view feature requests (FRs).

If the user signs in they can add new feature requests and upvote/downvote existing feature requests.

A user can edit their own feature requests to update them after creation.

A user is not given the ability to upvote/downvote their own FRs.

## Installation

### Prerequisites

Please ensure you have:

* cpanminus installed;
  
* Catalyst installed;
**  cpanm Catalyst::Devel 

* Template Toolkit installed;
**   cpanm Template

* SQLite installed
**  sudo apt-get install sqlite3

In development it was found that some other dependencies needed to be satisfied. We had to manually do the following. YMMV.

* Catalyst DBIC Schema helper installed:
**  cpanm Catalyst::Helper::Model::DBIC::Schema
** cpanm DBIx::Class::Schema::Loader

* Other unexpected dependencies you may find are required :
**  cpanm Test::NoWarnings String::CamelCase String::ToIdentifier::EN Lingua::EN::Inflect::Phrase
**  cpanm Lingua::EN::Number::IsOrdinal
**  cpanm MooseX::NonMoose


# Assumptions and Limitations

We decided to let all users see the FR list before signing on.

Assumed that users 'own' their FRs, with functional implications as documented above.

No security measures in place - anyone can sign in as anyone.

"There's only one Jimmy Connors" - usernames have to be unique.

Nothing stopping a user from endless up/downvoting.

No screening of user text entered for HTML/JS/SQL/XSS attacks.
