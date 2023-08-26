#!/usr/bin/perl
use v5.20;
use feature qw(signatures);
no warnings qw(experimental::signatures);

sub foobar($foo, $bar) {
    my %h = (
        foo => +{ foo => 'bar' },
        ($foo ? (
            bar => hoge(foo => $bar)->id,
        ) : ()),
    );
    say $h{foo}{foo};
    my $h_ref = \%h;
    say $h_ref->{foo}{foo};
}

sub barfoo {
    my ($foo, $bar) = @_;
    say $_[0];
    foobar([ $foo, $bar ]);
    my ($ary) = ([ ($foo, $bar) ]);
    $ary = [ $foo, $bar ];
    my $result = ($foo ?  $bar : $foo);
    {
        say @$ary[0];
        say @{$ary}[0];
        say $ary->[1];
    }
    if ($foo) {
        # TODO: tree-sitter-perl cannot detect string interpolation yet.
        # say "${foo} $bar";
    }
    my $sub = sub {
        say $foo;
    };
    map { +{} } @ary;
    qw(a b c d e);
    qr(a b c d e);
    qx(a b c d e);
    qq(a b c d e);
    q(a b c d e);
    m(a b c d e);
    s(a b c)(d e);
    tr(a b c)(d e);
    y(a b c)(d e);
}
