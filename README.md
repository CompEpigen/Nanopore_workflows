# Nanopore_workflows

## Workflow: Haplotype_phasing

The Haplotype_phasing workflow is intended to assign each read of an input file to a haplotype of diploid origin.
The core of that process is formed by the NanoMethPhase tool which was developed by [Akbari et al. in 2021](https://doi.org/10.1186/s13059-021-02283-5).
The workflow can be used in two ways, which differ in their starting points. On the one hand, you can start with already alinged bam-files, but also further upstream with fastq-files. Depending on this, different workflows have to be used, the structure of which is described below.

![alt text](https://github.com/CompEpigen/Nanopore_workflows/blob/main/wf_flowchart.png)


### Required input



