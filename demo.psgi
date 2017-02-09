use strict;
use warnings;

use Demo;

my $app = Demo->apply_default_middlewares(Demo->psgi_app);
$app;

