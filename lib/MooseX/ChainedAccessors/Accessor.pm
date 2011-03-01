package MooseX::ChainedAccessors::Accessor;
use strict;
use warnings;
use base 'Moose::Meta::Method::Accessor';

sub _inline_post_body {
    return 'return $_[0] if (scalar(@_) >= 2);' . "\n";
}
1;
