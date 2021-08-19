cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: threads
    type: string
  - id: fastq
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb
  - id: reference
    type: File
    secondaryFiles:
      - .fai

steps: 
    - id: alignment 
      run: "../tools/minimap_alignment.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: fastq
          source: fastq
        - id: reference
          source: reference         
      out:
        - id: sam
    - id: sam_to_bam 
      run: "../tools/convert_sam_to_bam.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: sam
          source: alignment/sam
      out:
        - id: bam
    - id: sort_bam
      run: "../tools/samtools_sort.cwl"    
      in:     
        - id: bam_unsorted
          source: sam_to_bam/bam          
      out:
        - id: bam_sorted

    - id: index_bam
      run: "../tools/samtools_index.cwl"    
      in:     
        - id: bam_sorted
          source: sort_bam/bam_sorted           
      out:
        - id: bam_sorted_indexed
        
    - id: call_methylation
      run: "../tools/call_methylation.cwl"    
      in:   
        - id: sample_ID
          source: sample_ID       
        - id: fastq
          source: fastq
        - id: reference
          source: reference 
        - id: bam_sorted_indexed
          source: index_bam/bam_sorted_indexed
        - id: threads
          source: threads
      out:
        - id: methcall
     
outputs: 

  - id: bam_nanopore
    type: File
    outputSource: index_bam/bam_sorted_indexed
    secondaryFiles:
      - .bai
  - id: methcall
    type: File
    outputSource: call_methylation/methcall
  - id: sam
    type: File
    outputSource: alignment/sam