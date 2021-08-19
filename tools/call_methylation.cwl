cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
#  DockerRequirement:
 #   dockerPull: quay.io/biocontainers/nanopolish:0.13.2--h8cec615_5
  ShellCommandRequirement: {} 
hints:  
  SoftwareRequirement:
    packages:
      nanopolish:
        specs: 
          - https://anaconda.org/conda-forge/nanopolish
  
    
# nanopolish call-methylation -t 8 -r $fq -b $bam_sorted -g $ref > AS.methcall_final.tsv    
    
baseCommand: ["nanopolish", "call-methylation"] 
arguments:
  - valueFrom: ">"
    position: 5
  - valueFrom: $(inputs.sample_ID)_methcall.tsv
    position: 6  

inputs: 
  - id: sample_ID
    type: string
  - id: reference
    type: File
    inputBinding:
      prefix: "-g"
    secondaryFiles:
      - .fai      

  - id: fastq
    type: File
    inputBinding:
      prefix: "-r" 
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb  
      
  - id: threads
    type: string
    
  - id: bam_sorted_indexed
    type: File
    inputBinding:
      prefix: "-b" 
    secondaryFiles:
      - .bai  
      
outputs: 
  - id: methcall
    type: File
    outputBinding:
      glob: $(inputs.sample_ID)_methcall.tsv