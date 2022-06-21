echo "Diagnosing dataset conversion..."
echo "Found $(ls dataset_out/images/*/*.jpg | wc -l) images."
echo "Found $(ls dataset_out/labels/*/*.txt | wc -l) labels."
echo "Found $(find dataset_out -name '*.txt' -size 0 | wc -l) empty labels."
