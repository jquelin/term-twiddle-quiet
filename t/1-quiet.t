#!perl

use strict;
use warnings;

use IO::Interactive qw{ busy };
use Term::Twiddle::Quiet;
use Test::More tests => 1;

# the mock object shouldn't output anything
my $fh = busy {
    my $tw = Term::Twiddle::Quiet->new;
    $tw->start;
    1 for 1 .. 20_000_000;
    $tw->stop;
};

my @lines = <$fh>;
is( scalar(@lines), 0, 'no output' );

