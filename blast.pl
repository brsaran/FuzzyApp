#	!/usr/bin/perl 
######## FuzzyAPP #####################
#        Developed by SARAVANAN VIJAYAKUMAR
#         Centre for Bioinformatics, Pondicherry University
#         brsaran@gmail.com
#         Date: 14-2-2013
#

######Required Modules

use List::Util qw[max];
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use MIME::Lite; #To be installed
use List::Util qw(first max min);
# Sequence In from argument
my $Seq_In = @ARGV[0];
$Seq_In=~s/\s//g;
###Ends!
###File generation

$Xtreme_File = ''.&generate_random_string(8);
open(TTT,">$Xtreme_File");
print TTT "\>query\n".$Seq_In;
close(TTT);
####Ends!

###BLAST 
print &BLAST_SIMILARITY("blastp -db MEMESeq -query $Xtreme_File");
unlink($Xtreme_File);
####Ends!

############Subroutine

sub BLAST_SIMILARITY{#Parses the blast out put for query seq; Parameter -- balst query cmd; returns similarity percentage;
    my $query_cmd = $_[0];
    $xtr = `$query_cmd`;

if($xtr!~/No hits found/gi){
    $xtr =~m/Length\=(.*)/g;
    $Bp_Len = $1;
    $xtr =~m/Identities \=(.*) Pos/;
    $xtr = $1;
    $xtr =~m/ (.*)\//g;
    $r = $1;
    if($Bp_Len != 0){
	    $Similarity = ($r/$Bp_Len);
	    return $Similarity;
	}else{ return 0;}
}else{
    return 0;
}
}

#Random Fiel name generator
sub generate_random_string
{
	my $length_of_randomstring=shift;# the length of 
			 # the random string to generate

	my @chars=('a'..'z','A'..'Z','0'..'9');
	my $random_string;
	foreach (1..$length_of_randomstring) 
	{
		# rand @chars will generate a random 
		# number between 0 and scalar @chars
		$random_string.=$chars[rand @chars];
	}
	return $random_string;
}
####Ends!
