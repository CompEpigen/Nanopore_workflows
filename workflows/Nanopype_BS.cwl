cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: sequencing_summary
    type: File
  - id: basecalled_fastq
    type: File[]
  - id: in_fast5_dir
    type: Directory
  - id: reference
    type: File
    secondaryFiles:
      - .fai


steps: 
    - id: pycoqc  
      run: "../tools/pycoQC.cwl"    
      in:
        - id: sample_ID
          source: sample_ID      
        - id: sequencing_summary
          source: sequencing_summary
      out:
        - id: pycoqc_output_html
      
    - id: merge_fastqs
      run: "../tools/merge_fasta.cwl"
      in: 
        - id: sample_ID
          source: sample_ID       
        - id: basecalled_fastq
          source: basecalled_fastq
      out:
        - id: merged_fastq

    - id: f5c_index
      run: "../tools/f5c_index.cwl"
      in:
        - id: in_fast5_dir
          source: in_fast5_dir
        - id: input_fastq
          source: merge_fastqs/merged_fastq
      out:
        - id: input_fastq_indexed   

    - id: ngmlr_align
      run: "../tools/ngmlr_align.cwl"
      in:
        - id: reference
          source: reference
        - id: input_fastq
          source: merge_fastqs/merged_fastq
      out: 
        - id: bam #        

    - id: samtools_sort
      run: "../tools/samtools_sort.cwl"
      in:
        - id: bam_unsorted
          source: ngmlr_align/bam
      out:
        - id: bam_sorted 

    - id: samtools_index
      run: "../tools/samtools_index.cwl"
      in:
        - id: bam_sorted
          source: samtools_sort/bam_sorted
      out:
        - id: bam_sorted_indexed 

    - id: call_meth
      run: "../tools/f5c_call_methylation.cwl"
      in:
        - id: sample_ID
          source: sample_ID       
        - id: reference
          source: reference
        - id: input_fastq_indexed
          source: f5c_index/input_fastq_indexed
        - id: bam_sorted_indexed
          source: samtools_index/bam_sorted_indexed
      out: 
        - id: meth_calls_tsv  

    - id: calc_freq
      run: "../tools/f5c_meth_freq.cwl"
      in:
        - id: sample_ID
          source: sample_ID       
        - id: meth_calls_tsv
          source: call_meth/meth_calls_tsv
      out:
        - id: meth_freq_tsv

    - id: call_vars
      run: "../tools/sniffles_call_vars.cwl"
      in: 
        - id: sample_ID
          source: sample_ID       
        - id: bam_sorted_indexed
          source: samtools_index/bam_sorted_indexed
      out:
        - id: tsv

    - id: tsv_to_bg
      run: "../tools/tsv_to_bg.cwl"
      in:
        - id: sample_ID
          source: sample_ID        
        - id: tsv
          source: call_vars/tsv
      out:
        - id: bedgraph

outputs: 
  - id: merged_fastq
    type: File
    outputSource: merge_fastqs/merged_fastq
  - id: pycoqc_output
    type: File
    outputSource: pycoqc/pycoqc_output_html                     
  - id: bam_sorted_indexed
    type: File
    outputSource: samtools_index/bam_sorted_indexed   
  - id: meth_calls_tsv
    type: File
    outputSource: call_meth/meth_calls_tsv  
  - id: meth_freq_tsv
    type: File
    outputSource: calc_freq/meth_freq_tsv 
  - id: call_vars_tsv
    type: File
    outputSource: call_vars/tsv 
  - id: bedgraph
    type: File
    outputSource: tsv_to_bg/bedgraph         

