#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Music::Intervals::Numeric';

my $obj = Music::Intervals::Numeric->new;
isa_ok $obj, 'Music::Intervals::Numeric', 'default args';

my $chord = '1/1 5/4 3/2';
$obj = Music::Intervals::Numeric->new(
    freqs => 1,
    interval => 1,
    cents => 1,
    prime => 1,
    notes => [qw( 1/1 5/4 3/2 )],
);
isa_ok $obj, 'Music::Intervals::Numeric';
$obj->process;

is_deeply $obj->natural_frequencies,
    { "1/1 5/4 3/2" => { "1/1" => "C unison, perfect prime, tonic", "3/2" => "G perfect fifth", "5/4" => "E major third" } },
    'natural_frequencies';
is_deeply $obj->natural_intervals,
    { "1/1 5/4 3/2" => { "1/1 3/2" => { "3/2" => "G perfect fifth" }, "1/1 5/4" => { "5/4" => "E major third" }, "5/4 3/2" => { "6/5" => "Eb minor third" } } },
    'natural_intervals';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'1/1 5/4'}), '386.314', 'natural_cents 1/1 5/4';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'1/1 3/2'}), '701.955', 'natural_cents 1/1 3/2';
is sprintf('%.3f', $obj->natural_cents->{$chord}{'5/4 3/2'}), '315.641', 'natural_cents 5/4 3/2';
is_deeply $obj->natural_prime_factors,
    { "1/1 5/4 3/2" => { "1/1 3/2" => { "3/2" => "(3) / (2)" }, "1/1 5/4" => { "5/4" => "(5) / (2*2)" }, "5/4 3/2" => { "6/5" => "(2*3) / (5)" } } },
    'natural_prime_factors';

done_testing();
