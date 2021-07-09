cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    #dockerPull: ken01nn/whatshap:0.18   
    dockerPull: quay.io/biocontainers/whatshap:1.1--py36hae55d0a_1
baseCommand: ["whatshap", "phase", "--ignore-read-groups"]
arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread.vcf
    prefix: o
inputs: 
  - id: ref_shortread
    type: File
    inputBinding:
      prefix: --reference
  - id: sample_ID
    type: string
  - id: bam_shortread
    type: File
    inputBinding:
      position: 4
  - id: vcf_short_prepared
    type: File
    inputBinding:
      position: 3
outputs: 
  vcf_short_phased:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_shortread.vcf