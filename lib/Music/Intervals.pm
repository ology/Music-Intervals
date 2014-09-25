package Music::Intervals;
# ABSTRACT: Mathematical breakdown of musical intervals
use strict;
use warnings;
our $VERSION = '0.01';

use Moo;
use Algorithm::Combinatorics qw( combinations );
use Math::Factor::XS qw( prime_factors );
use Music::Chord::Namer qw(chordname);
use MIDI::Pitch qw(name2freq);
use Number::Fraction;
use Sort::ArbBiLex;
use Music::Scales;
use Music::Ratios;

=head1 SYNOPSIS

  use Music::Intervals;
  $x = Music::Intervals->new(%arguments);

=head1 DESCRIPTION

A C<Music::Intervals> object shows the mathematical break-down of musical
intervals and chords.

=cut

=head1 METHODS

=head2 new()

  $x = Music::Intervals->new(%arguments);

=cut

has cents     => ( is => 'ro', default => sub { 0 } );
has chords    => ( is => 'ro', default => sub { 0 } );
has equalt    => ( is => 'ro', default => sub { 0 } );
has freqs     => ( is => 'ro', default => sub { 0 } );
has interval  => ( is => 'ro', default => sub { 0 } );
has justin    => ( is => 'ro', default => sub { 0 } );
has numeric   => ( is => 'ro', default => sub { 0 } );
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
    return [ map { eval "$Music::Ratios::ratio->{$_}{ratio}" } @{ $self->notes } ] },
);
has _note_index  => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return { map { $_ => eval "$Music::Ratios::ratio->{$_}{ratio}" } @{ $self->notes } } },
);
has _ratio_index => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    return { map { $_ => $Music::Ratios::ratio->{$_}{ratio} } @{ $self->notes } } },
);

has chord_names => ( is => 'rw', default => sub { {} } );

sub process
{
    my $self = shift;

    my %x;

    for my $c ( combinations( $self->notes, $self->size ) )
    {
#        my %dyads = $self->dyads($c);

        if ( $self->chords )
        {
            # Do we know any named chords?
            my @chordname = eval { chordname(@$c) };

            # Exclude "rootless" chords unless requested.
            @chordname = grep { !/no-root/ } @chordname unless $self->rootless;

            # Set the names of this chord combination.
            $self->chord_names->{"@$c"} = \@chordname if @chordname;
        }
    }
}

sub dyads {
    my $self = shift;
    my ($c) = @_;

    my $n = $self->_note_index;
    my $r = $self->_ratio_index;

    my @pairs = combine( 2, @$c );

    my %dyads;
    for my $i (@pairs) {
        # Construct our "dyadic" fraction.
        my $numerator   = Number::Fraction->new( $r->{ $i->[1] } );
        my $denominator = Number::Fraction->new( $r->{ $i->[0] } );
        my $fraction = $numerator / $denominator;

        # Calculate both natural and equal temperament values for our ratio.
        $dyads{"@$i"} = {
            natural => $fraction->to_string(),
            # The value is either the known pitch ratio or the numerical evaluation of the fraction.
            eq_tempered =>
              ( name2freq( $i->[1] . $self->octave ) || $n->{ $i->[1] } ) /
              ( name2freq( $i->[0] . $self->octave ) || $n->{ $i->[0] } ),
        };
    }

    return %dyads;
}

1;
__END__

=head1 SEE ALSO

L<https://github.com/ology/Music/blob/master/intervals>

=cut
