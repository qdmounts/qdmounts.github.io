#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use Data::Dumper;
use YAML::XS qw/LoadFile/;
use Text::CSV;
use feature qw/say/;
use utf8;
use YAML qw/Dump/;

print "##### YAML portion #####";

my $config = LoadFile('sample.yaml');

# access the scalar productName
my $productName = $config->{productName};
say "$productName";

# access the scalar productNote
my $productNote = $config->{productNote};
say "$productNote";

# loop through and print options
for (@{$config->{productOptions}}) { say }

# access the price hash key values directly
my $discounted = $config->{productPrices}->{discounted};
say "Discounted price is: $discounted";
my $retail = $config->{productPrices}->{retail};
say "Retail price is: $retail";
my $sale = $config->{productPrices}->{sale};
say "Sale price is: $sale";

# loop through and print prices
for (keys %{$config->{productPrices}}) {
  say "$_: $config->{productPrices}->{$_}";
}

print Dumper($config);

print "##### CSV portion #####";

my $csv = Text::CSV->new ( { binary => 1 } );
my @name;
my @data;
while ( my $line = <STDIN> ) {
    $csv->parse( $line );
    if ( @name ) {
        my @columns = $csv->fields();
        my $hash;
        for my $i ( keys @name ){
            $hash->{ $name[$i] } = $columns[$i] if $name[$i];
        }
        push @data, $hash;
    }
    else {
         @name = $csv->fields();
    }
}

print Dump \@data;