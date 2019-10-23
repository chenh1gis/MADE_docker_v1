#!/usr/bin/perl

#############################################################################
## Author: Hui Chen
## Created Time: 2019-10-3 14:41:44
## File Name: Generate_report.pl
## Description: MADE interactive interface is available via http://39.105.1.41/made/
#############################################################################

##use strict;
##use warnings;
use Getopt::Long;

$SUBTYPE="";	## H1N1seasonal:1 H1N1pdm:2 H3N2:3
$ALLE_FILE="";	## ALLE:1 SEQ:0
$ID="NA";
$STRAIN="NA";
$HOST="NA";
$PASSAGE="NA";
$FILE="";
$POST="NA";

GetOptions(
        'subtype=s' => \$SUBTYPE,
        'is_allelic_file=s' => \$ALLE_FILE,
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

if ($ALLE_FILE==0)
{
	if ($FILE!~/\.fa/) {print "Error : please specify the correct nucleotide sequence file in FASTA format!\n"; exit(0);}
	system ("cp $FILE file_sequence.fa");
}
elsif ($ALLE_FILE==1)
{
        if ($FILE!~/\.txt/) {print "Error : please specify the correct allelic file in TXT format!\n"; exit(0);}
	system ("rm file_allele.txt; cp $FILE file_allele.txt");
}
else
{
	print "Error : please specify the correct type of input file!\n";
	exit(0);
}

if ($SUBTYPE!=1 && $SUBTYPE!=2 && $SUBTYPE!=3)
{
	print "Error : please specify the correct virus subtype!\n";
	exit(0);
}

if ($ALLE_FILE==0)
{
	open (SEQUENCE,"file_sequence.fa");
	$title=<SEQUENCE>;
	chomp $title;
	$seq=<SEQUENCE>;
	chomp $seq;
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
}

sub cal_posterior_prob{
	open (AF,"$_[0]");
	$line=<AF>;
	$line=<AF>;
	my @array, %PVALUE, %AF_egg, %AF_other, $no_egg, $no_other;
	undef %PVALUE;
	undef %AF_egg;
	undef %AF_other;
	chomp $line;
	@array=split(/\t/,$line);
	$PVALUE{$array[0]}{$array[1]}=$array[8];
	$AF_egg{$array[0]}{$array[1]}=$array[4];
	$AF_other{$array[0]}{$array[1]}=$array[7];
	$no_egg=$array[2]+$array[3];
	$no_other=$array[5]+$array[6];
	while ($line=<AF>)
	{
        	chomp $line;
	        @array=split(/\t/,$line);
        	$PVALUE{$array[0]}{$array[1]}=$array[8];
	        $AF_egg{$array[0]}{$array[1]}=$array[4];
        	$AF_other{$array[0]}{$array[1]}=$array[7];
	}
	close AF;

	open (ALLE,"$_[1]");
	$egg=$other=1;
	$line=<ALLE>;
	while ($line=<ALLE>)
	{
        	chomp $line;
	        @array=split(/\t/,$line);
        	if ($AF_egg{$array[0]}{$array[1]}>$AF_other{$array[0]}{$array[1]} && $PVALUE{$array[0]}{$array[1]}<=0.0001)
	        {
        	        $egg=$egg*$AF_egg{$array[0]}{$array[1]};
                	$other=$other*$AF_other{$array[0]}{$array[1]};
	        }
	}
	close ALLE;
	$POST=sprintf("%.3f",$egg*$no_egg/($egg*$no_egg+$other*$no_other));
}




if ($SUBTYPE==1)
{
	$DEFINITION="influenza A H1N1 seasonal virus HA segment";
        if ($ALLE_FILE==0)
        {
                system ("perl extract_alleles.pl 1 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
                system ("rm sequence_combined.fa; rm sequence_combined.afa");
        }	
#        &cal_posterior_prob("../data/H1N1seasonal/H1N1seasonal_allele_freq_pvalue","file_allele.txt");
        system ("R -e \"install.packages('prettydoc'); library(prettydoc); rmarkdown::render(\'MADE_report_H1N1seasonal.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\',post=\'$POST\'))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H1N1seasonal.html\" under \.\/src\n";
}elsif ($SUBTYPE==2)
{
	$DEFINITION="influenza A H1N1 pandemic virus HA segment";
        if ($ALLE_FILE==0)
        {
                system ("perl extract_alleles.pl 2 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
                system ("rm sequence_combined.fa; rm sequence_combined.afa");
        }	
#        &cal_posterior_prob("../data/H1N1pdm/H1N1pdm_allele_freq_pvalue","file_allele.txt");
        system ("R -e \"install.packages('prettydoc'); library(prettydoc); rmarkdown::render(\'MADE_report_H1N1pdm.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\',post=\'$POST\'))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H1N1pdm.html\" under \.\/src\n";
}else
{
	$DEFINITION="influenza A H3N2 virus HA segment";
        if ($ALLE_FILE==0)
	{
                system ("perl extract_alleles.pl 3 file_sequence.fa ../muscle/muscle3.8.31_i86linux64 sequence_combined.fa sequence_combined.afa file_allele.txt");
#		system ("rm sequence_combined.fa; rm sequence_combined.afa");
	}
#	&cal_posterior_prob("../data/H3N2/H3N2_allele_freq_pvalue","file_allele.txt");
	system ("R -e \"install.packages('prettydoc'); library(prettydoc); rmarkdown::render(\'MADE_report_H3N2.Rmd\',html_pretty(),output_dir='./',params=list(id=\'$ID\',def=\'$DEFINITION\',strain=\'$STRAIN\',host=\'$HOST\',pass=\'$PASSAGE\',post=\'$POST\'))\"");
	print "Analysis finished!\nPlease refer to \"MADE_report_H3N2.html\" under \.\/src\n";
}
