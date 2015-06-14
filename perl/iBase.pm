package iBase;
use strict;
use warnings;
use feature ':5.10';
use Data::Dumper;
our @EXPORT_OK = qw( D );

sub import {
    my $class = shift;
    my $flag  = shift;
    return unless $flag;
    my $caller = caller;
    if ($flag eq '-base') {
        no strict 'refs';
        push @{"${caller}::ISA"}, $class;
        *{"${caller}::$_"} = \&$_ for @EXPORT_OK;
    }
    $_->import for qw(strict warnings Data::Dumper);
    feature->import(':5.10');
}

sub D { print (scalar(@_) > 1 ? Dumper(\@_) : ref $_[0] ? Dumper($_[0]) : Dumper(\$_[0])) }

1;
