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

requires 'formulate';

# VERSION

around BUILDARGS(@args) {
  my $results;

  $results = $self->formulate($self->$orig(@args));

  return $results;
}

around formulate($args) {
  my $results;

  my $form = $self->$orig($args);

  # before
  if ($self->can('before_formulate')) {
    my $config = $self->before_formulate($args);

    for my $key (keys %$config) {
      next unless $form->{$key};
      next unless exists $args->{$key};

      my $name = $config->{$key} eq '1' ?
        "before_formulate_${key}" : $config->{$key};

      next unless $self->can($name);

      $args->{$key} = $self->$name($args->{$key});
    }
  }

  # formulation
  $results = $self->formulation($args, $form);

  # after
  if ($self->can('after_formulate')) {
    my $config = $self->after_formulate($results);

    for my $key (keys %$config) {
      next unless $form->{$key};
      next unless exists $results->{$key};

      my $name = $config->{$key} eq '1' ?
        "after_formulate_${key}" : $config->{$key};

      next unless $self->can($name);

      $results->{$key} = $self->$name($results->{$key});
    }
  }

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
