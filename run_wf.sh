## run single tool
wrk_dir="/home/m168r/projects/Nanopore_workflows/tools"
run="NA12878_chr20"
out_dir="/icgc/dkfzlsdf/analysis/OE0219_projects/nanopore/NanoMethPhase/results_per_pid/${run}"
tmp_dir="${out_dir}/tmp"
tmp_subdir="${tmp_dir}/tmp"
log="${out_dir}/log_${run}.txt"
mkdir $out_dir
mkdir $tmp_dir
mkdir $tmp_subdir

cd $out_dir

cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/index_methcall.cwl" "${wrk_dir}/test_wf.yml"

bsub -W 5:00 -M 20000 -R "rusage[mem=20000]" -J "phase mc chr20 $run" \
-n 10 -R "span[ptile=10]" -oo $log -eo $log -env "all" \
"cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/phase_methcall.cwl" "${wrk_dir}/test_wf.yml""





## run full processing
wrk_dir="/home/m168r/projects/Nanopore_workflows/workflows"
run="AR_final"
out_dir="/icgc/dkfzlsdf/analysis/OE0219_projects/nanopore/NanoMethPhase/results_per_pid/${run}"
tmp_dir="${out_dir}/tmp"
tmp_subdir="${tmp_dir}/tmp"
log="${out_dir}/log_${run}.txt"
mkdir $out_dir
mkdir $tmp_dir
mkdir $tmp_subdir

cd $out_dir

bsub -W 25:00 -M 50000 -R "rusage[mem=50000]" -J "test wf full $run" \
-n 10 -R "span[ptile=10]" -oo $log -eo $log -env "all" \
"cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/full_processing.cwl" "${wrk_dir}/full_processing.yml""



## run haplotype_phasing
wrk_dir="/home/m168r/projects/Nanopore_workflows/workflows"
run="AR_test_dataset"
out_dir="/icgc/dkfzlsdf/analysis/OE0219_projects/nanopore/NanoMethPhase/results_per_pid/${run}"
tmp_dir="${out_dir}/tmp"
tmp_subdir="${tmp_dir}/tmp"
log="${out_dir}/log_${run}.txt"
mkdir $out_dir
mkdir $tmp_dir
mkdir $tmp_subdir

cd $out_dir

bsub -W 25:00 -M 50000 -R "rusage[mem=50000]" -J "test wf Haplotype phasing $run" \
-n 10 -R "span[ptile=10]" -oo $log -eo $log -env "all" \
"cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/Haplotype_phasing.cwl" "${wrk_dir}/Haplotype_phasing.yml""



cwltool --singularity --tmp-outdir-prefix $tmp_subdir "${wrk_dir}/Haplotype_phasing.cwl" "${wrk_dir}/Haplotype_phasing.yml"




