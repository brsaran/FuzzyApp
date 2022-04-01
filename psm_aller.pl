#!/usr/bin/perl
######## FuzzyAPP #####################
#        Developed by SARAVANAN VIJAYAKUMAR
#         Centre for Bioinformatics, Pondicherry University
#         brsaran@gmail.com
#         Date: 14-2-2013
#

######Required Modules
my $PATH_EXE = "/home/user/Documents/Softwares/FuzzyApp-master/";

use List::Util qw[max];
my $PATHJAR = $PATH_EXE.'weka.jar';
##############Sequence Input via arguments
$Sequence_In = @ARGV[0];
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~BINOM FEATURE Calc
$Arff = "\@relation whatever\n\n\@attribute 1 numeric\n\@attribute 2 numeric\n\@attribute 3 numeric\n\@attribute 4 numeric\n\@attribute 5 numeric\n\@attribute 6 numeric\n\@attribute 7 numeric\n\@attribute 8 numeric\n\@attribute 9 numeric\n\@attribute 10 numeric\n\@attribute 11 numeric\n\@attribute 12 numeric\n\@attribute 13 numeric\n\@attribute 14 numeric\n\@attribute 15 numeric\n\@attribute 16 numeric\n\@attribute 17 numeric\n\@attribute 18 numeric\n\@attribute 19 numeric\n\@attribute 20 numeric\n\@attribute 21 numeric\n\@attribute 22 numeric\n\@attribute 23 numeric\n\@attribute 24 numeric\n\@attribute 25 numeric\n\@attribute 26 numeric\n\@attribute 27 numeric\n\@attribute 28 numeric\n\@attribute 29 numeric\n\@attribute 30 numeric\n\@attribute 31 numeric\n\@attribute 32 numeric\n\@attribute 33 numeric\n\@attribute 34 numeric\n\@attribute 35 numeric\n\@attribute 36 numeric\n\@attribute 37 numeric\n\@attribute 38 numeric\n\@attribute 39 numeric\n\@attribute 40 numeric\n\@attribute 41 numeric\n\@attribute 42 numeric\n\@attribute 43 numeric\n\@attribute 44 numeric\n\@attribute 45 numeric\n\@attribute 46 numeric\n\@attribute 47 numeric\n\@attribute 48 numeric\n\@attribute 49 numeric\n\@attribute 50 numeric\n\@attribute 51 numeric\n\@attribute 52 numeric\n\@attribute 53 numeric\n\@attribute 54 numeric\n\@attribute 55 numeric\n\@attribute 56 numeric\n\@attribute 57 numeric\n\@attribute 58 numeric\n\@attribute 59 numeric\n\@attribute 60 numeric\n\@attribute LABEL { A , N } \n\n\n\@data\n";
$Arff.= &Type_I($Sequence_In).",".&Type_II($Sequence_In).",".&Type_III($Sequence_In).","."A\n";
####Storing arff
my $path_info = '';
my $File_string=$path_info.&generate_random_string(8);
$File_string.='.arff';

open(TTT,">$File_string");
print TTT $Arff;
close(TTT);
$Arff="";
#####Adaboost Prediction
my $Machine_res = &ML_Test("$PATH_EXE/AN.model",$File_string);
print $Machine_res;
unlink($File_string);
#######End!

#################################### Vector Calc
sub Type_I{
    my($param_one)=@_;

    $param_one = uc $param_one;
    @SLC = qw(A C D E F G H I K L M N P Q R S T V W Y);
    $Length_Prt = length($param_one);
    my $i=0;
#    Measure Calculation
    foreach(@SLC){
             if($param_one =~m/$SLC[$i]/g){
                 $nX[$i] = ($param_one =~s/$SLC[$i]/$SLC[$i]/g);
             }else{
                 $nX[$i] = 0;

             }
             $i++;
    }
    #Measure Calculation
    for($i=0;$i<$Length_Prt;$i++){
         $pX[$i] = $nX[$i]/$Length_Prt;
         #$pX[$i] = sprintf "%.2f",$pX[$i];
    }
    #Theoretical Mean Calculation
    @Res_Codon_Occ = qw(4 2 2 2 2 4 2 3 2 6 1 2 4 2 6 6 4 4 1 2);
    my $j=0;
    foreach(@Res_Codon_Occ){
        $piX[$j] = $Res_Codon_Occ[$j]/61;
        #$piX[$j] = sprintf "%.2f",$piX[$j];
        $j++;
    }
    #Theoretical variance Calculation
    for($i=0;$i<20;$i++){
              $Theo_Variance[$i] = ($piX[$i]*(1-$piX[$i]))/$Length_Prt;
              #$Theo_Variance[$i] = sprintf "%.2f",$Theo_Variance[$i];
    }
    #Type I Parameter Calculation
    for($i=0;$i<20;$i++){
        eval{($pX[$i] - $piX[$i])/(sqrt($Theo_Variance[$i]));};
        if($@){
              $Type_I_Value[$i] = 0.00;
        }else{
              $Type_I_Value[$i] = ($pX[$i] - $piX[$i])/(sqrt($Theo_Variance[$i]));
              #$Type_I_Value[$i] = sprintf "%.2f", $Type_I_Value[$i];
        }

    }
    $vector1 = join(",",@Type_I_Value);
    return $vector1;
}
############################################################################
sub TRACE_POS{
    my($STRING,$CHAR)= @_;
    my $ixyz=0;

    my $sum=0;
    do{
       $Holder[$ixyz] = index($STRING,$CHAR,$Crawler)+1;
       $sum+=$Holder[$ixyz];
       $Crawler = $Holder[$ixyz];
       $ixyz++;
       $ex = index($STRING,$CHAR,$Crawler);
    }until ($ex == -1);

    return $sum;
 }
