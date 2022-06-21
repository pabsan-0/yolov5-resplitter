#! /bin/bash


## 0. Flatten the original dataset to a folder of symlinks
mkdir flatten || rm flatten/*
ln -s $PWD/dataset_in/images/*/*.jpg flatten/
ln -s $PWD/dataset_in/labels/*/*.txt flatten/



