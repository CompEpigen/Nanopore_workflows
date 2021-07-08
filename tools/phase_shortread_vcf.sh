while getopts i:o: flag
do
    case "${flag}" in
        i) prep_vcf=${OPTARG};;
        o) out=${OPTARG};;
        b) bam=${OPTARG};;
        r) ref=${OPTARG};;
    esac
done

whatshap phase --ignore-read-groups --reference $ref -o $out $prep_vcf $bam