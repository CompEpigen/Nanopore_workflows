# Nanopore_workflows

## Workflow: Haplotype_phasing

The Haplotype_phasing workflow is intended to assign each read of an input file to a haplotype of diploid origin.
The core of that process is formed by the NanoMethPhase tool which was developed by [Akbari et al. in 2021](https://doi.org/10.1186/s13059-021-02283-5).
The workflow can be used in two ways, which differ in their starting points. On the one hand, you can start with already alinged bam-files, but also further upstream with fastq-files. Depending on this, different workflows have to be used, the structure of which is described below.

![alt text](https://github.com/CompEpigen/Nanopore_workflows/blob/main/wf_flowchart.pdf)


### Option 1: starting at bam-file
If you already have an alinged bam-file, you can use the "Haplotype_phasing.cwl" workflow, which is indicated by the colour green in the flowchart above.
To use this, the following input files are required:
* **nanopore.bam**; bam file with additional index file (.bai)
* **reference_genome.fa**; reference genome with additional index file (.fai)
* **methylation_calls.tsv**; methylation calls as it is provided by [nanopolish](https://github.com/jts/nanopolish) for example.
* **shortread_snvs.vcf**; vcf-file containing SNVs in vcf format. (snvs are mandatory for using the tool, but it is no problem if there are other variants in the vcf file as well, these do not have to be filtered out beforehand.)

All these inputs are written with full paths directly into the "Haplotype_phasing.yml" file, which can also be found in the "workflow" directory. In addition to the file inputs, two further string inputs are required. One is the name of the sample, which can be freely chosen by the user, and the output format of the bam files. We recommend "bam2bis", which converts the output bam files into wgbs-bam-files.
The most important prerequisite for option 1, however, is that the shortread SNVs, as well as the nanopore reads, have been **aligned with the same reference genome**, which must be also the same provided to this workflow.
If the reference is different, option 2 must be used.

#### Run option 1:
Option 1 can be used with cwltool. Further the machine has to support singularity images, as different tools are required.
The following code example shows how to execute the workflow on "odcf-worker01". Since the home directories have limited memory, we need to specify a path for temporary files, otherwise they will exceed the memory capacity. Furthermore, cwltool stores the created outputs in the directory in which it is executed. Therefore, it is recommended to create a seperate directory for this run.

```bash



```


### Option 2: starting at fastq-file
To use the second option, which starts from the fastq file, the workflow "full_processing.cwl" must be used, which is marked in yellow in the flowchart. This actually executes two sub-workflows, which on the one hand is formed by the "Haplotype_phasing.cwl" workflow mentioned in option 1, which is preceded by a second "alignment.cwl" workflow. This creates a bam file from fastq file and the methylation calls needed for the second workflow.
Option 2 therefore requires the following inputs:
* **nanopore.fastq**; fastqfile of nanopore data with additional index files pointing to the fast5 directory (can be created by nanopolish index)
* **reference_genome.fa**; reference genome with additional index file (.fai)
* **shortread_snvs.vcf**; vcf-file containing SNVs in vcf format.

All these inputs are written with full paths directly into the "full_processing.yml" file, which can also be found in the "workflow" directory. In addition to the file inputs, three further string inputs are required. One is the name of the sample, which can be freely chosen by the user, the output format of the bam files. We recommend "bam2bis". The last input is the threads which should be used by nanopolish for calling mathylation. We recommend 8 threads.
The most important prerequisite for option 2, again, is that the provided reference genome is the same which was used for alingment of the shortread data.


