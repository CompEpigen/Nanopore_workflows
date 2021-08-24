cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: format
    type: string
  - id: methcall
    type: File
  - id: vcf_shortread
    type: File
    secondaryFiles:
      - .tbi
  - id: bam_shortread
    secondaryFiles:
      - .bai
    type: File
  - id: bam_nanopore
    type: File
    secondaryFiles:
      - .bai
  - id: reference
    type: File
    secondaryFiles:
      - .fai

steps: 
    - id: prepare_vcf_shortread
      run: "../tools/prep_shortread_vcf_phasing.cwl"
      in:
        - id: sample_ID
          source: sample_ID
        - id: vcf_shortread
          source: vcf_shortread
      out:
        - id: vcf_shortread_prepared
        
    - id: phase_vcf_shortread
      run: "../tools/phase_shortread_vcf.cwl"
      in:
        - id: sample_ID
          source: sample_ID
        - id: bam_shortread
          source: bam_shortread
        - id: reference
          source: reference
        - id: vcf_shortread_prepared
          #source: vcf_shortread
          source: prepare_vcf_shortread/vcf_shortread_prepared
      out:
        - id: vcf_shortread_phased 
   
    - id: process_methcall  
      run: "../tools/process_methcall.cwl"    
      in:
        - id: sample_ID
          source: sample_ID   
        - id: methcall_prepared
          source: methcall   
      out:
        - id: methcall_processed

    - id: index_methcall 
      run: "../tools/index_methcall.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: methcall_processed
          source: process_methcall/methcall_processed
      out:
        - id: methcall_indexed
  
    - id: phase_methcall 
      run: "../tools/phase_methcall.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: methcall_indexed
          source: index_methcall/methcall_indexed
        - id: bam_nanopore
          source: bam_nanopore
        - id: vcf_shortread_phased
          source: phase_vcf_shortread/vcf_shortread_phased
        - id: format
          source: format
        - id: reference
          source: reference
      out:
        - id: haplotype_one
        - id: haplotype_two 
        - id: methcall_phased

    - id: index_haplotype_one
      run: "../tools/samtools_index.cwl"    
      in:     
        - id: bam_sorted
          source: phase_methcall/haplotype_one
      out:
        - id: bam_sorted_indexed

    - id: index_haplotype_two
      run: "../tools/samtools_index.cwl"    
      in:     
        - id: bam_sorted
          source: phase_methcall/haplotype_two
      out:
        - id: bam_sorted_indexed

     
outputs: 
  - id: vcf_shortread_phased
    type: File
    outputSource: phase_vcf_shortread/vcf_shortread_phased
  - id: haplotype_one
    type: File
    outputSource: phase_methcall/haplotype_one
  - id: haplotype_two 
    type: File
    outputSource: phase_methcall/haplotype_two
  - id: methcall_phased
    type: File
    outputSource: phase_methcall/methcall_phased
  - id: haplotype_one_indexed
    type: File
    outputSource: index_haplotype_one/bam_sorted_indexed
  - id: haplotype_two_indexed
    type: File
    outputSource: index_haplotype_two/bam_sorted_indexed
