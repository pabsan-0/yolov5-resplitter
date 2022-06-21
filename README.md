## Yolov5 dataset reassembler

This repo holds code to reconstruct an object detection dataset in (or *to*) yolov5 format by specifying the images that must go in each split. Assumes you're converting from Yolov5 to Yolov5. Hold tight and modify the scripts if your use-case is different.

### Usage

- Symlink `dataset_in` to point your data: `ln -sf <your_dataset_path> dataset_in`
- Flatten your dataset to a dir with symlinks to all your images and labels with `bash flattener.sh` 
- Define your target splits by placing your custom `train.txt test.txt val.txt` in `splits/`
    - These contain filenames (no paths) to all **images** you'll want in each split
    - Labels are autohandled if their name is equal to their image minus extension (for instance `img.txt img.jpg`)
- Assemble your new dataset with `bash assembler.sh`
    - Optionally provide `text_files/index_all_external.txt` to assert you have all your files
    - By default, images with no labels will **not** be used for the new dataset
    - Running this script will **copy** your data, so make sure you have enough disk space
- Retrieve your Yolov5 dataset in `dataset_out`

    ```
    dataset_out/
    ├── dataset.yaml
    ├── images
    │   ├── test
    │   ├── train
    │   └── val
    └── labels
        ├── test
        ├── train
        └── val
    ```
