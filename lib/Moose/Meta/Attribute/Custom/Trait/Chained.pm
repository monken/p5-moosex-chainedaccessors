package Moose::Meta::Attribute::Custom::Trait::Chained;

# ABSTRACT: DEPRECATED
use strict;
use warnings;
no warnings 'redefine';
use MooseX::Attribute::Chained;
warn
    "Implicit use of the Chained trait is deprecated. Please load MooseX::Attribute::Chained explicitly";
sub register_implementation {'MooseX::Traits::Attribute::Chained'}

1;
