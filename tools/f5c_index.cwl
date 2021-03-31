cwlVersion: v1.0
class: CommandLineTool
#hints:
#  SoftwareRequirement:
#    packages:
#    - package: f5c
#      specs:
#        - https://anaconda.org/bioconda/f5c
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_fastq)

baseCommand: ["/home/mayerma/f5c-v0.6/f5c_x86_64_linux", "index"] 
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
               
