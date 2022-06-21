#! /bin/bash



## 0. Flatten the original dataset to a folder of symlinks
mkdir flatten || rm flatten/*
ln -s $PWD/dataset_in/images/*/*.jpg flatten/
ln -s $PWD/dataset_in/labels/*/*.txt flatten/



## 1. Assert you have all the images+labels you're supposed to
echo 'Comparing your files to those in text_files/index_all_external.txt...'
cd text_files
    # All existing images and labels to a file
    ls ../flatten/ > index_all.txt
    sort -o index_all.txt index_all.txt

    # Compare with external file
    diff index_all.txt index_all_external.txt | tail -n 5
cd ..



## 2. Assert that all IMAGES are in the splits
echo 'Comparing images in the requested splits with source dataset...'
cd text_files
    # Create a list with all images -not labels- from the dataset
    ls ../flatten/*.jpg  | sed 's:../flatten/::g' > index_images.txt
    sort -o index_images.txt index_images.txt

    # Create a list with all images from the splits text files
    cat ../splits/* > index_images_splits.txt
    sort -o index_images_splits.txt index_images_splits.txt
cd ..
#
diff text_files/{index_images.txt,index_images_splits.txt} | tail -n 5



## 3. Create destination dataset
echo 'Creating output dataset folder structure...'
rm -rf dataset_out/* 
mkdir -p dataset_out/{images,labels}/{train,test,val}
#
cd flatten/
    echo 'Copying images...'
    xargs -a ../splits/train.txt cp -t ../dataset_out/images/train
    xargs -a ../splits/test.txt  cp -t ../dataset_out/images/test
    xargs -a ../splits/val.txt   cp -t ../dataset_out/images/val
    
    echo 'Copying labels...'
    cat ../splits/train.txt | sed 's/.jpg/.txt/g' | xargs cp -t ../dataset_out/labels/train  
    cat ../splits/test.txt  | sed 's/.jpg/.txt/g' | xargs cp -t ../dataset_out/labels/test  
    cat ../splits/val.txt   | sed 's/.jpg/.txt/g' | xargs cp -t ../dataset_out/labels/val 
cd ..
#
echo 'Copying dataset.yaml...'
cp dataset_in/dataset.yaml dataset_out



## 4. Find the images that have no labels and remove them
echo 'Removing images with no labels...'
cd dataset_out 
    find . -name '*.txt' -size 0 | sed 's/txt/jpg/g' | sed 's/labels/images/g' | xargs rm
    find . -name '*.txt' -size 0 | xargs rm                    
cd ..


echo 'All done!'
