package MooseX::ChainedAccessors::Accessor;
use strict;
use warnings;
use Carp qw(confess);
use Try::Tiny;

use base 'Moose::Meta::Method::Accessor';

sub _inline_post_body {
return 'return $_[0] if (scalar(@_) >= 2);' . "\n";
}

sub _generate_accessor_method_inline {
    my $self = shift;
    my $attr = $self->associated_attribute;

    return try {
        $self->_compile_code([
            'sub {',
                'if (@_ > 1) {',
                    $attr->_inline_set_value('$_[0]', '$_[1]'),
                    'return $_[0];',
                '}',
                $attr->_inline_get_value('$_[0]'),
            '}',
        ]);
    }
    catch {
        confess "Could not generate inline accessor because : $_";
    };
}

sub _generate_writer_method_inline {
    my $self = shift;
    my $attr = $self->associated_attribute;

    return try {
        $self->_compile_code([
            'sub {',
                $attr->_inline_set_value('$_[0]', '$_[1]'),
                '$_[0]',
            '}',
        ]);
    }
    catch {
        confess "Could not generate inline writer because : $_";
    };
}

1;

__END__


=head1 NAME

MooseX::ChainedAccessors::Accessor - Accessor class for chained accessors with Moose

=head1 SYNOPSIS

    package Test;
    use Moose;
    
    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );
    
    sub complex_method
    {
        my $self = shift;
        
        #...
        
        print "helper message" if $self->debug;
        
        #...
    }
    
    
    1;

Which allows for:

    my $test = Test->new();
    $test->debug(1)->complex_method();
    
=head1 DESCRIPTION

MooseX::ChainedAccessors is a Moose Trait which allows for method chaining 
on accessors by returning $self on write/set operations. 

=head1 AUTHORS

David McLaughlin E<lt>david@dmclaughlin.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 David McLaughlin

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


