cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: cyverse/ngmlr:0.2.7
    dockerOutputDirectory: /opt  
  InitialWorkDirRequirement:
    listing:
      - $(inputs.reference)  
      - $(inputs.input_fastq)   

baseCommand: ["ngmlr", "-x", "ont"] 
arguments:
  - valueFrom: $(inputs.input_fastq.basename.split('.').slice(0, -1).join('.')).bam
    prefix: "-o"
    position: 3

inputs: 
  - id: reference
    type: File
    inputBinding:
      prefix: "-r"
      position: 1

  - id: input_fastq
    type: File
    inputBinding:
      prefix: "-q"
      position: 2   
  - id: threads
    type: int
    inputBinding:
     prefix: "-t"
     position: 3 
outputs: 
  - id: bam
    type: File
    outputBinding:
      glob: "*.bam"