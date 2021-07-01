while getopts i:o: flag
do
    case "${flag}" in
        i) in=${OPTARG};;
        o) out=${OPTARG};;
    esac
done

cut -f1 $in | paste - $in > $out