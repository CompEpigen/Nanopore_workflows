cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: tleonardi/f5c:v0.6
    dockerOutputDirectory: /opt  
  ShellCommandRequirement: {}    

baseCommand: ["f5c", "call-methylation", "--disable-cuda=yes"] 
arguments:
  - valueFrom: ">"
    position: 5
  - valueFrom: $(inputs.sample_ID)_meth_call.csv
    position: 6    
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 1
      prefix: "-g"    
  - id: input_fastq_indexed
    type: File
    inputBinding:
      position: 2
      prefix: "-r" 
  - id: bam_sorted_indexed
    type: File 
    inputBinding:
      position: 3
      prefix: "-b"    
  - id: sample_ID
    type: string  
  - id: threads
    type: int
    inputBinding:
      position: 4
      prefix: "-t"      
outputs: 
  meth_calls_tsv:
    type: File
    outputBinding:
      glob: "*_meth_call.csv"