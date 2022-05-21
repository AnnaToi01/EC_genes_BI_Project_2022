# Search for homologs of egg-cell specific genes, study of their expression patterns and regulatory elements for the creation of effective constructs for genetic engineering  
___



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
2. [References](#references)
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

We downloaded genomes, annotations and amino acid sequences for 53 plant species. All species and links presented in table. 
We explore databases [Plant Ensemble](http://ftp.ensemblgenomes.org/pub/plants/release-52/), 
[PLAZA](https://bioinformatics.psb.ugent.be/plaza/), 
[MBKBASE](http://www.mbkbase.org/) and [Phytozome](https://phytozome-next.jgi.doe.gov/).

<a name="ec1_search"></a>
## Searching for orthogroups containing EC1 gene family

<a name="phylogen"></a>
## Alignment and phylogenetic analysis of these orthogroups

<a name="expression"></a>
## Gene expression patterns analysis

<a name="motifs"></a>
## Searching for regulatory elements in upstream sites of the gene-orthologs

<a name="references"></a>
### References
- Wang, ZP., Xing, HL., Dong, L. et al. Egg cell-specific promoter-controlled CRISPR/Cas9 efficiently generates homozygous mutants for multiple target genes in Arabidopsis in a single generation. Genome Biol 16, 144 (2015).

<a name="Setup"></a>
## Setup
1. Create virtual environment via conda using file `conda_requirements.txt`.
```
$ conda create --name <environment_name> --file conda_requirements.txt
```
2. Follow instructions on how to install OrthoFinder v2.5.4 on [the according GitHub page](https://github.com/davidemms/OrthoFinder).

<a name="Software"></a>
## Software Requirements

* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/python.svg height=20> Python 3.8
* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/ubuntu.svg height = 20> Ubuntu 21.04
* <img src=https://github.com/simple-icons/simple-icons/blob/develop/icons/gnubash.svg height=20> Bash
