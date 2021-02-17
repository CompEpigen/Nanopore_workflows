cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull:  biocontainers/sniffles:v1.0.11ds-1-deb_cv1

baseCommand: [sniffles] 
arguments:
  - valueFrom: $(inputs.sample_ID).tsv
    position: 1
    prefix: "-v" 
inputs: 
  - id: bam_sorted_indexed
    type: File
    inputBinding:
      prefix: "-m"
      position: 2
  - id: sample_ID
    type: string  
  - id: threads
    type: int
    inputBinding:
      position: 3
      prefix: "-t"     
outputs: 
  tsv:
    type: File
    outputBinding:
      glob: "*.tsv"