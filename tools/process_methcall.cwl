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
  - valueFrom: "|"
    position: 2
  - valueFrom: "sort"
    position: 3
  - valueFrom: "-k1,1"
    position: 4
  - valueFrom: "-k2,2n"
    position: 5
  - valueFrom: "-k3,3n"
    position: 6
  - valueFrom: ">"
    position: 7
  - valueFrom: $(inputs.sample_ID).processed_methcall.tsv
    position: 8

inputs: 
  - id: sample_ID
    type: string
  - id: methcall_prepared
    type: File
    inputBinding:
      prefix: "-mc"
outputs: 
  methcall_processed:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).processed_methcall.tsv