#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Intervals';

my $obj = Music::Intervals->new;
isa_ok $obj, 'Music::Intervals', 'default args';

my $scale = [qw( 1.000 1.125 1.250 1.333 1.500 1.667 1.875)];
for my $n ( 0 .. @$scale - 1 )
{
    is sprintf('%.3f', $obj->scale->[$n]), $scale->[$n], "scale $n";
}

is_deeply $obj->by_name('C'), { ratio => '1/1', name => 'unison, perfect prime, tonic' }, 'by_name';
is_deeply $obj->by_name('c'), undef, 'undef by_name';

like $obj->by_ratio('27/25'), qr/^large limma/, 'by_ratio';

my $chord = 'C E G';
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

is_deeply $obj->chord_names, { 'C E G' => [ 'C' ] }, 'chord_names';
is_deeply $obj->natural_frequencies,
    { 'C E G' => { C => { '1/1' => 'unison, perfect prime, tonic' }, E => { '5/4' => 'major third' }, G => { '3/2' => 'perfect fifth' } } },
    'natural_frequencies';
is_deeply $obj->natural_intervals,
    { 'C E G' => { 'C E' => { '5/4' => 'major third' }, 'E G' => { '6/5' => 'minor third' }, 'C G' => { '3/2' => 'perfect fifth' } } },
    'natural_intervals';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'C E'}), '386.314', 'natural_cents C E';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'C G'}), '701.955', 'natural_cents C G';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'E G'}), '315.641', 'natural_cents E G';
is_deeply $obj->natural_prime_factors,
    { 'C E G' => { 'C E' => { '5/4' => '(5) / (2*2)' }, 'C G' => { '3/2' => '(3) / (2)' }, 'E G' => { '6/5' => '(2*3) / (5)' } } },
    'natural_prime_factors';
is sprintf('%.3f', $obj->eq_tempered_frequencies->{$chord}{C}), '261.626', 'eq_tempered_frequencies C';
is sprintf('%.3f', $obj->eq_tempered_frequencies->{$chord}{E}), '329.628', 'eq_tempered_frequencies E';
is sprintf('%.3f', $obj->eq_tempered_frequencies->{$chord}{G}), '391.995', 'eq_tempered_frequencies G';
is sprintf('%.3f', $obj->eq_tempered_intervals->{$chord}{'C E'}), '1.260', 'eq_tempered_intervals C E';
is sprintf('%.3f', $obj->eq_tempered_intervals->{$chord}{'C G'}), '1.498', 'eq_tempered_intervals C G';
is sprintf('%.3f', $obj->eq_tempered_intervals->{$chord}{'E G'}), '1.189', 'eq_tempered_intervals E G';
is_deeply $obj->eq_tempered_cents,
    { 'C E G' => { 'C G' => '700', 'C E' => '400', 'E G' => '300' } },
    'eq_tempered_cents';

done_testing();
