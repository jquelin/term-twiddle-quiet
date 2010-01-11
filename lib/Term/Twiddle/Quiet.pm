use 5.008;
use strict;
use warnings;

package Term::Twiddle::Quiet;
# ABSTRACT: Twiddles a thingy while-u-wait if run interactively

use IO::Interactive qw{ is_interactive };
use Term::Twiddle;
use Test::MockObject;


# -- public methods

=method my $tw = Term::Twiddle::Quiet->new( \%params );

Create and return twiddle. The twiddle will do nothing when activated if
the program is ran non-interactively, otherwise it'll return a plain
L<Term::Twiddle> object.

=cut

sub new {
    my $class = shift;

    # interactive: return the real object
    return Term::Twiddle->new(@_) if is_interactive;

    # not interactive: let's mock it
    my $mock = Test::MockObject->new;
    $mock->set_true($_) for qw{
        start stop thingy rate probability random stream
        type width delay
    };
    return $mock;
}

1;
__END__

=head1 SYNOPSIS

    use Term::Twiddle::Quiet;
    my $tw = Term::Twiddle::Quiet->new( \%params );
    $tw->start;
    # do some stuff taking a long time in here
    $tw->stop;


=head1 DESCRIPTION

L<Term::Twiddle> is a nice module for showing spinning thingies on the
terminal while waiting for an action to complete.

L<Term::Twiddle::Quiet> acts very much like that module when it is run
interactively. However, when it isn't run interactively (for example, as
a cron job) then it does not show the twiddle.

Other than this difference, it really act as a L<Term::Twiddle> with all
its options, methods and restrictions (of course, it supports the same
API) - cf its documentation for more information.

