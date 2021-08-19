cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: nanozoo/minimap2:2.20--cb1bdd4
  ShellCommandRequirement: {}  
baseCommand: ["minimap2", "-a"] 
arguments:
  - valueFrom: ">"
    position: 3
  - valueFrom: $(inputs.sample_ID).sam
    position: 4  



inputs: 
  - id: sample_ID
    type: string
    
  - id: reference
    type: File
    inputBinding:
      position: 1

  - id: fastq
    type: File
    inputBinding:
      position: 2  
outputs: 
  - id: sam
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).sam