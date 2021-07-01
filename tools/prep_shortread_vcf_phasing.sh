while getopts i:o: flag
do
    case "${flag}" in
        i) in=${OPTARG};;
        o) out=${OPTARG};;
    esac
done

gunzip -c $in | cut -f1,2,3,4,5,6,7,8,9,10 - > $out