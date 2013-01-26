use warnings;
use strict;
use utf8;

use Test::Most;

# workaround for Test::Flatten
my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";

binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

done_testing;
