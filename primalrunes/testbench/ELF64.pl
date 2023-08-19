# ELF64 Testbench
use strict;
use toolbox;
use ELF64;

my $elf = ELF64->new;
Toolbox::assert_defined( $elf );
Toolbox::assert_equal( $elf->raw, 0 );
Toolbox::assert_match( $elf->base2, m/^0$/ );
Toolbox::assert_match( $elf->base8, m/^0$/ );
Toolbox::assert_match( $elf->base10, m/^0$/ );
Toolbox::assert_match( $elf->base16, m/^0$/ );
Toolbox::assert_match( $elf->base36, m/^0$/ );
Toolbox::assert_match( $elf->base64, m/^\.$/ );

$elf->seed( 0x123456789 );
Toolbox::assert_equal( $elf->raw, 0x123456789 );

Toolbox::end;

