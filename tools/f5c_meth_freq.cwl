cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: tleonardi/f5c:v0.6

baseCommand: ["f5c", "meth-freq"] 
arguments:
  - valueFrom: $(inputs.sample_ID)_meth_freq.csv
    prefix: "-o"
inputs: 
  - id: meth_calls_tsv
    type: File
    inputBinding:
      prefix: "-i"
      position: 1
  - id: sample_ID
    type: string
outputs: 
  meth_freq_tsv:
    type: File
    outputBinding:
      glob: "*_meth_freq.csv"