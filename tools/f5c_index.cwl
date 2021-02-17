cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: tleonardi/f5c:v0.6
    dockerOutputDirectory: /opt  
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_fastq)

baseCommand: ["f5c", "index"] 
inputs: 
  - id: in_fast5_dir
    type: Directory
    inputBinding:
      prefix: "-d"
      position: 1
  - id: input_fastq
    type: File
    inputBinding:
      position: 2
  - id: threads
    type: int
    inputBinding:
      position: 3
      prefix: "-t"        
outputs: 
  - id: input_fastq_indexed
    type: File
    secondaryFiles: 
      - .index
      - .index.gzi
      - .index.fai
      - .index.readdb
    outputBinding:
      glob: $(inputs.input_fastq.basename)
               