cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: jmgarant/nanomethphase:latest
    dockerOutputDirectory: /opt 
  ShellCommandRequirement: {} 

baseCommand: ["nanomethphase", "methyl_call_processor"]

arguments:
  - valueFrom: ">"
    position: 2
  - valueFrom: $(inputs.sample_ID).processed_methcall.tsv
    position: 3
inputs: 
  - id: sample_ID
    type: string
  - id: prepared_methcall
    type: File
    inputBinding:
      prefix: "-mc"
outputs: 
  vcf_short_phased:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).processed_methcall.tsv