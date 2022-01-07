## Command Line Options

Given the allelic information over those key codon positions, the strength of egg passage adaptation will be measured and the vaccine effectiveness will be predicted for a candidate influenza vaccine strain.

### Input files
#### nucleotide sequence file [in FASTA format]
For an example sequence file for H3N2 influenza, please refers to “/test/file_sequence.fa”.

*Please note that if any allele is missing or its corresponding enrichment score is not available in our curated dataset, the analysis will be terminated immediately.*

### Options

> --subtype
It is **compulsory** for user to specify the subtype of the candidate influenza vaccine strain. For example, “1” denotes H1N1seasonal virus, “2” denotes H1N1pdm virus and “3” denotes H3N2 virus.
Please note that the analysis focusing on H1N1seasonal and H1N1pdm viruses will be only available in next version.

> --id
This option allows user to input the public database ID such as “NC000001” of the candidate influenza vaccine strain. 

> --strain
This option allows user to input the original source of the candidate influenza vaccine strain, for example, “A/Phillipphines/2002”.

> --host
This option allows user to input the host where the candidate influenza vaccine strain sources  from, for example, “human” or “embryonated egg”.

> --passage
This option allows user to input the passage history of the candidate influenza vaccine strain,  for example, “embryonated egg” or “Madin-Darby Canine Kidney (MDCK)”.

> --input_file
 
It is **compulsory** to specify the input file. 
*Please be careful with the relative directory.*

###　Example

 `perl generate_report.pl --subtype 3 --id NC0001 --strain A/Phllipphines/1998 --host Human --passage Egg --input_file test/H3N2_HA1_sequence.fa`

  *Please note that **muscle3.8.31_i86linux64** must to executable, e.g. `chmod 544 muscle3.8.31_i86linux64`.*
