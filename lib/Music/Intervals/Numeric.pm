package Music::Intervals::Numeric;

# ABSTRACT: Breakdown of numeric musical intervals

use strict;
use warnings;

use Algorithm::Combinatorics qw( combinations );
use Math::Factor::XS qw( prime_factors );
use Number::Fraction ();
use Music::Intervals::Ratios;
use Moo;
use strictures 2;
use namespace::clean;

=head1 SYNOPSIS

  use Music::Intervals::Numeric;

  my $m = Music::Intervals::Numeric->new(
    notes => [qw( 1/1 5/4 3/2 15/8 )],
    size => 3,
  );

  print Dumper(
    $m->frequencies,
    $m->intervals,
    $m->cent_vals,
    $m->prime_factor,
  );

  my interval = $m->ratios->{'5/4'};

=head1 DESCRIPTION

A C<Music::Intervals> object shows the mathematical break-down of musical
intervals and chords given as integer ratios.

=head1 ATTRIBUTES

=head2 notes

The actual notes to use in the computation

Default: [ 1/1 5/4 3/2 ]  (C E G)

The list of notes may be any of the keys in the L<Music::Intervals::Ratio>
C<ratio> hashref.  This is very very long and contains useful intervals such as
those of the common scale and even the Pythagorean intervals, too.

=head2 size

Chord size

Default: 3

=head2 ratios

Musical ratios keyed by interval fractions.

=cut

has notes => ( is => 'ro', default => sub { [] } );
has size  => ( is => 'ro', default => sub { 3 } );

has ratios => (
    is      => 'ro',
    builder => 1,
);
sub _build_ratios {
  my ($self) = @_;
  no warnings 'once';
  my $ratios = { map {
    $Music::Intervals::Ratios::ratio->{$_}{ratio} => $Music::Intervals::Ratios::ratio->{$_}{name}
  } keys %$Music::Intervals::Ratios::ratio };
  return $ratios;
}

has _semitones => ( is => 'ro', default => sub { 12 } );
has _temper    => ( is => 'ro', lazy => 1, default => sub { my $self = shift;
    $self->_semitones * 100 / log(2) },
);

=head1 METHODS

=head2 new

  $x = Music::Intervals->new(%arguments);

Create a new C<Music::Intervals> object.

=head2 cent_vals

Show cents.

=head2 frequencies

Show frequencies.

=head2 intervals

Show intervals.

=head2 prime_factor

Show the prime factorization.

=cut

sub frequencies {
    my ($self) = @_;

    my $frequencies = {};

    my $iter = combinations( $self->notes, $self->size );

    while (my $c = $iter->next) {
        $frequencies->{"@$c"} = { map { $_ => $self->ratios->{$_} } @$c };
    }

    return $frequencies;
}

sub intervals {
    my ($self) = @_;

    my $intervals = {};

    my $iter = combinations( $self->notes, $self->size );

    while (my $c = $iter->next) {
        my %dyads = $self->dyads($c);

        $intervals->{"@$c"} = {
            map {
                $_ => {
                    $dyads{$_} => $self->ratios->{ $dyads{$_} }
                }
            } keys %dyads
        };
    } 

    return $intervals;
}

sub cent_vals {
    my ($self) = @_;

    my $cent_vals = {};

    my $iter = combinations( $self->notes, $self->size );

    while (my $c = $iter->next) {
        my %dyads = $self->dyads($c);

        $cent_vals->{"@$c"} = {
            map {
                $_ => log( eval $dyads{$_} ) * $self->_temper
            } keys %dyads
        };
    }
            
    return $cent_vals;
}

sub prime_factor {
    my ($self) = @_;

    my $prime_factor = {};

    my $iter = combinations( $self->notes, $self->size );

    while (my $c = $iter->next) {
        my %dyads = $self->dyads($c);

        $prime_factor->{"@$c"} = {
            map {
                $_ => {
                    $dyads{$_} => scalar ratio_factorize( $dyads{$_} )
                }
            } keys %dyads
        };
    }

    return $prime_factor;
}

=head2 dyads

Return pairs of the given combinations with fractional and pitch ratio parts.

=cut

sub dyads {
    my $self = shift;
    my ($c) = @_;

    return () if @$c <= 1;

    my @pairs = combinations( $c, 2 );

    my %dyads;
    for my $i (@pairs) {
        # Construct our "dyadic" fraction.
        my $numerator   = Number::Fraction->new( $i->[1] );
        my $denominator = Number::Fraction->new( $i->[0] );
        my $fraction = $numerator / $denominator;

        $dyads{"@$i"} = $fraction->to_string;
    }

    return %dyads;
}

=head2 ratio_factorize

Return the dyadic fraction as a prime factored expression.

=cut

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

L<Music::Intervals>

=cut
