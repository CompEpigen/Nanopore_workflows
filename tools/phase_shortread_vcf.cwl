cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull:  quay.io/biocontainers/whatshap:1.1-1
    
baseCommand: ["whatshap", "phase", "--ignore-read-groups"]
arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread.vcf
    position: 2
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