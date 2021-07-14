cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: biocontainers/tabix:v1.9-11-deb_cv1
    dockerOutputDirectory: /opt
  ShellCommandRequirement: {} 
baseCommand: ["cat"]

arguments:
  - valueFrom: "|"
    position: 2
  - valueFrom: "bgzip"
    position: 3
  - valueFrom: ">"
    position: 4
  - valueFrom: $(inputs.sample_ID).indexed_methcall.tsv.gz
    position: 5
  - valueFrom: "&&"
    position: 6
  - valueFrom: "tabix"
    position: 7
  - valueFrom: "-p"
    position: 8
  - valueFrom: "bed"
    position: 9
  - valueFrom: $(inputs.sample_ID).indexed_methcall.tsv.gz
    position: 10
inputs: 
  - id: methcall_processed
    type: File
    inputBinding:
      #prefix: -i
      position: 1
  - id: sample_ID
    type: string
outputs: 
  methcall_indexed:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).indexed_methcall.tsv.gz
    secondaryFiles: 
      - .tbi