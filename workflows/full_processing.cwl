cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: threads
    type: string
  - id: format
    type: string
  - id: fastq
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb    
  - id: reference
    type: File
    secondaryFiles:
      - .fai
  - id: vcf_shortread
    type: File
    secondaryFiles:
      - .tbi    
  - id: bam_shortread
    type: File
    secondaryFiles:
      - .bai    
      
steps: 
    - id: wf_alignment 
      run: "./alignment.cwl"    
      in:
        - id: sample_ID
          source: sample_ID 
        - id: threads
          source: threads
        - id: fastq
          source: fastq
        - id: reference
          source: reference         
      out:
        - id: bam_nanopore
        - id: methcall
        - id: sam
        
    - id: wf_phasing
      run: "./Haplotype_phasing.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: format
          source: format
        - id: methcall
          source: wf_alignment/methcall
        - id: vcf_shortread
          source: vcf_shortread
        - id: bam_shortread
          source: bam_shortread          
        - id: bam_nanopore
          source: wf_alignment/bam_nanopore
        - id: reference
          source: reference
      out:
        - id: vcf_shortread_phased
        - id: haplotype_one
        - id: haplotype_two 
        - id: methcall_phased
        - id: haplotype_one_indexed
        - id: haplotype_two_indexed

     
outputs: 

  - id: bam_nanopore
    type: File
    outputSource: wf_alignment/bam_nanopore
  - id: methcall
    type: File
    outputSource: wf_alignment/methcall
  - id: sam
    type: File
    outputSource: wf_alignment/sam
  - id: vcf_shortread_phased
    type: File
    outputSource: wf_phasing/vcf_shortread_phased
  - id: haplotype_one
    type: File
    outputSource: wf_phasing/haplotype_one
  - id: haplotype_two 
    type: File
    outputSource: wf_phasing/haplotype_two
  - id: methcall_phased
    type: File
    outputSource: wf_phasing/methcall_phased
  - id: haplotype_one_indexed
    type: File
    outputSource: wf_phasing/haplotype_one_indexed
  - id: haplotype_two_indexed
    type: File
    outputSource: wf_phasing/haplotype_two_indexed  