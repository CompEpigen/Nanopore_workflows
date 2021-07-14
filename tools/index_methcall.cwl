cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: biocontainers/tabix:v1.9-11-deb_cv1
    dockerOutputDirectory: /opt
  ShellCommandRequirement: {} 
#baseCommand: ["sh", "/scratch/marco/Nanopore_workflows/tools/index_methcall.sh"]

baseCommand: ["cat"]

arguments:
  - valueFrom: "|"
    position: 2
  - valueFrom: "bgzip"
    position: 3
  - valueFrom: ">"
    position: 4
  - valueFrom: $(inputs.sample_ID).indexed_methcall.tsv
    position: 5
  - valueFrom: "&&"
    position: 6
  - valueFrom: "tabix"
    position: 7
  - valueFrom: "-p"
    position: 8
  - valueFrom: "bed"
    position: 9
  - valueFrom: $(inputs.sample_ID).indexed_methcall.tsv
    position: 10
inputs: 
  - id: processed_methcall
    type: File
    inputBinding:
      #prefix: -i
      position: 1
  - id: sample_ID
    type: string
outputs: 
  indexed_methcall:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).indexed_methcall.tsv