#!perl

use strict;
use Test::More;
use Geo::Hex;
use Data::Dumper;

# http://github.com/geohex/geohex-docs/wiki/test-case

my @data = map { chomp $_; [ split/,/,$_ ]  } <DATA>;

plan tests => scalar( @data );

for my $d ( @data ) {
    my ( $code1, $code2, $steps, $valid ) = @$d;
    my $start_zone = getZoneByCode( $code1 );
    my $end_zone   = getZoneByCode( $code2 );
#    print Dumper([ $start_zone, $end_zone ]);
    is( Geo::Hex::getSteps( $start_zone, $end_zone ), $steps );
}

=pod

http://twitter.com/sa2da/status/25189854522
技術仕様未整備のため、随時お答えします。
2ゾーンどちらかを原点としたHex座標系の第2、4象限は座標値の絶対値の和、
第1、3は絶対値のより大きな値がステップ数となります。

http://kokogiko.net/m/archives/002279.html

=cut

# hex code, hex code,予想される値,出力される値
__DATA__
aaa,aac,1,2
bac,bae,1,2
bae,baa,2,3
bae,bad,3,4
cga,cfe,2,8
caa,cca,1,2
caa,ccc,2,2
