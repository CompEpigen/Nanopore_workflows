cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
baseCommand: ["sh", "/home/m168r/projects/Nanopore_workflows/tools/prep_methcall_phasing.sh"]
arguments:
  - valueFrom: $(inputs.sample_ID).prepared_methcall.tsv
    prefix: "-o"
inputs: 
  - id: methcall
    type: File
    inputBinding:
      prefix: -i
  - id: sample_ID
    type: string
outputs: 
  methcall_prepared:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).prepared_methcall.tsv
   

  
      
 
      
      
      
