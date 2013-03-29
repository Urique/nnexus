# /=====================================================================\ #
# |  NNexus Autolinker                                                  | #
# | Text Morphology Module                                              | #
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
package NNexus::Morphology;
###########################################################################
#	text morphology 
###########################################################################
# this code is verbatim from Aaron Krowne's Noosphere project except for changing
# the package name.
use strict;
use warnings;
use Encode qw{is_utf8};
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(is_possessive is_plural get_nonpossessive get_possessive depluralize root pluralize);

use utf8;
use feature qw(switch);

# 0. TODO: Think about MathML

# I. Possessives
# return true if a word is possessive (ends in 's or s')
sub is_possessive { $_[0]  =~ /^(\w|\-)+('s|s')(\s|$)/; }

# return phrase without possessive suffix ("Euler's" becomes "Euler")
sub get_nonpossessive {
  my ($word) = @_;
  $word =~ s/'s(\s|$)/$1/ || $word =~ s/s'(\s|$)/s$1/;
  $word;
}

# return first word with possessive suffix ("Euler" becomes "Euler's")
sub get_possessive {
  my ($word) = @_;
  $word =~ s/^(\w+)/$1'/;
  $word =~ s/^(\w+[^s])'/$1's/;
  $word;
}

# II. Plurality

# predicate for plural or not
sub is_plural { $_[0] ne depluralize($_[0]); }

sub pluralize {
  given ($_[0]) {
    # "root of unity" pluralizes as "roots of unity" for example
    when (/(\w+)(\s+(of|by)\s+.+)/)	{ return pluralize($1).$2; }
    # normal pluralization
    when (/(.+ri)x$/) {	return "$1ces"; }
    when (/(.+t)ex$/) { return "$1ices"; }
    when(/(.+[aeiuo])x$/) { return "$1xes";	}
    when(/(.+[^aeiou])y$/) { return "$1ies"; }
    when(/(.+)ee$/) { return "$1ees"; }
    when(/(.+)us$/) { return "$1i"; }
    when(/(.+)ch$/) { return "$1ches"; }
    when(/(.+)ss$/) { return "$1sses"; }
    default { return $_[0].'s'; }
  }
}

# singularize a word... remove root and replace
sub depluralize {
  given ($_[0]) {
    # "spaces of functions" depluralizes as "space of functions" for example.
    # also "proofs by induction"
    when (/(^\w[\w\s]+\w)(\s+(of|by)\s+.+)$/) {
      my ($l,$r) = ($1,$2);
      return depluralize($l).$r;
    }
    when(/(.+ri)ces$/) { return "$1x"; }
    when(/(.+t)ices$/) { return "$1ex";	}
    when(/(.+[aeiuo]x)es$/) { return $1; }
    when(/(.+)ies$/) { return "$1y"; }
    when(/(.+)ees$/) { return "$1ee"; }
    when(/(.+)ches$/) {	return "$1ch"; }
    when(/(.+o)ci$/) { return "$1cus"; }
    when(/(.+)sses$/) {	return "$1ss"; }
    when(/(.+ie)s$/) { return $1;	}
    when(/(.+[^eiuos])s$/) { return $1; }
    when(/(.+[^aeio])es$/) { return "$1e"; }
    default { return $_[0]; }
  }
}

# III. Stemming

# fake_stem - really elementary "stemming" algorithm
sub fake_stem {
  my $word = shift;
  $word = get_nonpossessive($word);
  $word = root($word);
  $word =~ s/'//g;
  return $word;
}

# get the non-plural root for a word
sub root {
  given ($_[0]) {
    when(/(.+ri)ces$/) { return $1; }
    when(/(.+[aeiuo]x)es$/) { return $1; }
    when(/(.+)ies$/) { return $1;	}
    when(/(.+)ches$/) {	return "$1ch"; }
    when(/(.+o)ci$/) { return "$1c"; }
    when(/(.+)sses$/) {	return "$1ss"; }
    when(/(.+[^eiuos])s$/) { return $1;	}
    when(/(.+[^aeio])es$/) { return "$1e"; }
    default { return $_[0]; }
  }
}



1;
__END__
