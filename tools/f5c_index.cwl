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

#  - id: index
#    type: File
#    outputBinding:
#      glob: "*.index"
#  - id: index_gzi
#    type: File
#    outputBinding:
#      glob: "*.index.gzi"
#  - id: index_fai
#    type: File
#    outputBinding:
#      glob: "*.index.fai"
#  - id: index_readdb
#    type: File
#    outputBinding:
#      glob: "*.index.readdb"                  