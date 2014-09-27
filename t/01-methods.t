#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Intervals';

my $obj = Music::Intervals->new;
isa_ok $obj, 'Music::Intervals', 'default args';

my $scale = [qw(
    1.000
    1.125
    1.250
    1.333
    1.500
    1.667
    1.875
)];
for my $n ( 0 .. @$scale - 1 )
{
    is sprintf('%.3f', $obj->scale->[$n]), $scale->[$n], "scale $n";
}

is_deeply $obj->ratio('C'), { ratio => '1/1', name => 'unison, perfect prime, tonic' }, 'ratio';
is_deeply $obj->ratio('c'), undef, 'undef ratio';

$obj = Music::Intervals->new(
    chords => 1,
    justin => 1,
    freqs => 1,
    interval => 1,
    cents => 1,
    prime => 1,
    equalt => 1,
    notes => [qw( C E G B )],
);
isa_ok $obj, 'Music::Intervals';
$obj->process;

#use Data::Dumper::Concise;
#warn Dumper $obj->chord_names;
#warn Dumper $obj->natural_frequencies;
#warn Dumper $obj->natural_intervals;
#warn Dumper $obj->natural_cents;
#warn Dumper $obj->natural_prime_factors;
#warn Dumper $obj->eq_tempered_frequencies;
#warn Dumper $obj->eq_tempered_intervals;
#warn Dumper $obj->eq_tempered_cents;

done_testing();
