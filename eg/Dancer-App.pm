package App;

# ABSTRACT: Show the mathematical break-down of musical notes

use Dancer2;
use Music::Intervals;
use Data::Dumper::Concise;

our $VERSION = '0.01';

=head1 DESCRIPTION

An C<App::MusicIntervals> object shows the mathematical break-down of musical notes.

=head1 ROUTES

=head2 /

Main form and results page.

=cut

any '/' => sub {
    my $notes = body_parameters->get('notes') || 'C E G';
    $notes = [ split /[\s,]+/, $notes ];

    my $size = body_parameters->get('size') || 3;

    my $m = Music::Intervals->new(
      notes    => $notes,
      size     => $size,
      chords   => body_parameters->get('chords'),
      justin   => body_parameters->get('justin'),
      equalt   => body_parameters->get('equalt'),
      freqs    => body_parameters->get('freqs'),
      interval => body_parameters->get('interval'),
      cents    => body_parameters->get('cents'),
      prime    => body_parameters->get('prime'),
      integer  => body_parameters->get('integer'),
    );
     
    $m->process;

    template 'index' => {
        title => 'App::MusicIntervals',
        # Input form
        notes    => join( ' ', @{ $m->notes } ),
        size     => $m->size,
        chords   => $m->chords,
        justin   => $m->justin,
        equalt   => $m->equalt,
        freqs    => $m->freqs,
        interval => $m->interval,
        cents    => $m->cents,
        prime    => $m->prime,
        integer  => $m->integer,
        # Results
        ( keys %{ $m->chord_names }             ? ( chord_names             => Dumper $m->chord_names ) : () ),
        ( keys %{ $m->natural_frequencies }     ? ( natural_frequencies     => Dumper $m->natural_frequencies ) : () ),
        ( keys %{ $m->natural_intervals }       ? ( natural_intervals       => Dumper $m->natural_intervals ) : () ),
        ( keys %{ $m->natural_cents }           ? ( natural_cents           => Dumper $m->natural_cents ) : () ),
        ( keys %{ $m->natural_prime_factors }   ? ( natural_prime_factors   => Dumper $m->natural_prime_factors ) : () ),
        ( keys %{ $m->eq_tempered_frequencies } ? ( eq_tempered_frequencies => Dumper $m->eq_tempered_frequencies ) : () ),
        ( keys %{ $m->eq_tempered_intervals }   ? ( eq_tempered_intervals   => Dumper $m->eq_tempered_intervals ) : () ),
        ( keys %{ $m->eq_tempered_cents }       ? ( eq_tempered_cents       => Dumper $m->eq_tempered_cents ) : () ),
        ( keys %{ $m->integer_notation }        ? ( integer_notation        => Dumper $m->integer_notation ) : () ),
    };
};

true;

__END__

=head1 SEE ALSO

L<Dancer2>

L<Music::Intervals>

L<Data::Dumper::Concise>

=cut
