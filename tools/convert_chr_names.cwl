cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: r-base:4.0.0
    
baseCommand: ["Rscript", "/home/m168r/projects/Nanopore_workflows/tools/test.R"]
arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread_conv.vcf
    prefix: o
inputs: 
  - id: sample_ID
    type: string
  - id: phased_vcf
    type: File
    inputBinding:
      prefix: i
outputs: 
  vcf_shortread_conv:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_shortread_conv.vcf