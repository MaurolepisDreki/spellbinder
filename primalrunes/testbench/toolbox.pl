# Testbench for the Testbench Toolbox
use strict;
use toolbox;	

Toolbox::assert_equal( Toolbox::status, 0 );
Toolbox::killpoint;

Toolbox::assert_fail;
Toolbox::assert_equal( Toolbox::status, 1 );
# Retract assert_fail
$Toolbox::assertcount = $Toolbox::assertcount - 1;
shift @Toolbox::assertfailure;
Toolbox::killpoint;

Toolbox::assert_pass;
Toolbox::assert_equal( Toolbox::status, 0 );
Toolbox::assert_equal( $Toolbox::assertcount, 4 );

Toolbox::end;

