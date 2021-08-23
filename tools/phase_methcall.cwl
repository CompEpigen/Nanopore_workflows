cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:  
    dockerPull: jmgarant/nanomethphase:latest
    dockerOutputDirectory: /opt 
  ShellCommandRequirement: {} 

baseCommand: ["nanomethphase", "phase"]


arguments:
  - valueFrom: $(inputs.sample_ID).phased_methcall
    prefix: "-o"
inputs: 
  - id: sample_ID
    type: string
  - id: methcall_indexed
    type: File
    inputBinding:
      prefix: "-mc"
    secondaryFiles: 
      - .tbi
  - id: bam_nanopore
    type: File
    inputBinding:
      prefix: "-b"
    secondaryFiles: 
      - .bai
  - id: vcf_shortread_phased
    type: File
    inputBinding:
      prefix: "-v"
  - id: format
    type: string
  - id: reference
    type: File
    inputBinding:
      prefix: "-r"
    secondaryFiles: 
      - .fai
outputs: 
  haplotype_one:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_methcall_NanoMethPhase_HP1_Converted2Bisulfite.bam
     #glob: $(inputs.sample_ID).phased_methcall_NanoMethPhase_HP1*
  haplotype_two:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_methcall_NanoMethPhase_HP2_Converted2Bisulfite.bam
      #glob: $(inputs.sample_ID).phased_methcall_NanoMethPhase_HP2*
  methcall_phased:
    type: File
    outputBinding:
      glob: $(inputs.sample_ID).phased_methcall_NanoMethPhase_HP1_HP2_PerReadInfo.tsv