# /=====================================================================\ #
# |  NNexus Autolinker                                                  | #
# | Backend API Module                                                  | #
# |=====================================================================| #
# | Part of the Planetary project: http://trac.mathweb.org/planetary    | #
# |  Research software, produced as part of work done by:               | #
# |  the KWARC group at Jacobs University                               | #
# | Copyright (c) 2012                                                  | #
# | Released under the GNU Public License                               | #
# |---------------------------------------------------------------------| #
# | Adapted from the original NNexus code by                            | #
# |                                  James Gardner and Aaron Krowne     | #
# |---------------------------------------------------------------------| #
# | Deyan Ginev <d.ginev@jacobs-university.de>                  #_#     | #
# | http://kwarc.info/people/dginev                            (o o)    | #
# \=========================================================ooo==U==ooo=/ #

package NNexus::DB::API;
use strict;
use warnings;
use feature 'switch';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(add_object select_objectid_by_url);

### API for Table: Object

sub add_object {
  my ($db,%options) = @_;
  my ($url, $domain) = map {$options{$_}} qw(url domain);
  my $sth = $db->prepare("INSERT into object (url, domain) values (?, ?)");
  $sth->execute($url,$domain);
  $sth->finish();
  # Return the object id in order to update the concepts and classification
  return $db->last_inserted_id;
}

sub select_objectid_by_url {
  my ($db,$url) = @_;
  return unless $url;
  my $sth = $db->prepare("select objectid from object where (url = ?)");
  $sth->execute($url);
  my ($objectid) = $sth->fetchrow_array;
  $sth->finish();
  return $objectid;
}

### Generic DB API

sub last_inserted_id {
  my ($db) = @_;
  my $objid;
  given ($db->{dbms}) {
    when ('mysql') {
      $objid = $db->{handle}->{'mysql_insertid'};
    }
    when ('SQLite') {
      $objid = $db->{handle}->sqlite_last_insert_rowid();
    }
    default { die 'No DBMS information provided! Failing...'; }
  };
  return $objid;
}


1;
__END__

=pod 

=head1 NAME

C<NNexus::DB::API> - API routines for commonly used NNexus queries

=head1 SYNOPSIS

    use NNexus::DB;
    my $db = NNexus::DB->new(%options);
    $db->method(@arguments);

=head1 DESCRIPTION

This class provides API methods for specific SQL queries commonly needed by NNexus.

=head2 METHODS

=head3 Table: Object

=over 4

=item C<< $db->add_object(url=>$url,domain=>$domain); >>

Adds a new object, identified by a URL and, for convenience, a domain.

=item C<< $db->select_objectid_by_url($url); >>

Retrieve the internal objectid of an object, identified by its URL.

=back

=head3 Generic Methods

=over 4

=item C<< $db->last_inserted_id; >>

Return the last inserted id, in an auto-generated primary key column.
  DBMS-independent, supports MySQL and SQLite so far.

=back

=head1 AUTHOR

Deyan Ginev <d.ginev@jacobs-university.de>

=head1 COPYRIGHT

 Research software, produced as part of work done by 
 the KWARC group at Jacobs University Bremen.
 Released under the GNU Public License

=cut

