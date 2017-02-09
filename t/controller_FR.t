use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Demo';
use Demo::Controller::FR;

ok( request('/fr')->is_success, 'Request should succeed' );
done_testing();
