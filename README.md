# NAME

Data::Object::Role::Formulatable

# ABSTRACT

Formulatable Role for Perl 5

# SYNOPSIS

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

# DESCRIPTION

This package provides a mechanism for automatically inflating objects from
constructor arguments.

# INTEGRATES

This package integrates behaviors from:

[Data::Object::Role::Buildable](https://metacpan.org/pod/Data%3A%3AObject%3A%3ARole%3A%3ABuildable)

[Data::Object::Role::Errable](https://metacpan.org/pod/Data%3A%3AObject%3A%3ARole%3A%3AErrable)

[Data::Object::Role::Stashable](https://metacpan.org/pod/Data%3A%3AObject%3A%3ARole%3A%3AStashable)

[Data::Object::Role::Tryable](https://metacpan.org/pod/Data%3A%3AObject%3A%3ARole%3A%3ATryable)

# LIBRARIES

This package uses type constraints from:

[Types::Standard](https://metacpan.org/pod/Types%3A%3AStandard)

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/foobar/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/foobar/wiki)

[Project](https://github.com/iamalnewkirk/foobar)

[Initiatives](https://github.com/iamalnewkirk/foobar/projects)

[Milestones](https://github.com/iamalnewkirk/foobar/milestones)

[Contributing](https://github.com/iamalnewkirk/foobar/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/foobar/issues)
