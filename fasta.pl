#!/usr/bin/perl 
######## Fuzzy-AllerPred #####################
#        Developed by SARAVANAN VIJAYAKUMAR
#         Centre for Bioinformatics, Pondicherry University
#         brsaran@gmail.com
#         Date: 14-2-2013
#

######Required Modules

use List::Util qw[max];
#use CGI qw(:standard);
#use CGI::Carp qw(fatalsToBrowser);
use MIME::Lite; #To be installed
use List::Util qw(first max min);
# Sequence In from argument

my $Seq_In = @ARGV[0];
$Seq_In=~s/\s//g;
#print $Seq_In;
#End !


#Path setting for FASTA36 and others in temp
$Fpath = `pwd`.'/fasta36/bin/';
$Fpath=~s/\n//g;
$Seqpath = `pwd`.'/';
$Seqpath =~s/\n//g;
#End!

##FASTA for GLOBAL WITH ALLERGEN DATABASE 
my $G_Seq = ">Query\n$Seq_In";
my $G_rand_file = $Seqpath.&generate_random_string(8);
open(TTT,">$G_rand_file");
print TTT $G_Seq;
close(TTT);
$G_result = &Execute_FASTA36($Fpath,$G_rand_file,$Seqpath,'ADB.fasta');

if($G_result ne ''){
		$G_result=~s/\s/\@/g;
		my @GTemp_array = split('\@',$G_result);
		$GQID = @GTemp_array[0];
		$GBID = @GTemp_array[1]; 
		$GIDENTITY = @GTemp_array[2];
		$GEVALUE = sprintf("%.10g", @GTemp_array[10]);
		$G_result = "Global Identity:$GIDENTITY\tGlobal_Evalue:$GEVALUE\tSubject:$GBID";
}else{
	$G_result = "Result:NSH";
}


#End !
##FASTA for GLOBAL WITH HOMOLOG NON-ALLERGEN DATABASE 
my $HG_Seq = ">Query\n$Seq_In";
my $HG_rand_file = $Seqpath.&generate_random_string(8);
open(TTT,">$HG_rand_file");
print TTT $G_Seq;
close(TTT);
$HG_result = &Execute_FASTA36($Fpath,$HG_rand_file,$Seqpath,'HNA.fasta');

if($HG_result ne ''){
		$HG_result=~s/\s/\@/g;
		my @HGTemp_array = split('\@',$HG_result);
		$HGQID = @HGTemp_array[0];
		$HGBID = substr(@HGTemp_array[1],0,6); 
		$HGIDENTITY = @HGTemp_array[2];
		$HGEVALUE = sprintf("%.10g", @HGTemp_array[10]);
		$HG_result = "Global Identity:$HGIDENTITY\tGlobal_Evalue:$HGEVALUE\tSubject:$HGBID";
}else{
	$HG_result = "Result:NSH";
}

#End !
###FASTA for 80 Window split
$tem_num = int length($Seq_In)-80;
for(my $i=0;$i<$tem_num;$i++){
	#Saving sequence in random file
	my $random_file = $Seqpath.&generate_random_string(8);
	open(TTT,">$random_file");
	print TTT ">".($i+1)."-".($i+80)."\n".substr($Seq_In,$i,80);
	close(TTT);
	#@Eighty_win_res[$i] = &Execute_FASTA36($Fpath,$random_file,$Seqpath);
	my $Ding = &Execute_FASTA36($Fpath,$random_file,$Seqpath,'Allergy_DB.fasta');
	
	if($Ding ne ''){
		$Ding=~s/\s/\@/g;
		my @Temp_array = split('\@',$Ding);
		@QID[$i] = @Temp_array[0];
		@BID[$i] = @Temp_array[1]; 
		@IDENTITY[$i] = @Temp_array[2];
		if(@Temp_array[10] ne ""){
			@EVALUE[$i] = sprintf("%.10g", @Temp_array[10]);
		}else{
			@EVALUE[$i] = 1000;
		}
	}else{
		$F36_OUT = "NSH";
	}
}

if($F36_OUT ne "NSH"){
	my $search = min(@EVALUE);
	my $index = first { $EVALUE[$_] eq $search } 0 .. $#EVALUE;	
	$F36_OUT = @IDENTITY[$index];
	$F36_DOUT = "Window_Pos:".@QID[$index]."\t"."Subject:".@BID[$index]."\t"."Identity:".@IDENTITY[$index]."\t"."E-Value:".@EVALUE[$index];
}else{
	$F36_DOUT = "Result:NSH";
}

print $G_result."\n".$F36_DOUT."\n".$HG_result;


#End !


#Executing Fasta sub
sub Execute_FASTA36{

my ($path1,$path2,$path3,$DB) = @_;
#Execution of FASTA36 program
#-m 8 -> format -b ->number of out

#	$Execu = $Fpath.'./fasta36'.' -m 8 -b 1'." ".$random_file." $Seqpath".'library.fasta';
	#my $Execu = $path1.'./fasta36'.' -m 8 -b 1'." ".$path2." $path3".'Allergy_DB.fasta';
	my $Execu = $path1.'fasta36'.' -m 8 -b 2 -f -10 -g -2 -E 0.001 '." ".$path2." $path3"."$DB";
	my $Result = `$Execu `;
	unlink($path2);
	#End !

	#Result Parsing
	my @Res_line = split('\n',$Result);
	return @Res_line[4];
	#End !
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
