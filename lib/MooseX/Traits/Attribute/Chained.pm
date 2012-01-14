package MooseX::Traits::Attribute::Chained;
# ABSTRACT: DEPRECATED
use Moose::Role;
use MooseX::ChainedAccessors::Accessor;
use MooseX::ChainedAccessors;

sub accessor_metaclass { $Moose::VERSION >= 1.9900 ? 'MooseX::ChainedAccessors' : 'MooseX::ChainedAccessors::Accessor' }

no Moose::Role;
1;


__END__


=head1 DESCRIPTION

Deprecated in favor of L<MooseX::Attribute::Chained>.