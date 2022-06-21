#! /bin/bash

echo "Diagnosing input dataset..."
echo "Found $(ls dataset_out/images/*/*.jpg | wc -l) images."
echo "Found $(ls dataset_out/labels/*/*.txt | wc -l) labels."
echo "Found $(find dataset_out -name '*.txt' -size 0 | wc -l) empty labels."
echo "WARNING: by default, I will not include nonlabelled images in your output data."

echo "Diagnosing converted dataset..."
echo "Found $(ls dataset_out/images/*/*.jpg | wc -l) images."
echo "Found $(ls dataset_out/labels/*/*.txt | wc -l) labels."
echo "Found $(find dataset_out -name '*.txt' -size 0 | wc -l) empty labels."
