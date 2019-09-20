## Essential Supporting Documents

To perform the analysis, several supporting files are required for different virus subtypes.
 
### Reference nucleotide sequence

Reference nucleotide sequence is provided for performing sequence alignment between the input sequence and the reference genome. After sequence alignment, we can extract the allelic status of the codons are the given positions from the input sequence. 

For H3N2 reference nucleotide sequence, please refer to the “/data/H3N2/H3N2_HA1_sequence.fa”.


### Enrichment scores of all alleles extracted from a large database of curated sequences

For any given allele at a codon position, enrichment score is defined as the ratio of the allele frequency in the egg passaged strains (Pegg) and in the total set (Ptotal). This enrichment score file stores all the enrichment scores of the observed alleles in the database.  This can be used in subsequent analysis.
 
For H3N2 reference enrichment scores file, please refer to “/data/H3N2/H3N2_enrichment_scores_329codons”.


### Multi-dimensional enrichment scores across all background viral sequences

In order to perform the PCA analysis, we need the enrichment profiles of the input sequence as well as all the background sequences from the public database.

For H3N2 subtype, please refer to “/data/H3N2/H3N2_background strains_20alleles”.

We have curated the profiles of enrichment scores across all the sequences in the GISAID database. This file will be used in the PCA map.
