cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: quay.io/biocontainers/whatshap:1.1--py36hae55d0a_1

baseCommand: ["whatshap", "phase", "--ignore-read-groups"]
#baseCommand: ["sh", "/scratch/marco/Nanopore_workflows/tools/runWhatshap.sh"]
#baseCommand: ["sh", "/scratch/marco/Nanopore_workflows/tools/prep_methcall_phasing.sh"]

arguments:
  - valueFrom: $(inputs.sample_ID).phased_shortread.vcf
    prefix: "-o"
inputs: 
  - id: ref_shortread
    type: File
    inputBinding:
      #prefix: -r
      prefix: --reference
  - id: sample_ID
    type: string
  - id: bam_shortread
    type: File
    inputBinding:
      #prefix: -b
      position: 2
  - id: vcf_short_prepared
    type: File
    inputBinding:
      #prefix: -v
      position: 1
outputs: 
  vcf_short_phased:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_shortread.vcf