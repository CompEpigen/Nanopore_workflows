cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: quay.io/biocontainers/whatshap:1.1--py36hae55d0a_1

baseCommand: ["whatshap", "phase", "--ignore-read-groups"]

arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread.vcf
    prefix: "-o"
inputs: 
  - id: reference
    type: File
    secondaryFiles: 
      - .fai
    inputBinding:
      prefix: -r
  - id: sample_ID
    type: string
  - id: bam_shortread
    type: File
    secondaryFiles: 
      - .bai
    inputBinding:
      position: 2
  - id: vcf_shortread_prepared
    type: File   
    inputBinding:
      position: 1
outputs: 
  vcf_shortread_phased:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_shortread.vcf