#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Module::Build;

my $builder = Module::Build->new(
     module_name => 'Subroutine::Container',
     dist_version_from => 'lib/Subroutine/Container.pm',
     dist_author => [
         'Sebastian Knapp <sknpp@cpan.org>'
     ],
     license => 'perl',
     dist_abstract => 'Store currried subroutins',
     requires => {
            'perl' => '5.12.0'
     }
);

$builder->create_build_script();
