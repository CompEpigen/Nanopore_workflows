# Nanopore_workflows

## Workflow: Haplotype_phasing

The Haplotype_phasing workflow is intended to assign each read of an input file to a haplotype of diploid origin.
The core of that process is formed by the NanoMethPhase tool which was developed by [Akbari et al. in 2021](https://doi.org/10.1186/s13059-021-02283-5).
The workflow can be used in two ways, which differ in their starting points. On the one hand, you can start with already alinged bam-files, but also further upstream with fastq-files. Depending on this, different workflows have to be used, the structure of which is described below.

![alt text](https://github.com/CompEpigen/Nanopore_workflows/blob/main/wf_flowchart.png)


### Option 1: starting at bam-file
If you already have an alinged bam-file, you can use the "Haplotype_phasing.cwl" workflow, which is indicated by the colour green in the flowchart above.
To use this, the following input files are required:
* **nanopore.bam**; bam file with additional index file (.bai)
* **reference_genome.fa**; reference genome with additional index file (.fai)
* **methylation_calls.tsv**; methylation calls as it is provided by [nanopolish](https://github.com/jts/nanopolish) for example.
* **shortread.bam**; corresponding bam file of shortread SNVs.
* **shortread_snvs.vcf**; vcf-file containing SNVs in vcf format. (snvs are mandatory for using the tool, but it is no problem if there are other variants in the vcf file as well, these do not have to be filtered out beforehand.)

All these inputs are written with full paths directly into the "Haplotype_phasing.yml" file, which can also be found in the "workflow" directory. In addition to the file inputs, two further string inputs are required. One is the name of the sample, which can be freely chosen by the user, and the output format of the bam files. Since the output bam files are of little importance, the format "bam2bis" is recommended, in which the output bam files are converted into the wgbs-format, which can then be viewed in IGV, for example. The most valuable output is a tsv file, which contains the information on how many SNVs are assigned to which haplotype on a read. The reads can then be assigned to the haplotypes in downstream processes on the basis of their read-ID.
The most important prerequisite for option 1, however, is that the shortread SNVs, as well as the nanopore reads, have been **aligned with the same reference genome**, which must be also the same provided to this workflow.
If the reference is different, option 2 must be used.

#### Run option 1:
Option 1 can be used with cwltool. Further the machine has to support singularity images, as different tools are required.
The following code example shows how to execute the workflow on "odcf-worker01". Since the home directories have limited memory, we need to specify a path for temporary files, otherwise they will exceed the memory capacity. Furthermore, cwltool stores the created outputs in the directory in which it is executed. Therefore, it is recommended to create a seperate directory for this run.

```bash
## clone git repo
git clone https://github.com/CompEpigen/Nanopore_workflows.git
## set working directory
wrk_dir="${path}/Nanopore_workflows/workflows"
## set run-name (sample name recommended)
run="sample_name"
## set output directory path
out_dir="${output_path}/${run}"
## and create subdirectories for temporary files (otherwise it will exceed home-diectoty capacity)
tmp_dir="${out_dir}/tmp"
tmp_subdir="${tmp_dir}/tmp"
## set logfile (only for clusterjobs)
log="${out_dir}/log_${run}.txt"
## create all required directories
mkdir $out_dir
mkdir $tmp_dir
mkdir $tmp_subdir
## change to output directory
cd $out_dir
## run workflow (memory usage can be upt to 15Gb) ... 
cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/Haplotype_phasing.cwl" "${wrk_dir}/Haplotype_phasing.yml"
## .. thats why it is recommended to use a clusterjob:
bsub -W 48:00 -M 20000 -R "rusage[mem=20000]" -J "wf Haplotype phasing $run" \
-n 10 -R "span[ptile=10]" -oo $log -eo $log -env "all" \
"cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/Haplotype_phasing.cwl" "${wrk_dir}/Haplotype_phasing.yml""
```


### Option 2: starting at fastq-file
To use the second option, which starts from the fastq file, the workflow "full_processing.cwl" must be used, which is marked in yellow in the flowchart. This actually executes two sub-workflows, which on the one hand is formed by the "Haplotype_phasing.cwl" workflow mentioned in option 1, which is preceded by a second "alignment.cwl" workflow. This creates a bam file from fastq file and the methylation calls needed for the second workflow.
Option 2 therefore requires the following inputs:
* **nanopore.fastq**; fastqfile of nanopore data with additional index files pointing to the fast5 directory (can be created by nanopolish index)
* **reference_genome.fa**; reference genome with additional index file (.fai)
* **shortread.bam**; corresponding bam file of shortread SNVs.
* **shortread_snvs.vcf**; vcf-file containing SNVs in vcf format.

All these inputs are written with full paths directly into the "full_processing.yml" file, which can also be found in the "workflow" directory. In addition to the file inputs, three further string inputs are required. One is the name of the sample, which can be freely chosen by the user, the output format of the bam files. Since the output bam files are of little importance, the format "bam2bis" is recommended, in which the output bam files are converted into the wgbs-format, which can then be viewed in IGV, for example. The most valuable output is a tsv file, which contains the information on how many SNVs are assigned to which haplotype on a read. The reads can then be assigned to the haplotypes in downstream processes on the basis of their read-ID. The last input is the threads which should be used by nanopolish for calling mathylation. 8 threads are recommended.
The most important prerequisite for option 2, again, is that the provided reference genome is the same which was used for alingment of the shortread data.


#### Run option 2:
Option 1 can be used with cwltool. Further the machine has to support singularity images, as different tools are required.
The following code example shows how to execute the workflow on "odcf-worker01". Since the home directories have limited memory, we need to specify a path for temporary files, otherwise they will exceed the memory capacity. Furthermore, cwltool stores the created outputs in the directory in which it is executed. Therefore, it is recommended to create a seperate directory for this run.

```bash
## clone git repo
git clone https://github.com/CompEpigen/Nanopore_workflows.git
## set working directory
wrk_dir="${path_to_git_repo}/Nanopore_workflows/workflows"
## set run-name (sample name recommended)
run="sample_name"
## set output directory path
out_dir="${output_path}/${run}"
## and create subdirectories for temporary files (otherwise it will exceed home-diectoty capacity)
tmp_dir="${out_dir}/tmp"
tmp_subdir="${tmp_dir}/tmp"
## set logfile (only for clusterjobs)
log="${out_dir}/log_${run}.txt"
## create all required directories
mkdir $out_dir
mkdir $tmp_dir
mkdir $tmp_subdir
## change to output directory
cd $out_dir
## run workflow (memory usage can be upt to 15Gb ... )
cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/full_processing.cwl" "${wrk_dir}/full_processing.yml"
## .. thats why we recommend using a clusterjob:
bsub -W 25:00 -M 50000 -R "rusage[mem=50000]" -J "test wf full $run" \
-n 10 -R "span[ptile=10]" -oo $log -eo $log -env "all" \
"cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/full_processing.cwl" "${wrk_dir}/full_processing.yml""
```
