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

steps: 
    - id: prepare_methcall_file  
      run: "../tools/prep_methcall_phasing.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: raw_methcall
          source: raw_methcall
      out:
        - id: preparedMC
      

outputs: 
  - id: preparedMC
    type: File
    outputSource: prepare_methcall_file/preparedMC

