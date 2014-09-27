package Music::Intervals;
# ABSTRACT: Mathematical breakdown of musical intervals
use strict;
use warnings;
our $VERSION = '0.0103';

use Moo;
use Algorithm::Combinatorics qw( combinations );
use Math::Factor::XS qw( prime_factors );
use Music::Chord::Namer qw( chordname );
use MIDI::Pitch qw( name2freq );
use Number::Fraction;
use Music::Scales;
use Music::Intervals::Ratios;

=head1 SYNOPSIS

  # Available intervals (the "notes" attribute below):
  perl -MData::Dumper -MMusic::Intervals::Ratios -e'print Dumper $Music::Intervals::Ratios::ratio'

  use Music::Intervals;
  $m = Music::Intervals->new(
    notes => [qw( C E G B )],
    size => 3,
    chords => 1,
    justin => 1,
    equalt => 1,
    freqs => 1,
    interval => 1,
    cents => 1,
    prime => 1,
  );
  $m->process;
  # Then print Dumper any of:
  $m->chord_names;
  $m->natural_frequencies;
  $m->natural_intervals;
  $m->natural_cents;
  $m->natural_prime_factors;
  $m->eq_tempered_frequencies;
  $m->eq_tempered_intervals;
  $m->eq_tempered_cents;

=head1 DESCRIPTION

A C<Music::Intervals> object shows the mathematical break-down of musical
intervals and chords.

This module reveals the "guts" of chords within a given tonality.  By guts I
mean, the measurements of the notes and the intervals between them.  Both just
intonation (ratio) and equal temperament (decimal) are handled, with over 400
intervals, too!

=cut

=head1 METHODS

=head2 new()

  $x = Music::Intervals->new(%arguments);

=head2 Attributes and defaults

=over

=item cents: 0 - divisions of the octave

=item chords: 0 - chord names

=item equalt: 0 - equal temperament

=item freqs: 0 - frequencies

=item interval: 0 - note intervals

=item justin: 0 - just intonation

=item prime: 0 - prime factorization

=item rootless: 0 - show chord names with no root

=item octave: 4 - use the fourth octave

=item concert: 440 - concert pitch

=item size: 3 - chord size

=item tonic: C - root of the computations

* Currently (and for the foreseeable future) this will remain the only value
that produces sane results.

=item semitones: 12 - number of notes in the scale

=item temper: semitones * 100 / log(2) - physical distance between notes

=item notes: [ C D E F G A B ] - actual notes to use in the computation

The list of notes may be any of the keys in the L<Music::Intervals::Ratios>
C<ratio> hashref.  This is very very long and contains useful intervals such as
those of the common scale and even the Pythagorean intervals, too.

A few examples:

 [qw( C E G )]
 [qw( C pM3 pM7 )]
 [qw( C D D\# )]
 [qw( C D Eb )]
 [qw( C D D\# Eb E E\# Fb F )]
 [qw( C 11h 7h )]

Note that case matters.

=back

=cut

has cents     => ( is => 'ro', default => sub { 0 } );
has chords    => ( is => 'ro', default => sub { 0 } );
has equalt    => ( is => 'ro', default => sub { 0 } );
has freqs     => ( is => 'ro', default => sub { 0 } );
has interval  => ( is => 'ro', default => sub { 0 } );
has justin    => ( is => 'ro', default => sub { 0 } );
has prime     => ( is => 'ro', default => sub { 0 } );
has rootless  => ( is => 'ro', default => sub { 0 } );
has octave    => ( is => 'ro', default => sub { 4 } );
has concert   => ( is => 'ro', default => sub { 440 } );
has size      => ( is => 'ro', default => sub { 3 } );
has tonic     => ( is => 'ro', default => sub { 'C' } );
has semitones => ( is => 'ro', default => sub { 12 } );
has temper    => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    $self->semitones * 100 / log(2) },
);
has notes     => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return [ get_scale_notes( $self->tonic ) ] },
);
has scale     => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return [ map { eval "$Music::Intervals::Ratios::ratio->{$_}{ratio}" } @{ $self->notes } ] },
);
has _note_index  => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return { map { $_ => eval "$Music::Intervals::Ratios::ratio->{$_}{ratio}" } @{ $self->notes } } },
);
has _ratio_index => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return { map { $_ => $Music::Intervals::Ratios::ratio->{$_}{ratio} } @{ $self->notes } } },
);
has _ratio_name_index => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return { map { $Music::Intervals::Ratios::ratio->{$_}{ratio} => $Music::Intervals::Ratios::ratio->{$_}{name} } keys %$Music::Intervals::Ratios::ratio } },
);

