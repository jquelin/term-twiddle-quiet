use 5.008;
use strict;
use warnings;

package Term::Twiddle::Quiet;
# ABSTRACT: Twiddles a thingy while-u-wait if run interactively

use IO::Interactive qw{ is_interactive };
use Term::Twiddle;
use Test::MockObject;

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
