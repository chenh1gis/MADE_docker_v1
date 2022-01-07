#!/usr/bin/perl

#############################################################################
## Author: Hui Chen
## Created Time: 2018-1-3 14:41:44
## File Name: Generate_report.pl
## Description: MADE is deposited in https://github.com/chenh1gis/MADE_docker
#############################################################################

##use strict;
##use warnings;
use Getopt::Long;

$SUBTYPE="";	## H1N1seasonal:1 H1N1pdm:2 H3N2:3
$ID="NA";
$STRAIN="NA";
$HOST="NA";
$PASSAGE="NA";
$FILE="";
$POST="NA";

GetOptions(
        'subtype=s' => \$SUBTYPE,
        'id=s' => \$ID,
	'strain=s' => \$STRAIN,
	'host=s' => \$HOST,
	'passage=s' => \$PASSAGE,
	'input_file=s' => \$FILE 
);

if (!-e "$FILE"){print "Error : file \"$FILE\" does not exist!\n"; exit(0);}

%Genetic_code=('TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S','TTC'=>'F','TTT'=>'F','TTA'=>'L','TTG'=>'L','TAC'=>'Y','TAT'=>'Y','TAA'=>'-','TAG'=>'-','TGC'=>'C','TGT'=>'C','TGA'=>'-','TGG'=>'W','CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L','CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P','CAC'=>'H','CAT'=>'H','CAA'=>'Q','CAG'=>'Q','CGA'=>'R','CGC'=>'R','CGG'=>'R','CGT'=>'R','ATA'=>'I','ATC'=>'I','ATT'=>'I','ATG'=>'M','ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T','AAC'=>'N','AAT'=>'N','AAA'=>'K','AAG'=>'K','AGC'=>'S','AGT'=>'S','AGA'=>'R','AGG'=>'R','GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V','GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A','GAC'=>'D','GAT'=>'D','GAA'=>'E','GAG'=>'E','GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G');

%SYMBOL=('t'=>'T','c'=>'C','a'=>'A','g'=>'G');

@array=split(/@/,$EMAIL);
undef %FILE;
opendir(DIR,"./");
@file_list=readdir(DIR);
foreach $file(@file_list)
{
        $FILE{$file}=1;
}
closedir (DIR);

if ($FILE!~/\.fa/) {print "Error : please specify the correct nucleotide sequence file in FASTA format!\n"; exit(0);}
system ("cp $FILE file_sequence.fa");

if ($SUBTYPE!=1 && $SUBTYPE!=2 && $SUBTYPE!=3)
{
	print "Error : please specify the correct virus subtype!\n";
	exit(0);
}

$UserSeq="";
	open (SEQUENCE,"file_sequence.fa");
	$title=<SEQUENCE>;
	chomp $title;
	$seq=<SEQUENCE>;
	chomp $seq;
	$UserSeq=$seq;	
	if ($title!~/>/)
	{
        	print "ERROR: the sequence title is in wrong format, please update the sequence file in FASTA format\n"; exit(0);
	}
	if ($seq!~/[^ATCGatcg]/)
	{
		$seq=~s/a/A/g;
		$seq=~s/t/T/g;
		$seq=~s/c/C/g;
		$seq=~s/g/G/g;
		$aa=$AA=$SEQ="";
	        $len=length($seq);
		for ($i=0;$i<$len/3;$i++)
		{
		        $base=substr($seq,$i*3,1);
	                $base1=substr($seq,$i*3+1,1);
	                $base2=substr($seq,$i*3+2,1);
	                $BASE=$base.$base1.$base2;
                        $aa=$aa.$Genetic_code{$BASE};
		}
	}
	else
	{
		print "Error : ambiguous character is not  acceptable for MADE analysis!\n";
		exit(0);	
	}
	close SEQUENCE;

if ($SUBTYPE==1)
{
	$DEFINITION="influenza A H1N1 seasonal virus HA segment";
        system ("perl extract_alleles.pl 1 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
        system ("rm sequence_combined.fa; rm sequence_combined.afa");
        system ("R -e \"library(prettydoc); rmarkdown::render(\'MADE_report_H1N1seasonal.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\'))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H1N1seasonal.html\" under \.\/src\n";
}elsif ($SUBTYPE==2)
{
	$DEFINITION="influenza A H1N1 pandemic virus HA segment";
        system ("perl extract_alleles.pl 2 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
        system ("rm sequence_combined.fa; rm sequence_combined.afa");
        system ("R -e \"library(prettydoc); rmarkdown::render(\'MADE_report_H1N1pdm.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\',))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H1N1pdm.html\" under \.\/src\n";
}else
{
	$DEFINITION="influenza A H3N2 virus HA segment";
        system ("perl extract_alleles.pl 3 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
	system ("R -e \"library(prettydoc); rmarkdown::render(\'MADE_report_H3N2.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\',seq=\'$UserSeq\'))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H3N2.html\" under \.\/src\n";
}
