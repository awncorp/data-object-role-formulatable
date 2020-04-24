use 5.014;

use strict;
use warnings;
use routines;

use lib 't/lib';

use Test::Auto;
use Test::More;

=name

Data::Object::Role::Formulatable

=cut

=abstract

Formulatable Role for Perl 5

=cut

=synopsis

  package Test::Person;

  use registry;
  use routines;

  use Data::Object::Class;
  use Data::Object::ClassHas;

  with 'Data::Object::Role::Formulatable';

  has 'fname' => (
    is => 'ro',
    isa => 'Object',
    req => 1
  );

  has 'dates' => (
    is => 'ro',
    isa => 'ArrayRef[Object]'
  );

  sub formulate {
    {
      fname => 'test/data/str',
      dates => 'test/data/str'
    }
  }

  package main;

  my $person = Test::Person->new({
    fname => 'levi nolan',
    dates => ['1587717124', '1587717169']
  });

  # $person->fname; # Test::Data::Str object
  # $person->dates; # Test::Data::Str object(s)

=cut

=libraries

Types::Standard

=cut

=integrates

Data::Object::Role::Buildable
Data::Object::Role::Errable
Data::Object::Role::Stashable
Data::Object::Role::Tryable

=cut

=description

This package provides a mechanism for automatically inflating objects from
constructor arguments.

=cut

package main;

my $test = testauto(__FILE__);

my $subs = $test->standard;

$subs->synopsis(fun($tryable) {
  ok my $result = $tryable->result;
  ok $result->isa('Test::Person');
  ok $result->does('Data::Object::Role::Formulatable');
  ok $result->can('formulate');
  ok $result->can('formulate_object');
  ok $result->can('formulation');

  is ref $result->dates, 'ARRAY';

  ok $result->fname;
  ok $result->fname->isa('Test::Data::Str');
  ok $result->dates->[0]->isa('Test::Data::Str');
  ok $result->dates->[1]->isa('Test::Data::Str');

  $result
});

ok 1 and done_testing;
