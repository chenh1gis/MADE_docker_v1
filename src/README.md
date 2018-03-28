## Command Line Options

Given the allelic information over those key codon positions, the strength of egg passage adaptation will be measured and the vaccine efficacy will be predicted for a candidate influenza vaccine strain.
 
### Input files
 
There are two different approaches user can input the allelic information to MADE.

#### Approach 1: specifying the alleles at a set of codon positions driven by passage adaptation
#### allelic file [in TXT format]
For an example allelic file for H3N2 influenza, please refer to “/test/file_alleles.txt”.
 
All alleles from specified codon positions should be listed into two separated columns (For different influenza viruses, the associated amino acid positions will be different). 

```
* For H1N1 seasonal virus, these 9 codon positions with strong egg-passage adaptation should be given:
89, 97, 129, 134, 161, 185, 186, 221, 222, 226

* For H1N1 pandemic virus, these 10 codon positions with strong egg-passage adaptation should be given:
21, 127, 129, 183, 190, 191, 222, 223, 225

* For H3N2 virus, these 14 codon positions with strong egg-passage adaptation should be given:
138, 145, 156, 158, 159, 160, 183, 186, 190, 193, 194, 219, 226, 246
```

*Please note that if any allele is missing or its corresponding enrichment score is not available in our curated dataset, the analysis will be terminated immediately.*
 
#### Approach 2: specifying the corresponding nucleotide sequence
#### nucleotide sequence file [in FASTA format]
For an example sequence file for H3N2 influenza, please refers to “/test/file_sequence.fa”.
 
Alternatively, the allelic file can be generated from a sequence file.
 
*Please note that if any allele is missing or its corresponding enrichment score is not available in our curated dataset, the analysis will be terminated immediately.*
 

### Options

> --subtype

It is **compulsory** for user to specify the subtype of the candidate influenza vaccine strain. For example, “1” denotes H1N1seasonal virus, “2” denotes H1N1pdm virus and “3” denotes H3N2 virus.
 
> --is_allelic_file

It is **compulsory** for user to specify the type of input file. For example, “1” denotes a allelic file while “0” denotes a nucleotide sequence file.
 
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
 
 `perl generate_report.pl --subtype 3 --is_allelic_file 0 --id NC0001 --strain A/Phllipphines/1998 --host Human --passage Egg --input_file test/H3N2_HA1_sequence.fa`
   
   or
  
  `perl generate_report.pl --subtype 3 --is_allelic_file 1 --id NC0001 --strain A/Phllipphines/1998 --host Human --passage Egg --input_file test/H3N2_14alleles.fa`
  
  *Please note that **muscle3.8.31_i86linux64** must to executable, e.g. `chmod 544 muscle3.8.31_i86linux64`.*