has chord_names => ( is => 'rw', default => sub { {} } );
has natural_frequencies => ( is => 'rw', default => sub { {} } );
has natural_intervals => ( is => 'rw', default => sub { {} } );
has natural_cents => ( is => 'rw', default => sub { {} } );
has natural_prime_factors => ( is => 'rw', default => sub { {} } );
has eq_tempered_frequencies => ( is => 'rw', default => sub { {} } );
has eq_tempered_intervals => ( is => 'rw', default => sub { {} } );
has eq_tempered_cents => ( is => 'rw', default => sub { {} } );

sub process
{
    my $self = shift;

    my %x;

    my $iter = combinations( $self->notes, $self->size );
    while (my $c = $iter->next)
    {
        my %dyads = $self->dyads($c);

        if ( $self->chords )
        {
            # Do we know any named chords?
            my @chordname = eval { chordname(@$c) };

            # Exclude "rootless" chords unless requested.
            @chordname = grep { !/no-root/ } @chordname unless $self->rootless;

            # Set the names of this chord combination.
            $self->chord_names->{"@$c"} = \@chordname if @chordname;
        }

        if ( $self->justin )
        {
            if ( $self->freqs )
            {
                $self->natural_frequencies->{"@$c"} =
                    { map { $_ => { $self->_ratio_index->{$_} => $Music::Intervals::Ratios::ratio->{$_}{name} } } @$c };
            }
            if ( $self->interval )
            {
                $self->natural_intervals->{"@$c"} = {
                    map {
                        $_ => {
                            $dyads{$_}->{natural} => $self->_ratio_name_index->{ $dyads{$_}->{natural} }
                        }
                    } keys %dyads
                };

            }
            if ( $self->cents )
            {
                $self->natural_cents->{"@$c"} = {
                    map {
                        $_ => log( eval $dyads{$_}->{natural} ) * $self->temper
                    } keys %dyads };

            }
            if ( $self->prime )
            {
                $self->natural_prime_factors->{"@$c"} = {
                    map {
                        $_ => {
                            $dyads{$_}->{natural} => scalar ratio_factorize( $dyads{$_}->{natural} )
                        }
                    } keys %dyads
                };
            }
        }

        if ( $self->equalt )
        {
            if ( $self->freqs )
            {
                $self->eq_tempered_frequencies->{"@$c"} = {
                    map {
                        $_ => name2freq( $_ . $self->octave ) || eval $self->_ratio_index->{$_}
                    } @$c
                };
            }
            if ( $self->interval )
            {
                $self->eq_tempered_intervals->{"@$c"} = {
                    map {
                        $_ => $dyads{$_}->{eq_tempered}
                    } keys %dyads
                };
            }
            if ( $self->cents )
            {
                $self->eq_tempered_cents->{"@$c"} = {
                    map {
                        $_ => log( $dyads{$_}->{eq_tempered} ) * $self->temper
                    } keys %dyads
                };
            }
        }
    }
}

sub dyads
{
    my $self = shift;
    my ($c) = @_;

    my @pairs = combinations( $c, 2 );

    my %dyads;
    for my $i (@pairs) {
        # Construct our "dyadic" fraction.
        my $numerator   = Number::Fraction->new( $self->_ratio_index->{ $i->[1] } );
        my $denominator = Number::Fraction->new( $self->_ratio_index->{ $i->[0] } );
        my $fraction = $numerator / $denominator;

        # Calculate both natural and equal temperament values for our ratio.
        $dyads{"@$i"} = {
            natural => $fraction->to_string(),
            # The value is either the known pitch ratio or the numerical evaluation of the fraction.
            eq_tempered =>
              ( name2freq( $i->[1] . $self->octave ) || $self->_note_index->{ $i->[1] } )
                /
              ( name2freq( $i->[0] . $self->octave ) || $self->_note_index->{ $i->[0] } ),
        };
    }

    return %dyads;
}

sub ratio_factorize {
    my $dyad = shift;

    my ( $numerator, $denominator ) = split /\//, $dyad;
    $numerator   = [ prime_factors($numerator) ];
    $denominator = [ prime_factors($denominator) ];

    return wantarray
        ? ( $numerator, $denominator )
        : sprintf( '(%s) / (%s)',
            join( '*', @$numerator ),
            join( '*', @$denominator )
        );
}

1;
__END__

=head1 SEE ALSO

For the time being, you will need to look at the source of
C<Music::Intervals::Ratios> for the note and interval names.

L<https://github.com/ology/Music/blob/master/intervals>

L<http://en.wikipedia.org/wiki/List_of_musical_intervals>

L<http://en.wikipedia.org/wiki/Equal_temperament>

L<http://en.wikipedia.org/wiki/Just_intonation>

=cut
