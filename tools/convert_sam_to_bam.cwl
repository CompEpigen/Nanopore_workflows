cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: kerstenbreuer/samtools:1.7
  ShellCommandRequirement: {}   
    
baseCommand: ["samtools", "view", "-bS"]
arguments:
  - valueFrom: ">"
    position: 2
  - valueFrom: $(inputs.sample_ID).bam
    position: 3  


inputs:
  - id: sample_ID
    type: string
  - id: sam
    type: File
    inputBinding:
      position: 1
 

outputs:
  bam:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).bam