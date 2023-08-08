# Primal Rune's implimentation of ELF hashing in 64 bits
package ELF64;
use strict;

sub new {
	my $self = bless {}, shift;
	
	vec( $self->{_data}, 0, 64 ) = 0;

	return $self;
}

1;
