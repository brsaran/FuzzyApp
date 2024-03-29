<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
<!DOCTYPE mast[
<!ELEMENT mast (model, alphabet, motifs, sequences, runtime)>
<!ATTLIST mast version CDATA #REQUIRED release CDATA #REQUIRED>
<!ELEMENT model (command_line, max_correlation, remove_correlated, strand_handling, translate_dna, max_seq_evalue,
    adj_hit_pvalue, max_hit_pvalue, max_weak_pvalue, host, when)>
<!ELEMENT command_line (#PCDATA)>
<!ELEMENT max_correlation (#PCDATA)>
<!ELEMENT remove_correlated EMPTY>
<!ATTLIST remove_correlated value (y|n) #REQUIRED>
<!ELEMENT strand_handling EMPTY>
<!ATTLIST strand_handling value (combine|separate|norc|protein) #REQUIRED>
<!ELEMENT translate_dna EMPTY>
<!ATTLIST translate_dna value (y|n) #REQUIRED>
<!ELEMENT max_seq_evalue (#PCDATA)>
<!ELEMENT adj_hit_pvalue EMPTY>
<!ATTLIST adj_hit_pvalue value (y|n) #REQUIRED>
<!ELEMENT max_hit_pvalue (#PCDATA)>
<!ELEMENT max_weak_pvalue (#PCDATA)>
<!ELEMENT host (#PCDATA)>
<!ELEMENT when (#PCDATA)>
<!ELEMENT alphabet (letter*)>
<!ATTLIST alphabet type (amino-acid|nucleotide) #REQUIRED bg_source (preset|file|sequence_composition) #REQUIRED bg_file CDATA #IMPLIED>
<!ELEMENT letter EMPTY>
<!ATTLIST letter symbol CDATA #REQUIRED ambig (y|n) "n" bg_value CDATA #IMPLIED>
<!ELEMENT motifs (motif*,correlation*,nos*)>
<!ATTLIST motifs source CDATA #REQUIRED name CDATA #REQUIRED last_mod_date CDATA #REQUIRED>
<!ELEMENT motif EMPTY>
<!-- num is simply the loading order of the motif, it's superfluous but makes things easier for XSLT -->
<!ATTLIST motif id ID #REQUIRED num CDATA #REQUIRED name CDATA #REQUIRED width CDATA #REQUIRED
   best_f CDATA #REQUIRED best_r CDATA #IMPLIED bad (y|n) "n">
<!-- for n > 1 motifs there should be (n * (n - 1)) / 2 correlations, obviously there are none for only 1 motif -->
<!ELEMENT correlation EMPTY>
<!ATTLIST correlation motif_a IDREF #REQUIRED motif_b IDREF #REQUIRED value CDATA #REQUIRED>
<!-- nos: Nominal Order and Spacing diagram, a rarely used feature where mast can adjust pvalues for an expected motif spacing -->
<!ELEMENT nos (expect*)>
<!-- length is in the same unit as the motifs, which is not always the same unit as the sequence -->
<!ATTLIST nos length CDATA #REQUIRED>
<!-- the expect tags are expected to be ordered by pos ascending -->
<!ELEMENT expect EMPTY>
<!ATTLIST expect pos CDATA #REQUIRED gap CDATA #REQUIRED motif IDREF #REQUIRED>
<!ELEMENT sequences (database*, sequence*)>
<!-- the database tags are expected to be ordered in file specification order -->
<!ELEMENT database EMPTY>
<!ATTLIST database id ID #REQUIRED num CDATA #REQUIRED source CDATA #REQUIRED name CDATA #REQUIRED last_mod_date CDATA #REQUIRED 
    seq_count CDATA #REQUIRED residue_count CDATA #REQUIRED type (amino-acid|nucleotide) #REQUIRED link CDATA #IMPLIED>
<!-- the sequence tags are expected to be ordered by best combined p-value (of contained score tags) ascending -->
<!ELEMENT sequence (score*,seg*)>
<!ATTLIST sequence id ID #REQUIRED db IDREF #REQUIRED num CDATA #REQUIRED name CDATA #REQUIRED comment CDATA "" length CDATA #REQUIRED>
<!ELEMENT score EMPTY>
<!-- frame is the starting offset for translation of dna sequences which gives the lowest pvalues for the provided protein motifs -->
<!ATTLIST score strand (both|forward|reverse) #REQUIRED frame (a|b|c) #IMPLIED combined_pvalue CDATA #REQUIRED evalue CDATA #REQUIRED>
<!-- within each sequence the seg tags are expected to be ordered by start ascending -->
<!ELEMENT seg (data,hit*)>
<!ATTLIST seg start CDATA #REQUIRED>
<!ELEMENT data (#PCDATA)>
<!-- within each seg the hit tags are expected to be ordered by pos ascending and then forward strand first -->
<!ELEMENT hit EMPTY>
<!-- gap, while superfluous, makes creating motif diagrams for the text version much easier when using XSLT -->
<!ATTLIST hit pos CDATA #REQUIRED gap CDATA #REQUIRED motif IDREF #REQUIRED pvalue CDATA #REQUIRED strand (forward|reverse) "forward" 
    match CDATA #REQUIRED translation CDATA #IMPLIED>
<!ELEMENT runtime EMPTY>
<!ATTLIST runtime cycles CDATA #REQUIRED seconds CDATA #REQUIRED>
]>
<mast version="" release="">
	<model>
		<command_line></command_line>
		<max_correlation>0.60</max_correlation>
		<remove_correlated value="n"/>
		<strand_handling value="combine"/>
		<translate_dna value="n"/>
		<max_seq_evalue>10</max_seq_evalue>
		<adj_hit_pvalue value="n"/>
		<max_hit_pvalue>0.0001</max_hit_pvalue>
		<max_weak_pvalue>0.0001</max_weak_pvalue>
		<host></host>
		<when></when>
	</model>
	<alphabet type="nucleotide" bg_source="">
		<letter symbol="A" bg_value="0.274"/>
		<letter symbol="C" bg_value="0.225"/>
		<letter symbol="G" bg_value="0.225"/>
		<letter symbol="T" bg_value="0.274"/>
	</alphabet>
	<motifs source="" name="" last_mod_date="">
		<motif id="motif_1" num="1" name="1" width="18" best_f="AATTGTGACGTCGATCAC" best_r="GTGATCGACGTCACAATT"/>
		<motif id="motif_2" num="2" name="2" width="8" best_f="CGGCGGGG" best_r="CCCCGCCG"/>
		<correlation motif_a="motif_1" motif_b="motif_2" value="0.41"/>
	</motifs>
	<sequences>
		<database id="db_1" num="1" source="" name="" last_mod_date="" seq_count="18" residue_count="1890" type="nucleotide"/>
		<sequence id="seq_1_8" db="db_1" num="8" name="ilv" comment="39" length="105">
			<score strand="both" combined_pvalue="6.47e-06" evalue="0.00012"/>
			<seg start="1">
				<data>
GCTCCGGCGGGGTTTTTTGTTATCTGCAATTCAGTACAAAACGTGATCAACCCCTCAATTTTCCCTTTGCTGAAA
				</data>
				<hit pos="5" gap="4" motif="motif_2" pvalue="6.6e-06" strand="forward" match="++++++++"/>
				<hit pos="43" gap="30" motif="motif_1" pvalue="1.8e-06" strand="reverse" match="++++++ +++ + +++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_10" db="db_1" num="10" name="male" comment="14" length="105">
			<score strand="both" combined_pvalue="8.72e-05" evalue="0.0016"/>
			<seg start="1">
				<data>
ACATTACCGCCAATTCTGTAACAGAGATCACACAAAGCGACGGTGGGGCGTAGGGGCAAGGAGGATGGAAAGAGG
				</data>
				<hit pos="14" gap="13" motif="motif_1" pvalue="1.3e-05" strand="forward" match="++ +++ +++  ++++++"/>
				<hit pos="41" gap="9" motif="motif_2" pvalue="1.5e-05" strand="forward" match="++++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_2" db="db_1" num="2" name="ara" comment="17 55" length="105">
			<score strand="both" combined_pvalue="5.15e-04" evalue="0.0093"/>
			<seg start="1">
				<data>
GACAAAAACGCGTAACAAAAGTGTCTATAATCACGGCAGAAAAGTCCACATTGATTATTTGCACGGCGTCACACT
TTGCTATGCCATAGCATTTTTATCCATAAG
				</data>
				<hit pos="59" gap="58" motif="motif_1" pvalue="2.8e-07" strand="reverse" match=" ++ ++++++++++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_9" db="db_1" num="9" name="lac" comment="9 80" length="105">
			<score strand="both" combined_pvalue="8.46e-04" evalue="0.015"/>
			<seg start="1">
				<data>
AACGCAATTAATGTGAGTTAGCTCACTCATTAGGCACCCCAGGCTTTACACTTTATGCTTCCGGCTCGTATGTTG
				</data>
				<hit pos="9" gap="8" motif="motif_1" pvalue="5.8e-07" strand="forward" match="++ ++++++ + + ++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_12" db="db_1" num="12" name="malt" comment="41" length="105">
			<score strand="both" combined_pvalue="1.55e-03" evalue="0.028"/>
			<seg start="1">
				<data>
GATCAGCGTCGTTTTAGGTGAGTTGTTAATAAAGATTTGGAATTGTGACACAGTGCAAATTCAGACACATAAAAA
				</data>
				<hit pos="41" gap="40" motif="motif_1" pvalue="9.3e-07" strand="forward" match="+++++++++++ ++ ++ "/>
			</seg>
		</sequence>
		<sequence id="seq_1_16" db="db_1" num="16" name="pbr322" comment="53" length="105">
			<score strand="both" combined_pvalue="2.79e-03" evalue="0.05"/>
			<seg start="1">
				<data>
CTGGCTTAACTATGCGGCATCAGAGCAGATTGTACTGAGAGTGCACCATATGCGGTGTGAAATACCGCACAGATG
				</data>
				<hit pos="57" gap="56" motif="motif_1" pvalue="3.0e-06" strand="reverse" match="+++++  +++ ++++ ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_6" db="db_1" num="6" name="deop2" comment="7 60" length="105">
			<score strand="both" combined_pvalue="3.71e-03" evalue="0.067"/>
			<seg start="1">
				<data>
AGTGAATTATTTGAACCAGATCGCATTACAGTGATGCAAACTTGTAAGTAGATTTCCTTAATTGTGATGTGTATC
GAAGTGTGTTGCGGAGTAGATGTTAGAATA
				</data>
				<hit pos="60" gap="59" motif="motif_1" pvalue="3.0e-06" strand="forward" match="++++++++ +++ ++++ "/>
			</seg>
		</sequence>
		<sequence id="seq_1_15" db="db_1" num="15" name="uxu1" comment="17" length="105">
			<score strand="both" combined_pvalue="6.22e-03" evalue="0.11"/>
			<seg start="1">
				<data>
CCCATGAGAGTGAAATTGTTGTGATGTGGTTAACCCAATTAGAATTCGGGATTGACATGTCTTACCAAAAGGTAG
				</data>
				<hit pos="17" gap="16" motif="motif_1" pvalue="5.4e-06" strand="forward" match="+ ++++++ ++++++ ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_17" db="db_1" num="17" name="trn9cat" comment="1 84" length="105">
			<score strand="both" combined_pvalue="8.04e-03" evalue="0.14"/>
			<seg start="76">
				<data>
TTTGGCGAAAATGAGACGTTGATCGGCACG
				</data>
				<hit pos="84" gap="83" motif="motif_1" pvalue="6.0e-06" strand="forward" match="++ ++ +++++ +++++ "/>
			</seg>
		</sequence>
		<sequence id="seq_1_1" db="db_1" num="1" name="ce1cg" comment="17 61" length="105">
			<score strand="both" combined_pvalue="8.60e-03" evalue="0.15"/>
			<seg start="1">
				<data>
TAATGTTTGTGCTGGTTTTTGTGGCATCGGGCGAGAATAGCGCGTGGTGTGAAAGACTGTTTTTTTGATCGTTTT
CACAAAAATGGAAGTCCACAGTCTTGACAG
				</data>
				<hit pos="65" gap="64" motif="motif_1" pvalue="7.9e-06" strand="reverse" match=" ++++++ + ++++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_11" db="db_1" num="11" name="malk" comment="29 61" length="105">
			<score strand="both" combined_pvalue="8.78e-03" evalue="0.16"/>
			<seg start="1">
				<data>
GGAGGAGGCGGGAGGATGAGAACACGGCTTCTGTGAACTAAACCGAGGTCATGTAAGGAATTTCGTGATGTTGCT
TGCAAAAATCGTGGCGATTTTATGTGCGCA
				</data>
				<hit pos="61" gap="60" motif="motif_1" pvalue="1.7e-05" strand="forward" match="+++ ++++ ++ + + ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_14" db="db_1" num="14" name="tnaa" comment="71 " length="105">
			<score strand="both" combined_pvalue="1.11e-02" evalue="0.2"/>
			<seg start="1">
				<data>
TTTTTTAAACATTAAAATTCTTACGTAATTTATAATCTTTAAAAAAAGCATTTAATATTGCTCCCCGAACGATTG
TGATTCGATTCACATTTAAACAATTTCAGA
				</data>
				<hit pos="75" gap="74" motif="motif_1" pvalue="1.5e-05" strand="reverse" match="+++++ ++  +++++ ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_13" db="db_1" num="13" name="ompa" comment="48" length="105">
			<score strand="both" combined_pvalue="1.19e-02" evalue="0.21"/>
			<seg start="1">
				<data>
GCTGACAAAAAAGATTAAACATACCTTATACAAGACTTTTTTTTCATATGCCTGACGGAGTTCACACTTGTAAGT
				</data>
				<hit pos="48" gap="47" motif="motif_1" pvalue="9.4e-06" strand="forward" match="+++  +++++  ++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_4" db="db_1" num="4" name="crp" comment="63" length="105">
			<score strand="both" combined_pvalue="1.29e-02" evalue="0.23"/>
			<seg start="1">
				<data>
CACAAAGCGAAAGCTATGCTAAAACAGTCAGGATGCTACAGTAATACATTGATGTACTGCATGTATGCAAAGGAC
GTCACATTACCGTGCAGTACAGTTGATAGC
				</data>
				<hit pos="67" gap="66" motif="motif_1" pvalue="1.0e-05" strand="reverse" match="++ ++ +++++++++ ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_7" db="db_1" num="7" name="gale" comment="42" length="105">
			<score strand="both" combined_pvalue="1.78e-02" evalue="0.32"/>
			<seg start="1">
				<data>
GCGCATAAAAAACGGCTAAATTCTTGTGTAAACGATTCCACTAATTTATTCCATGTCACACTTTTCGCATCTTTG
				</data>
				<hit pos="46" gap="45" motif="motif_1" pvalue="1.5e-05" strand="reverse" match=" +  ++++++++++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_18" db="db_1" num="18" name="tdc" comment="78" length="105">
			<score strand="both" combined_pvalue="1.92e-02" evalue="0.34"/>
			<seg start="76">
				<data>
TAATTTGTGAGTGGTCGCACATATCCTGTT
				</data>
				<hit pos="82" gap="81" motif="motif_1" pvalue="1.6e-05" strand="reverse" match="++++  ++++ ++++ ++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_5" db="db_1" num="5" name="cya" comment="50" length="105">
			<score strand="both" combined_pvalue="2.15e-02" evalue="0.39"/>
			<seg start="1">
				<data>
ACGGTGCTACACTTGTATGTAGCGCATCTTTCTTTACGGTCAATCAGCAAGGTGTTAAATTGATCACGTTTTAGA
				</data>
				<hit pos="50" gap="49" motif="motif_1" pvalue="1.9e-05" strand="forward" match="+ ++++ + ++ ++++++"/>
			</seg>
		</sequence>
		<sequence id="seq_1_3" db="db_1" num="3" name="bglr1" comment="76" length="105">
			<score strand="both" combined_pvalue="7.57e-02" evalue="1.4"/>
			<seg start="76">
				<data>
AACTGTGAGCATGGTCATATTTTTATCAAT
				</data>
				<hit pos="76" gap="75" motif="motif_1" pvalue="8.3e-05" strand="forward" match="++ ++++++   + +++ "/>
			</seg>
		</sequence>
	</sequences>
	<runtime cycles="" seconds=""/>
</mast>
