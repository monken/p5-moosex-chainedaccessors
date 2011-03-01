package MooseX::ChainedAccessors;
# ABSTRACT: Accessor class for chained accessors with Moose
use strict;
use warnings;
use Carp qw(confess);
use Try::Tiny;
use base 'Moose::Meta::Method::Accessor';

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

