package MooseX::Traits::Attribute::Chained;
#ABSTRACT: Create method chaining attributes
use Moose::Role;
use MooseX::ChainedAccessors::Accessor;
use MooseX::ChainedAccessors;

sub accessor_metaclass { $Moose::VERSION >= 1.9900 ? 'MooseX::ChainedAccessors' : 'MooseX::ChainedAccessors::Accessor' }

no Moose::Role;
1;


__END__

=head1 SYNOPSIS

    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );
    
=head1 DESCRIPTION

Modifies the Accessor Metaclass to use MooseX::ChainedAccessors::Accessor


