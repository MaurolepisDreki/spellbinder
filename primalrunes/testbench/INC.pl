# Primal Runes Testbench: @INC
#    Nicly prints include directories (manual test)
use strict;

for (@INC) {
	print " - " . $_ . "\n";
}

