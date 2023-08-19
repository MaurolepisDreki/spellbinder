# Primal Rune's implimentation of ELF hashing in 64 bits
package ELF64;
use strict;

sub new {
	my $self = bless {}, shift;
	
	vec( $self->{_DATA}, 0, 64 ) = 0;

	return $self;
}

sub seed {
	my $self = shift;
	vec( $self->{_DATA}, 0, 64 ) = shift;
}

sub raw {
	my $self = shift;
	return vec( $self->{_DATA}, 0, 64 );
}

# Base (String) Conversion Functions
sub _strbase {
	my $self = shift;
	my $encstr = shift;
	my $buff = $self->raw;
	my $output = '';

	do {
		$output = substr( $encstr, $buff % length( $encstr ), 1 ) . $output;
		$buff = ($buff - ($buff % length( $encstr ))) / length( $encstr );
	} while( $buff > 0 );

	return $output;
}

sub base2 {
	my $self = shift;
	return $self->_strbase( q(01) );
}

sub base8 {
	my $self = shift;
	return $self->_strbase( q(01234567) );
}

sub base10 {
	my $self = shift;
	return $self->_strbase( q(0123456789) );
}

sub base16 {
	my $self = shift;
	return $self->_strbase( q(0123456789ABCDEF) );
}


sub base36 {
	my $self = shift;
	return $self->_strbase( q(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ) );
}

sub base64 {
	my $self = shift;
	# crypt's variant: ASCII string sort order is correct (unlike as in RFC 4648 &c.)
	return $self->_strbase( q(./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz) );
}

1;
