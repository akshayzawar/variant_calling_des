#!/bin/bash ;

echo -e "\n\n\n" ;
echo "###########################################################################" ;
echo "#Pre-liminary step:  Variable and log initialisation#" ;
echo "###########################################################################" ;

Read1="$1" ;
Read2="$2" ;
Ref_Fasta="$3" ;
#SRR14160265_1.fastq
base=$(echo "$Read1" | awk -F'_' '{print $1}')

#Root Directories
Pipeline_root="/mnt/d/Workshops/Skill_Dev_DESPU/Pipeline_Development" ;
Results_root="/mnt/d/Workshops/Skill_Dev_DESPU/Pipeline_Development/Results" ;

echo -e "\n" ;
echo "Variable Assignment Done.";

echo -e "\n\n" ;
echo "#####################################################" ;
echo "#Analysis step 1:  Quality Check#" ;
echo "#####################################################" ;

echo `fastqc "$Read1"` ;
echo `fastqc "$Read2"` ;

echo -e "\n" ;
echo "FastQC Done.";

echo -e "\n\n" ;
echo "#####################################################" ;
echo "#Analysis step 2:  Genome Indexing #" ;
echo "#####################################################" ;

echo `bwa index "$Ref_Fasta"` ;

echo -e "\n" ;
echo "Genome Indexing Done" ;

echo "#####################################################" ;
echo "#Analysis step 3:  Read Mapping #" ;
echo "#####################################################" ;

echo `bwa mem -t 4 "$Ref_Fasta" "$Read1" "$Read2" > "$Results_root"\"${base}"_Mapped.sam`
