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
    notes => [qw( C E G )],
);
isa_ok $obj, 'Music::Intervals';
$obj->process;

is_deeply $obj->chord_names, { "C E G" => [ "C" ] }, 'chord_names';
is_deeply $obj->natural_frequencies,
    { "C E G" => { C => { "1/1" => "unison, perfect prime, tonic" }, E => { "5/4" => "major third" }, G => { "3/2" => "perfect fifth" } } },
    'natural_frequencies';
is_deeply $obj->natural_intervals,
    { 'C E G' => { 'C E' => { '5/4' => 'major third' }, 'E G' => { '6/5' => 'minor third' }, 'C G' => { '3/2' => 'perfect fifth' } } },
    'natural_intervals';
is_deeply $obj->natural_cents,
    { 'C E G' => { 'C E' => '386.313713864835', 'E G' => '315.641287000553', 'C G' => '701.955000865387' } },
    'natural_cents';
is_deeply $obj->natural_prime_factors,
    { "C E G" => { "C E" => { "5/4" => "(5) / (2*2)" }, "C G" => { "3/2" => "(3) / (2)" }, "E G" => { "6/5" => "(2*3) / (5)" } } },
    'natural_prime_factors';
is_deeply $obj->eq_tempered_frequencies,
    { "C E G" => { C => "261.625565300599", E => "329.62755691287", G => "391.995435981749" } },
    'eq_tempered_frequencies';
is_deeply $obj->eq_tempered_intervals,
    { "C E G" => { "C E" => "1.25992104989487", "C G" => "1.49830707687668", "E G" => "1.18920711500272" } },
    'eq_tempered_intervals';
is_deeply $obj->eq_tempered_cents,
    { 'C E G' => { 'C G' => '700', 'C E' => '400', 'E G' => '300' } },
    'eq_tempered_cents';

done_testing();
