cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
baseCommand: ["sh", "/home/m168r/cwl/tools/insert_missing_column.sh"]
arguments:
  - valueFrom: $(inputs.sample_ID).preparedMethcall.tsv
    prefix: "-o"
inputs: 
  - id: raw_methcall
    type: File
    inputBinding:
      prefix: -i
  - id: sample_ID
    type: string
outputs: 
  preparedMC:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).preparedMethcall.tsv
   

  
      
 
      
      
      
