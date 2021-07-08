cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: raw_methcall
    type: File
  - id: vcf_short_raw
    type: File
  - id: bam_shortread
    type: File
  - id: ref_shortread
    type: File

steps: 
    - id: prepare_methcall_file  
      run: "../tools/prep_methcall_phasing.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: raw_methcall
          source: raw_methcall
      out:
        - id: prepared_methcall
      
    - id: prepare_shortread_vcf
      run: "../tools/prep_shortread_vcf_phasing.cwl"
      in:
        - id: sample_ID
          source: sample_ID
        - id: vcf_short_raw
          source: vcf_short_raw
      out:
        - id: vcf_short_prepared
        
    - id: phase_shortread_vcf
      run: "../tools/phase_shortread_vcf.cwl"
      in:
        - id: sample_ID
          source: sample_ID
        - id: bam_shortread
          source: bam_shortread
        - id: ref_shortread
          source: ref_shortread
        - id: vcf_short_prepared
          source: prepare_shortread_vcf/vcf_short_prepared
      out:
        - id: vcf_short_phased    
        
outputs: 
  - id: prepared_methcall
    type: File
    outputSource: prepare_methcall_file/prepared_methcall
  - id: vcf_short_prepared
    type: File
    outputSource: prepare_shortread_vcf/vcf_short_prepared
  - id: vcf_short_phased
    type: File
    outputSource: phase_shortread_vcf/vcf_short_phased
