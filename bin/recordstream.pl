#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Getopt::Long;
use Audio::GetFormat;

my $workdir;
my $url;
my $duration;
my $segmenttime;
my $programmename;
my $stationname;

my $defaultSegmentTime = 15;

my $scriptName = $0;
$scriptName =~ s/.*\///;

GetOptions (
"workdir=s" => \$workdir,
"url=s"   => \$url,
"duration=i"  => \$duration,
"segmenttime=i" => \$segmenttime,
"programmename=s" => \$programmename,
"stationname=s" => \$stationname,
) or die (
	"Error in command line arguments\n"
);


my $helpMsg = <<_EOT_;
Usage $scriptName --workdir <workdir> --url <url> --duration <duration> --programmename <programmename> --stationname <stationname> [--segmenttime <segmenttime>]

workdir:       Directory to put result (and intermediate) files
url:           Stream url to record from
duration:      Duration (in min) to record for 
programmename: Name of recorded programme (used in tags in output file)
stationname:   Name of radio station (used in tags in output file)
segmenttime:   Duration of segment the output file is split into (default $defaultSegmentTime min)
_EOT_


unless(defined($workdir)) { die "No value for --workdir option\n\n$helpMsg\n";}
unless(defined($url)) { die "No value for --url option\n\n$helpMsg\n";}
unless(defined($duration)) { die "No value for --duration option\n\n$helpMsg\n";}
unless(defined($programmename)) { die "No value for --programmename option\n\n$helpMsg\n";}
unless(defined($stationname)) { die "No value for --stationname option\n\n$helpMsg\n";}


unless(defined($segmenttime)) {
	print "No value for --segmenttime option. Using default: $defaultSegmentTime min\n";
	$segmenttime = $defaultSegmentTime;
}

my $durationSeconds = $duration * 60;

# neemop
# bepaal audio format
# bewerk raw audio (van format <format>)
#  - mux (bij aac)
#  - zet tags
#  - split
#  - volgnummer tags bij geplistste bestanden
#

my $rawFile = "${stationname}-${programmename}.stream";

my @curlCmd =  (
	'curl',
       	'-s',
	'-o', $rawFile, 
        '-m', $durationSeconds,
       	$url
);

my $curlExitCode = system(@curlCmd) >> 8;

if ($curlExitCode != 0 && $curlExitCode != 28) {
	die join(' ', @curlCmd) . " failed with exit code: $curlExitCode";
}

my $af = Audio::GetFormat->new(file => $rawFile);

my $format = $af->getFormat;


say $format;


