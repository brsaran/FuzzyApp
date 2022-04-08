# FuzzyApp
FuzzyAPP a novel fuzzy rule based system for assessing the protein for allergenicity. It combines five different modules–Machine learning classifier (MLC), Motif search, Global similarity with allergen, FAO/WHO evaluation scheme, and Global similarity with allergen like putative non-allergen (APN)– to assess the protein allergenicity. Further, with the modules output as parameter, a fuzzy inference system with 108 fuzzy IF THEN rules were designed to assess the final quality of the protein. 

Installation

Prerequistie

1. Perl 5.0 or greater
2. BLAST Standalone version
3. FASTA36
4. MEME

Required perl modules <br>
List::Util (Mandatory)<br>
MIME:Lite (Mandatory)<br>
<br>
Please set the path to blast standalone executable in the blast.pl ( variable $path_to_blastp) before executing the program. Failing so will produce unexpected or error result. <br>
Please set the variable $PATH_EXE in FuzzyApp, blast.pl, fasta.pl, meme.pl, and psm_aller.pl to the full location of the FuzzyApp-master. For example if the FuzzyApp-master folder  is in the location /home/user/Documents/Softwares/FuzzyApp-master/ then set the $PATH_EXE variable in the above mentioned files to $PATH_EXE = "/home/user/Documents/Softwares/FuzzyApp-master/". Note: the "/" at the end is mandatory.<br>


Do install the FASTA36 and MEME and put the binaries in the FuzzyApp folder. The FuzzyApp comes with the precompiled binaries, in case those binaries are not executable (as it is compiled in Fedora21) kindly do install FASTA36 and MEME using the corresponding .gz file provided in the package and put the binaries in FuzzyApp/fasta36/bin for FASTA36 and FuzzyApp/meme/src for MEME. The pre-compiled binaries were tested in Ubuntu 16.04, and found working fine.

Extract the FuzzyApp package from github, give executable permission to FuzzyApp file and execute by following command

./FuzzyApp inputfilename outputfilename <br>
ex: ./FuzzyApp test.fasta mytestout <br>

Note: The argument order should not be shuffled, first argument is for input file and second is for output file.



The input and output options are interactive and self descriptive.

