while getopts i:o: flag
do
    case "${flag}" in
        v) vcf=${OPTARG};;
        o) out=${OPTARG};;
        r) ref=${OPTARG};;
        b) bam=${OPTARG};;
    esac
done


whatshap phase --ignore-read-groups --reference $ref -o $out $vcf $bam

