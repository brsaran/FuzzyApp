#!/usr/bin/perl 
######## FuzzyAPP #####################
#        Developed by SARAVANAN VIJAYAKUMAR
#         Centre for Bioinformatics, Pondicherry University
#         brsaran@gmail.com
#         Date: 14-2-2013
#

######Required Modules
####

my $Seq_In = @ARGV[0];
$Seq_In=~s/\s//g;
#End !

#Path setting for MEME_OUT and others in temp
$meme_out_path = ''.&generate_random_string(8);
$meme_out_path1 = $meme_out_path.'/query';

##Create directory for memeout
`mkdir $meme_out_path`;
####End!
###Save sequence
open(TTT,">$meme_out_path1");
print TTT ">test\n$Seq_In";
close(TTT);

####End!
#####Run MAST
$trig = `pwd`.'/meme/src/mast';
$trig=~s/\n//g;
`$trig meme.txt $meme_out_path1 -oc $meme_out_path`;
open(TTT,"$meme_out_path/mast.txt");
my @MAST_OUT = <TTT>;
my $M_O = join('',@MAST_OUT);
$M_O=~s/\n/\@/g;
$M_O =~m/\*\@\@\@test(.*)\*/g;
$M_O= $1;
$M_O=~s/\@/\n/g;
print $M_O; 

`rm -rf $meme_out_path`;
#End!

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
