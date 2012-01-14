package MooseX::ChainedAccessors;
# ABSTRACT: DEPRECATED
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

=head1 DESCRIPTION

Deprecated in favor of L<MooseX::Attribute::Chained>.

