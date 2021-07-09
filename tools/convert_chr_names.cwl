cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: kkimler/r4.0_tca
    
baseCommand: ["Rscript", "/home/m168r/projects/Nanopore_workflows/tools/convert_chr_names.R"]
arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread_conv.vcf
    porefix: o
inputs: 
  - id: sample_ID
    type: string
  - id: phased_vcf
    type: File
    inputBinding:
      prefix: i
outputs: 
  bam_nanopore_prepared:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_shortread_conv.vcf