# Testbench's Toolbox
use strict;
package Toolbox;

our $assertcount=0;
our @assertfailure=();

use subs qw/stacktrace/;
sub callinfo {
	if( (scalar @_) != 1 ) {
		stacktrace;
		exit(1);
	}

	my ($package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask, $hinthash) = caller($_[0]);
	return [$package, $filename, $line, $subroutine];
}

use subs qw/tabulate/;
sub stacktrace {
	my $pos = 0;
	my @stacktab;
	while( 1 ) {
		my $ci = callinfo( $pos );
		last if not $ci->[0];
		push @stacktab, $ci;
		$pos = $pos + 1;
	}
	tabulate @stacktab;
}

sub tabulate {
	my @collen;

	foreach my $row ( @_ ) {
		foreach my $ei ( 0 .. $#{$row} ) {
			if( scalar( @collen ) <= $ei ) {
				push @collen, length( $row->[$ei] );
			} elsif( $collen[$ei] < length( $row->[$ei] ) ) {
				$collen[$ei] = length( $row->[$ei] );
			}
		}
	}

	foreach my $row ( @_ ) {
		foreach my $ei ( 0 .. $#{$row} ) {
			print $row->[$ei],  " "x($collen[$ei] - length( $row->[$ei] ));
			print " "x3 if $ei < $#{$row};
		}
		print "\n";
	}
}

sub display_asserts {
	my $failcount = scalar( @assertfailure );
	print "$assertcount asserts: ", $assertcount - $failcount, " passed, $failcount failed\n";
}

sub display_failures {
	tabulate @assertfailure;
}

sub status {
	if( scalar( @assertfailure ) == 0 ) {
		return 0;
	} else {
		return 1;
	}
}

sub exit {
	exit status;
}

sub killpoint {
	if( Toolbox::status != 0 ) {
		Toolbox::display_asserts;
		Toolbox::display_failures;
		Toolbox::exit;
	}
}

sub end {
	if( Toolbox::status != 0 ) {
		Toolbox::display_asserts;
		Toolbox::display_failures;
	}
	Toolbox::exit;
}

sub assert_fail {
	push @assertfailure, callinfo( 1 );
	$assertcount = $assertcount + 1;
}

sub assert_pass {
	$assertcount = $assertcount + 1;
}

sub assert_equal {
	push @assertfailure, callinfo( 1 ) if $_[0] != $_[1];
	$assertcount = $assertcount + 1;
}

sub assert_defined {
	push @assertfailure, callinfo( 1 ) if not defined $_[0];
	$assertcount++;
}

sub assert_match {
	push @assertfailure, callinfo( 1 ) if  $_[0] !~ $_[1];
	$assertcount++;
}

1;
