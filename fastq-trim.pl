#!/usr/bin/env perl

#Takes in a given MRSN # & S # for an isolate and trims its fastqs to the given number of lines by selecting random sequences to be transferred to the trimmed Fastq (kept in original order)
#Can be done with any # of isolates at the same time.
#ex formatting, 1 isolate: /media/Research/mrsn/MRSN_Data/bin/fastq-trim.pl 45713 5147 23 10000000
#ex formatting, 2 isolates: /media/Research/mrsn/MRSN_Data/bin/fastq-trim.pl 45713 5147 23 10000000 45716 5151 26 9000000

use warnings;
use strict;

use Scalar::Util qw(looks_like_number);

my $numOfArgumentsPerIsolate = 3;

if (($#ARGV + 1) % $numOfArgumentsPerIsolate > 0 or $#ARGV+1 <= 0) {
	print "The " , $#ARGV+1 , " supplied arguments is not a positive multiple of ", $numOfArgumentsPerIsolate, " !\n";
	exit(0);
}

my $hungIsolateNum;#The iteration of trimming we are on, starting at 0 and ending at the number of supplied arguments / 3 - 1
my $cmd;#The command that gets sent to Unix

#jobID is the ID # of the job to be deleted, mrsnNum is the MRSN # of the isolate (ex. 4527), sNum is the S number for the isolate's run, lineCutNum is the # of lines the trimmed file should be.
#If the job that was aligning the isolate is no longer running (manually or automatically) put in something that either isn't a number or is not an ID of a job that is currently running.
#mrsnNum & sNum should be numbers but don't have to be. If there isn't 2 fastqs with the specified MRSN# & S#, program exits without doing anything.
my ($mrsnNum, $sNum, $lineCutNum);

for ($hungIsolateNum = 0; $hungIsolateNum < $#ARGV / $numOfArgumentsPerIsolate; $hungIsolateNum++)
{
	print "Trimming isolate #", $hungIsolateNum+1, ".\n";
	
	$mrsnNum = $ARGV[$hungIsolateNum * $numOfArgumentsPerIsolate];
	$sNum = $ARGV[$hungIsolateNum * $numOfArgumentsPerIsolate + 1];
	$lineCutNum = $ARGV[$hungIsolateNum * $numOfArgumentsPerIsolate + 2];
	
	#Making sure the supplied number of lines the trim the isolate's fastqs to is actually a number.
	unless (looks_like_number($lineCutNum)) {
		print "The supplied number of lines to trim the isolate's fastqs to, " . $lineCutNum . " is not a number!\n";
		exit(0);
	}
	
	#The addresses for the R1 & R2 fastqs for the isolate.
	#If the isolate's 2 fastqs have a different name/extension format, change these 2 lines of code.
	my $r1FqAddress = "MRSN" . $mrsnNum . "_S" . $sNum . "_R1_001.fastq";
	my $r2FqAddress = "MRSN" . $mrsnNum . "_S" . $sNum . "_R2_001.fastq";
	
	#Checks to see if the R1 & R2 files for the given MRSN # & S # exist in the current folder and are readable.
	unless(-e $r1FqAddress) {
		print $r1FqAddress , " doesn't exist!\n";
		exit(0);
	}
	unless(-r $r1FqAddress) {
		print $r1FqAddress , " exists but isn't readable!\n";
		exit(0);
	}
	unless(-e $r2FqAddress) {
		print $r2FqAddress , " doesn't exist!\n";
		exit(0);
	}
	unless(-r $r2FqAddress) {
		print $r2FqAddress , " exists but isn't readable!\n";
		exit(0);
	}
	
	#Makes sure the number of lines to trim the isolate's fastqs to makes sense (isn't negative and has at least one sequence)
	if ($lineCutNum < 4) {
		print "The number of lines to trim the isolate's fastqs to has to be positive and >= 4 !\n";
		exit(0);
	}
	$lineCutNum = int($lineCutNum);
	
	#Make sure the trimming doesn't break up a sequence 
	if ($lineCutNum % 4 != 0) {
		print "The number of lines to trim the fastq to is not a multiple of 4! Rounding it down to the nearest multiple of 4.\n";
		$lineCutNum -= ($lineCutNum % 4);
	}
	
	$cmd = "wc -l < " . $r1FqAddress;
	my $originalLineCount = `$cmd`;#The number of lines in each pretrimmed fastq
	if ($originalLineCount % 4 != 0) {
		print "The R1 fastq (at least) does not have a multiple of 4 lines in it!\n";
		exit(0);
	}
	my $originalSequenceCount = $originalLineCount / 4;#The number of sequences in each pretrimmed fastq
	
	#Checks to see if cutting the file to the requested amount of lines would actually trim the file, assuming both fastqs are of same length.
	$cmd = "wc -l < " . $r1FqAddress;
	if (`$cmd` <= $lineCutNum) {
		print "The requested line cut amount would not trim the .fastq file, exiting!\n";
		exit(0);
	}
	
	#Randomly picks the sequence #s to include in the trimmed file
	my %unique;#Each # that has been generated, and the # of times each # has been generated (by the random # generator)
	my @numbers;#The line numbers to be included in the trimming
	for (my $i = 0; $i < $lineCutNum / 4; $i++) {
		my $number = int rand($originalSequenceCount);
		redo if $unique{$number}++;#Checks to see if the # is in %unique. If yes, regenerates a random #. Either way, adds the # to %unique and increases the value of the #'s key by 1 (ex: starting 0->1 for #=key=5)
		
		#pushes to @numbers the line numbers of the selected sequence, keeping in mind that each fastq sequence has 4 lines
		push @numbers, $number * 4;
		push @numbers, $number * 4 + 1;
		push @numbers, $number * 4 + 2;
		push @numbers, $number * 4 + 3;
	}
	
    my @sortedNums = sort {$a <=> $b} @numbers;
	
	#Opens the Fastq files for reading
	open (my $r1File, '<', $r1FqAddress) or die "Can't open file $r1FqAddress: $!";
	open (my $r2File, '<', $r2FqAddress) or die "Can't open file $r2FqAddress: $!";
	
	#Creates the files that the trimmed reads will be added to
	my $r1FqTrimAddress  = $r1FqAddress . ".trimmed";
	my $r2FqTrimAddress  = $r2FqAddress . ".trimmed";
	open (my $r1TrimFile, '>', $r1FqTrimAddress) or die "Can't open file $r1FqTrimAddress: $!";
	open (my $r2TrimFile, '>', $r2FqTrimAddress) or die "Can't open file $r2FqTrimAddress: $!";
	
	my ($r1Line, $r2Line);#The current line in each original file, should be same line number
	my $sortedNumsIndex = 0;#The current index in @sortedNums, the line to be transferred to the trimmed file next
	
	#Progresses through the two files line by line checking to see whether or not each line needs to be moved to the trimmed file
	for (my $i=0; $r1Line = <$r1File>; $i++) {
		$r2Line = <$r2File>;
		#If the current line number is in @sortedNums, prints the R1 & R2 line to the respective trimmed file
		if ($sortedNumsIndex < scalar(@sortedNums) && $sortedNums[$sortedNumsIndex] == $i) {
			print $r1TrimFile $r1Line;
			print $r2TrimFile $r2Line;
			
			$sortedNumsIndex++;
		}
	}
	
	#Creates the trimmed fastqs
	#$cmd = "head -n " . $lineCutNum . " " . $r1FqAddress . " > " . $r1FqAddress . ".trimmed";
	#print $cmd, "\n";
	#`$cmd`;
	#sleep(1);
	#$cmd = "head -n " . $lineCutNum . " " . $r2FqAddress . " > " . $r2FqAddress . ".trimmed";
	#print $cmd, "\n";
	#`$cmd`;
	#sleep(1);
	
	#Renames the trimmed fastqs, overwriting the untrimmed fastqs
	$cmd = "mv " . $r1FqTrimAddress . " " . $r1FqAddress;
	print $cmd, "\n";
	`$cmd`;
	sleep(0.5);
	$cmd = "mv " . $r2FqTrimAddress . " " . $r2FqAddress;
	print $cmd, "\n";
	`$cmd`;
	sleep(0.5);
	
	close $r1File or die "Cannot close $r1File: \$!";
	close $r2File or die "Cannot close $r2File: \$!";
}
