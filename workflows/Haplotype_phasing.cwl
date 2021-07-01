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
      
        
outputs: 
  - id: prepared_methcall
    type: File
    outputSource: prepare_methcall_file/prepared_methcall
  - id: vcf_short_prepared
    type: File
    outputSource: prepare_shortread_vcf/vcf_short_prepared
