use utf8;
package Demo::Schema::Result::Fr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Demo::Schema::Result::Fr

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<fr>

=cut

__PACKAGE__->table("fr");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 detail

  data_type: 'text'
  is_nullable: 1

=head2 upvotes

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 downvotes

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "detail",
  { data_type => "text", is_nullable => 1 },
  "upvotes",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "downvotes",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "status",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 userid

Type: belongs_to

Related object: L<Demo::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "userid",
  "Demo::Schema::Result::User",
  { id => "userid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-10 10:10:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mcIH5Pf6+92YCk2HM8Ul/g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
