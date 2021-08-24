cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
baseCommand: ["sh", "/home/m168r/projects/Nanopore_workflows/tools/prep_shortread_vcf_phasing.sh"]
arguments:
  - valueFrom: $(inputs.sample_ID).prepared_shortread.vcf
    prefix: "-o"
inputs: 
  - id: vcf_shortread
    type: File
    inputBinding:
      prefix: -i
    secondaryFiles: 
      - .tbi 
  - id: sample_ID
    type: string
outputs: 
  vcf_shortread_prepared:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).prepared_shortread.vcf