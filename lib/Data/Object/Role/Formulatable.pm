package Data::Object::Role::Formulatable;

use 5.014;

use strict;
use warnings;

use registry;
use routines;

use Data::Object::Role;
use Data::Object::RoleHas;
use Data::Object::Space;

use Scalar::Util ();

with 'Data::Object::Role::Buildable';
with 'Data::Object::Role::Errable';
with 'Data::Object::Role::Stashable';
with 'Data::Object::Role::Tryable';

requires 'formulate';

# VERSION

around BUILDARGS(@args) {
  my $results;

  $results = $self->formulate($self->$orig(@args));

  return $results;
}

around formulate($args) {
  my $results;

  $results = $self->formulation($args, $self->$orig($args));

  return $results;
}

method formulate_object(Str $name, Any $value) {
  my $results;

  my $package = Data::Object::Space->new($name)->load;

  if (Scalar::Util::blessed($value) && $value->isa($package)) {
    $results = $value;
  }
  elsif (ref $value eq 'ARRAY') {
    $results = [map $package->new($_), @$value];
  }
  else {
    $results = $package->new($value);
  }

  return $results;
}

method formulation(HashRef $args, HashRef[Str] $form) {
  my $results = {};

  for my $name (grep {exists $args->{$_}} sort keys %$form) {
    $results->{$name} = $self->formulate_object($form->{$name}, $args->{$name});
  }

  return $results;
}

1;
