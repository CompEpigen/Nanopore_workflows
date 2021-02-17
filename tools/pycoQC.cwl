cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: nanozoo/pycoqc

baseCommand: ["pycoQC"] 
arguments:
  - valueFrom: $(inputs.sample_ID)_pycoQC_output.html
    prefix: "-o"
inputs: 
  - id: sample_ID
    type: string
  - id: sequencing_summary
    type: File
    inputBinding:
      position: 1
      prefix: "-f"
outputs: 
  - id: pycoqc_output_html
    type: File
    outputBinding:
      glob: $(inputs.sample_ID)_pycoQC_output.html
