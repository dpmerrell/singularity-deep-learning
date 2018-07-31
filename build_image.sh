#!/bin/bash

# Make sure the requisite NVIDIA
# installers are in this directory,
# and set the variables below.
# Then 
#
# chmod u+x build_image.sh
# sudo ./build_image.sh
#
# to build a Singularity image with
# tensorflow, keras, and sklearn installed.

######################################
# Set versions of things to install
######################################

# NVIDIA driver version
NVIDIA_VERSION="390.77"
NVIDIA_MAJOR_VERSION="390"

# CUDA version
CUDA_VERSION="9.0.176_384.81"

# CUDNN version
CUDNN_VERSION="9.0-linux-x64-v7"

# TensorFlow version
TENSORFLOW_VERSION="1.5"

# HDF5 version
HDF5_VERSION="1.10.2-Std-centos7-x86_64-shared_64"

######################################
# Set some other options
######################################

# Name of image recipe file:
DEFFILE_NAME="tf_keras_nv390.def"

# Name of singularity image:
IMAGE_NAME="tf_keras_nv390.simg"

# Will this image be writable?
WRITABLE=""
#WRITABLE="--writable"

######################################
# Fill the template
######################################

sed "s/__NVIDIA_VERSION__/$NVIDIA_VERSION/g" deffile_template > $DEFFILE_NAME 
sed -i "s/__CUDA_VERSION__/$CUDA_VERSION/g" $DEFFILE_NAME
sed -i "s/__CUDNN_VERSION__/$CUDNN_VERSION/g" $DEFFILE_NAME
sed -i "s/__NVIDIA_MV__/$NVIDIA_MAJOR_VERSION/g" $DEFFILE_NAME
sed -i "s/__TENSORFLOW_VERSION__/$TENSORFLOW_VERSION/g" $DEFFILE_NAME
sed -i "s/__HDF5_VERSION__/$HDF5_VERSION/g" $DEFFILE_NAME


######################################
# Build the image
######################################

singularity build $WRITABLE $IMAGE_NAME $DEFFILE_NAME 

