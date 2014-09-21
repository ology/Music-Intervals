#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Intervals';

my $obj = Music::Intervals->new;
isa_ok $obj, 'Music::Intervals', 'default args';

is_deeply $obj->scale, [qw(
    1
    1.125
    1.25
    1.33333333333333
    1.5
    1.66666666666667
    1.875
)], 'scale';

$obj = Music::Intervals->new( chords => 1, notes => [qw( C E G B )] );
$obj->process;
use Data::Dumper::Concise;warn Dumper$obj->chord_names;

done_testing();
