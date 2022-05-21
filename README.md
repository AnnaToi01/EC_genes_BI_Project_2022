# Search for homologs of egg-cell specific genes, study of their expression patterns and regulatory elements for the creation of effective constructs for genetic engineering  

**Students:**  
Elena Grigoreva ([github](https://github.com/lengrigo), [telegram](https://t.me/lengrigo))  
Anna Toidze ([github](https://github.com/AnnaToi01), [telegram](https://t.me/anna_toidze))

**Supervisors:**  
Maria Logacheva, Skoltech  
Artem Kasianov, IITP RAS

## Introduction
Choosing a promoter for Cas nucleases - is an important step in genome editing. In plant gene engineering it is often 
used constitutive promoters such as 35S that have high level of expression in all cell types. But using promoters specific 
for germ line cells is more effective approach because it can lead to homogeneity 
and to decreasing of off target mutations.  

EC 1.1 and EC 1.2 are A.thaliana genes from Egg Cell family that are specifically 
and highly expressed in egg cells. It was shown that using of promoters of these 
genes significantly improved genome editing ([Wang et al, 2015](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0715-0)).  

For other plants there are no information about similar promoters. But knowing that homologous genes can have similar 
function we supposed that EC homologs can have similar expression pattern and using their promoters can be also effective.

*So the aim of our project is to find functional analogs of EC genes in different crops and model plants and explore 
their expression patterns and regulatory elements*

## Table of Contents
1. [Pipeline](#Pipeline)
    1. [Downloading genomes, annotations and amino acid sequences](#sources)
    2. [Searching for orthogroups containing EC1 gene family](#ec1_search)
    3. [Alignment and phylogenetic analysis of these orthogroups](#phylogen)
    4. [Gene expression patterns analysis](#expression)
    5. [Searching for regulatory elements in upstream sites of the gene-orthologs](#motifs)
    6. [Conclusion](#conclusion)
2. [Literature](#references)
3. [Setup](#Setup)
4. [Software Requirements](#Software)

<a name="Pipeline"></a>
**Pipeline:**
- Download genomes, annotations and amino acid sequences;
- Search for orthogroups containing EC1 gene family;
- Alignment and phylogenetic analysis of these orthogroups;
- Gene expression patterns analysis;
- Search for regulatory elements in upstream sites of the gene-orthologs.

<a name="sources"></a>
## Downloading genomes, annotations and amino acid sequences  

We downloaded genomes, annotations and amino acid sequences for 53 plant species. All species and links presented in table `/Species_table.xlsx`. 
We explore databases [Plant Ensemble](http://ftp.ensemblgenomes.org/pub/plants/release-52/), 
[PLAZA](https://bioinformatics.psb.ugent.be/plaza/), 
[MBKBASE](http://www.mbkbase.org/) and [Phytozome](https://phytozome-next.jgi.doe.gov/).

<a name="ec1_search"></a>
## Searching for orthogroups containing EC1 gene family

To find EC1 genes orthologs we used [Orthofinder tool v.2.5.4](https://github.com/davidemms/OrthoFinder). 
Before running orthofinder we devided species for several groups for faster working. The list of groups and species can be found in `Groups.csv`. Each group was put in separete folder.
Script for running orthofinder for all groups is located in `./OrthoFinder_launch/` folder.  
  
Code for analisys Orthofinder output located in `./OrthoGroups_analysis/OrthoFinder_results_analysis.ipynb`.

According to Orthofinder results EC1.1 and EC1.2 genes belong to one orthogroup. We extracted all genes that got in the 
same orthogroup with EC genes (191 gene) and took their protein and nucleotide sequences for further analysis.
File with protein sequences is `./OrthoGroups_analysis/conc_protein_seq.fa`

<a name="phylogen"></a>
## Alignment and phylogenetic analysis of these orthogroups

The code for phylogenetic analysis and all resulting files are located in `./Phylogenetic_analysis` folder.  
  
To align protein sequences we tried three aligners - Muscle, MAFFT and ClustalO. ClustalO showed the best coverage.

**MAFFT alignment**  
![mafft alignment](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Phylogenetic_analysis/alig_mafft.png)  
**Muscle alignment**  
![muscle alignment](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Phylogenetic_analysis/alig_muscle.png)  
**ClustalO alignment**  
![clustalo alignment](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Phylogenetic_analysis/alig_clustalo.png)  
  
Obtained alignment was taken mate a phylogenetic tree. Tre was constructed using [IQ-TREE tool v2.2.0_beta](http://www.iqtree.org/) by maximum likelyhood method. Amborella trichopoda was chosen as outgroup.
Resulting tree can be found in file `./Phylogenetic_analysis/clustalo_not_trimmed_iqtree_bootstrap.treefile`
  
To visualise tree we used R package [ggtree](https://guangchuangyu.github.io/software/ggtree/). 
Script for tree drawing is `./Phylogenetic_analysis/tree_drawing.R`

![phylogenetic tree](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Phylogenetic_analysis/tree_circ_branch_length.png)

There two clades on the tree - for EC1.1 and EC1.2. Inside the clades genes are grouped according to species phylogeny. 
Third clad probably contains genes that are not the EC1.1 or EC1.2 orthologs (for example, it is otrhologs for other EC genes). Dicots and monocots are presented in each clade. 
Some species have several orthologs of EC genes. The next step is to figure out which of the genes are the most similar with Arabidopsis genes by their expression pattern.

<a name="motifs"></a>
## Gene expression patterns analysis
To find out which expression patterns found orthologs have we searched for open-assesed transcriptional data based on RNA-seq analysis. All used databases are presented in `./Transctriptional_databases.xlsx`  
Due to absence or bad quality of transcription data for some species, only 20 species and 53 genes orthologs were taken for further analysis.
According to their expression profile all genes were divided into three groups. Data genes and their expression description presented in `./Gene_expression_data.csv` file.

| Group number | Group name   | Amount of genes | Description                                                                                 |
|:-------------|:-------------|:----------------|:--------------------------------------------------------------------------------------------|
| 1            | generative   | 23              | As for EC genes - expression in female generative organs is the highest and specific        |
| 2            | non-specific | 29              | Expression in female generative organs is present but not only there or/and not the highest |
| 3            | vegetative   | 5               | No expression in female generative organs. Only in vegetative parts of plants               |

## Searching for regulatory elements in upstream sites of the gene-orthologs

The next step was to search patterns in genes that got in one of three groups. From [Jaspar](https://jaspar.genereg.net/) database we took all known motif sequences specific for plants (656 motifs). 
[FIMO](https://meme-suite.org/meme/doc/fimo.html) tool was used to  search for these motifs in 500 bp upstream region of found orthologs.
Fasta files with 500 bp upstream sequences for each group by expression - `./Searching_motifs/generative_group1.fasta`, `./Searching_motifs/non-specific_group2.fasta` and `./Searching_motifs/vegetative_group3.fasta`.
  
After that headmaps that reflects presence of different motifs in upstream sequences in each group was made.

**GENERATIVE**  
![heatmap_group1](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Searching_motifs/heatmap_new_group_1.png)  
  
**NON-SPECIFIC**  
![heatmap_group2](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Searching_motifs/heatmap_new_group_2.png)  
  
**VEGETATIVE**  
![heatmap_group3](https://github.com/AnnaToi01/EC_genes_BI_Project_2022/blob/annatoi/Searching_motifs/heatmap_new_group_3.png)

No consistent patterns for motif presence were observed for any group.

<a name="conclusion"></a>
## Conclusion
Expression specific for generative organs does not depends on presence  certain motifs in regulatory area of genes. It is defined by motif combination. And for each particular gene this combination is unique.

<a name="references"></a>
## Literature
- Wang, ZP., Xing, HL., Dong, L. et al. Egg cell-specific promoter-controlled CRISPR/Cas9 efficiently generates homozygous mutants for multiple target genes in Arabidopsis in a single generation. Genome Biol 16, 144 (2015).

<a name="Setup"></a>
## Setup
Install Anaconda if not already installed (see [Instructions](https://docs.anaconda.com/anaconda/install/index.html)).
1. Create virtual environment via conda using file `conda_requirements.txt`.
```
$ conda create --name <env_name>
```
2. Activate it
```
$ conda activate <env_name>
```
3. Install necessary libraries
```
$ pip install -r requirements.txt
```
4. Follow instructions on how to install OrthoFinder v2.5.4 on [the according GitHub page](https://github.com/davidemms/OrthoFinder).
5. For phylogenetic analysis download using conda (e.g. [MUSCLE conda](https://anaconda.org/conda-forge/biopython)) or GitHub Page (e.g. [MUSCLE GitHub](https://github.com/rcedgar/muscle)). 
    * MUSCLE - v5.1
    * MAFFT - v7.505
    * Clustal Omega - 1.2.3
    * Ugene - v41
    * IQ-Tree v2.0.3

<a name="Software"></a>
## Software Requirements

* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/python.svg height=20> Python 3.8
* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/ubuntu.svg height = 20> Ubuntu 21.04
* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/gnubash.svg height=20> Bash
* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/r.svg height=20> R 4.1.2
    
