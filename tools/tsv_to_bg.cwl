cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}

baseCommand: ["python3", "../tools/reformat_tsv.py"] 
arguments:
  - valueFrom: $(inputs.sample_ID).methrix.bedgraph
    prefix: "-o"
inputs: 
  - id: tsv
    type: File
    inputBinding:
      prefix: "-f"
      position: 1
  - id: sample_ID
    type: string
outputs: 
  bedgraph:
    type: File
    outputBinding:
      glob: "*methrix.bedgraph"
