#!/bin/bash -l
#PBS -d .
#PBS -l walltime=100:00:00
#PBS -l nodes=1:ppn=12
#PBS -l mem=10gb
conda activate orthofinder_annatoi
path_to_orthofinder_script=./OrthoFinder_source/orthofinder.py
for i in {1..7}
do
    path_to_protein_seq_group=./groups/$i/
    path_to_output_file=./orthofinder_group_$i.txt
    path_to_error_file=./orthofinder_error_$i.txt
    echo $path_to_protein_seq_group
    python $path_to_orthofinder_script -f $path_to_protein_seq_group > $path_to_output_file 2> $path_to_error_file
done