###########################################################################
sub Type_II{
    my($param_two) = @_;

    $param_two = uc $param_two;
    @SLC = qw(A C D E F G H I K L M N P Q R S T V W Y);
    $Length_Prt = length($param_two);
    my $i=0;
    #Measure Calculation
    foreach(@SLC){
             if($param_two =~m/$SLC[$i]/g){
                 $nX[$i] = ($param_two =~s/$SLC[$i]/$SLC[$i]/g);
             }else{
                 $nX[$i] = 0;
             }
             $i++;
    }
    for($i=0;$i<20;$i++){
        if($nX[$i] == 0){
              $M_m[$i] = 0.0;
              $T_v[$i]= 0.0;
              $P_V[$i] = 0.0;
        }else{
              $M_m[$i]= &TRACE_POS($param_two,$SLC[$i])/$nX[$i];
              $T_v[$i] = (($Length_Prt+1)*($Length_Prt-$nX[$i])/(12*$nX[$i]));    #Theoritical Variance Calculation
              $T_m[$i] = ($Length_Prt+1)/2; #Theoritical Mean
              $P_V[$i] = ($M_m[$i]-$T_m[$i])/(sqrt($T_v[$i]));    #Parameter Value Calculation
        }
    }
    $vector2 = join(",",@P_V);
    @SLC=();
    @nX=();
    @M_m=();
    @T_v=();
    @P_V=();
    return $vector2;
}
###################################
sub COMPLEX_POS{
    my($STRING,$CHAR)= @_;
    my $i=0;
    my $sum=0;
    my $Crawler=0;
    my $ex;
    my $k;
    do{
       $HolderX[$i] = index($STRING,$CHAR,$Crawler)+1;
       $sum+=$HolderX[$i];
       $Crawler = $HolderX[$i];
       $i++;
       $ex = index($STRING,$CHAR,$Crawler);
    }until ($ex == -1);
    $ret=0;
    for($k=0;$k<@HolderX;$k++){
             $elite = ($STRING=~s/$CHAR/$CHAR/g);
             if($elite!= 0){
                 $ret+= ($HolderX[$k]- (($sum/$elite)))**2;
             }else{
                 $ret+=0;
             }
    }
        @HolderX=();
    return $ret;
 }
 ###################################
sub Type_III{
    my($param_three) = @_;


    @SLC = qw(A C D E F G H I K L M N P Q R S T V W Y);
    $Length_Prt = length($param_three);
    my $i=0;
    foreach(@SLC){
             if($param_three =~m/$SLC[$i]/g){
                 $nX[$i] = ($param_three =~s/$SLC[$i]/$SLC[$i]/g);
             }else{
                 $nX[$i] = 0;
             }
             $i++;
    }
    $const1 = ($Length_Prt-1)/$Length_Prt;
    for($i=0;$i<20;$i++){
         if($nX[$i] == 1){
             $const2 = 0.0;
         }else{
             $const2 = 1/($nX[$i]-1);
         }

         $const3 = &COMPLEX_POS($param_three,$SLC[$i]);
         $Me_m[$i] = $const1*$const2*$const3;#Measure 3
         $Te_m[$i] = (($Length_Prt**2)-1)/12;

         if($nX[$i]==0){
            $Te_v[$i] = 0;
         }else{
            if($nX[$i] == 1){
                $Te_v[$i] = 0.0;
            }else{
                $Te_v[$i] = (($Length_Prt-$nX[$i])*(($Length_Prt-1)**2)*($Length_Prt+1)*((2*$nX[$i]*$Length_Prt)+(3*$Length_Prt)+(3*$nX[$i])+3))/(360*$nX[$i]*($nX[$i]-1)*$Length_Prt);
            }
         }
         if($Te_v[$i]!=0){
             $F_V[$i] = ($Me_m[$i]-$Te_m[$i])/(sqrt($Te_v[$i]));    #Parameter Value Calculation
         }else{
             $F_V[$i]= 0.0;
         }
#         print $F_V[$i]."\n";
    }
    $vector3 = join(',',@F_V);
    @SLC=();
    @nX=();
    @Te_v=();
    @F_V=();
    return $vector3;
}

sub ML_Test{
my($MODEL,$fil,$xsav)= @_;
    #my $result = `java -classpath weka.jar weka.classifiers.meta.AdaBoostM1 -T $fil -l $MODEL -p 0`;
    my $result = `java -classpath $PATHJAR weka.classifiers.meta.AdaBoostM1 -T $fil -l $MODEL -p 0`;
    #$result=~s/ //g;
    #my @Cont = split('\n',$result);
    return $result;
}
###########
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
