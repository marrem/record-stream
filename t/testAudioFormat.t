#!/usr/bin/perl
use warnings;
use strict;

use lib qw( lib );
use Test::More;
use Audio::GetFormat;


# Setting file at constructor
# Testing getter
my $af = Audio::GetFormat->new(file => 'blup.mp4');
is( $af->getFile, 'blup.mp4', 'getFile');



# Setting aac file
# Does right file type gets reported

$af = Audio::GetFormat->new(file => 't/test.mp3');
is ($af->getFormat, 'mp3', 'getFormat');


$af = Audio::GetFormat->new(file => 't/test.aac');
is ($af->getFormat, 'aac', 'getFormat');


done_testing();
