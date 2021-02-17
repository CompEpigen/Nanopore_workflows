cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}

baseCommand: ["cat"] 
arguments:
  - valueFrom: ">"
    position: 2
    shellQuote: False
  - valueFrom: $(inputs.sample_ID)_merged.fastq 
    position: 3
inputs: 
  - id: sample_ID
    type: string
  - id: basecalled_fastq
    type: File[]
    inputBinding:
      position: 1
outputs: 
  - id: merged_fastq
    type: File
    outputBinding:
      glob: $(inputs.sample_ID)_merged.fastq 