#!/usr/bin/perl 
######## Fuzzy-AllerPred #####################
#        Developed by SARAVANAN VIJAYAKUMAR
#         Centre for Bioinformatics, Pondicherry University
#         brsaran@gmail.com
#         Date: 14-2-2013
#

######Required Modules
use Cwd qw(abs_path);
use lib abs_path(); #setting module dependnecy path ! Do not change unless you are sure !
use AI::FuzzyInference;
my $AFuzz = new AI::FuzzyInference;

$ADIn = @ARGV[0];
$MEIn = @ARGV[1];
$GAIn = @ARGV[2];
$WHIn = @ARGV[3];
$GHIn = @ARGV[4];

####Adaboost member (input)

    $AFuzz->inVar('AdaBoost', 0, 1,
          Allergen         => [-0.1, 0,
                           0, 1,
                           0.2, 1,
                            0.5,0],
          Nonallergen      => [0.5, 0,
                           0.8, 1,
                           1, 1,
                            1.1,0],
          );
####MEME member (input)

    $AFuzz->inVar('MEME', 0, 1,
          Significant     => [-0.1, 0,
                             0, 1,
                             0.2, 1,
                             0.5, 0],
          Nonsignificant    => [0.5, 0,
                                0.8, 1,
                                1, 1,
                                1.1,0],
          );
####GADB member (input)

    $AFuzz->inVar('GADB', 0, 1,
          Poor     => [-0.1, 0,
                       0, 1,
                       0.2, 1,
                       0.5, 0],
          Moderate => [0.45, 0,
                        0.55, 1,
                        0.7, 1,
                        0.8,0],
          High     => [0.75, 0,
                       0.9, 1,
                       1, 1,
                       1.1, 0],
          );
####WHO member (input)

    $AFuzz->inVar('WHO', 0, 1,
          Poor     => [-0.1, 0,
                       0, 1,
                       0.2, 1,
                       0.45, 0],
          Allowed  => [0.4, 0,
                        0.55, 1,
                        0.75, 0],
          Significant => [0.7, 0,
                       0.9, 1,
                       1, 1,
                       1.1, 0],
          );

####GHNA member (input)

    $AFuzz->inVar('GHNA', 0, 1,
          Poor     => [-0.1, 0,
                       0, 1,
                       0.2, 1,
                       0.5, 0],
          Moderate => [0.45, 0,
                        0.55, 1,
                        0.7, 1,
                        0.8,0],
          High     => [0.75, 0,
                       0.9, 1,
                       1, 1,
                       1.1, 0],
          );
####hit (output)

    $AFuzz->outVar('AllerFIS', 0, 1,
           NA      => [-0.1, 0,
                         0, 1,
                         0.2, 1,
                         0.35, 0],
           MA      => [0.35, 0,
                         0.45, 1,
                         0.55, 0],
           A       => [0.55, 0,
                         0.68, 1,
                         0.8, 0],
           PA       => [0.8, 0,
                         0.9, 1,
                         1, 1,
                         1.1, 0],
           );

    $AFuzz->addRule(
#            'Ada=nonaller  & MEME=nsig'      => 'hit=NA',
#            'Ada=nonaller  & MEME=sig'       => 'hit=MA',
#            'Ada=aller     & MEME=nsig'      => 'hit=MA',
#            'Ada=aller     & MEME=sig'       => 'hit=PA',






'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=Poor' => 'AllerFIS=PA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=Moderate' => 'AllerFIS=PA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=Poor' => 'AllerFIS=PA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=Poor' => 'AllerFIS=PA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=Poor' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=Poor' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=Poor' => 'AllerFIS=MA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Allergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=Poor' => 'AllerFIS=PA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=Moderate' => 'AllerFIS=A',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Allowed & GHNA=High' => 'AllerFIS=MA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=High & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=Poor' => 'AllerFIS=A',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=MA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Moderate & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=Poor' => 'AllerFIS=MA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Significant & GADB=Poor & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=High & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Moderate & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Significant & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Allowed & GHNA=High' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=Poor' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=Moderate' => 'AllerFIS=NA',
'AdaBoost=Nonallergen & MEME=Nonsignificant & GADB=Poor & WHO=Poor & GHNA=High' => 'AllerFIS=NA',
);

####Rule ENDS!!!!

#####Defuzzyfy

$AFuzz->compute(AdaBoost=>$ADIn, MEME=>$MEIn, GADB=>$GAIn, WHO=>$WHIn, GHNA=>$GHIn);
$Weight = $AFuzz->value(AllerFIS);
######

##Convert weight to Lingual

if($Weight<=0.35){
	print "NA";
}elsif($Weight>0.35 && $Weight<=0.5){
	print "MA";
}elsif($Weight>0.5 && $Weight<=0.80){
	print "A";
}elsif($Weight>0.8 && $Weight<=1){
	print "PA";
}
#######ENDS!!!
