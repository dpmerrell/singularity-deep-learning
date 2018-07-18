# A Singularity Container Recipe for Deep Learning

## Intended Purpose

This repository contains the recipe for a [Singularity](https://singularity.lbl.gov/) container equipped with 
[Scikit-Learn](http://scikit-learn.org/stable/), 
[TensorFlow](https://tensorflow.org/),
and [Keras](https://keras.io/).
With it, you can harness the power of GPUs on remote servers where you have limited permissions!

It came about because I wanted to do some deep learning tasks on GPU-equipped servers with inconsistent environments.

It took me quite a bit of time to figure out how to do this.
I had to dig through repositories, blog posts, and web forums.
I hope this repository helps other people figure things out faster than I did.
The script hasn't been tested across systems, etc., but it may be useful regardless.

## Usage

Follow these steps to build the Singularity image:

* Go to a host where you have root access (e.g., your personal computer). Clone this repository and `mv` into it.

* Make sure you have [Singularity installed](http://singularity.lbl.gov/docs-installation). If you're on a Mac, this may entail setting up a [Vagrant](https://www.vagrantup.com/) virtual machine.

* Download the following NVIDIA requirements and **move them to this directory**:

    - The CUDA toolkit ([version 9.0 tends to be a safe choice, as of this writing](https://developer.nvidia.com/cuda-90-download-archive)).
      The file suffix should be ".run".
    - The cuDNN library ([version 7.0 is compatible with CUDA 9.0](https://developer.nvidia.com/cudnn)).
      The file suffix should be ".tgz".

* Set the variables in the `build_image.sh` script.

    - NVIDIA driver version. 384.111 may be a safe choice. It needs to be compatible with the CUDA installer, _and_ with the GPUs you'll be using. 
      These drivers will be installed via `apt-get` from within the container during construction.
    - CUDA version (get it from the name of the installer: `cuda_<version>_linux.run` )
    - cuDNN version (get it from the name of the installer: `cudnn-<version>.tgz` )

* Run the script as root: `sudo bash build_image.sh`. Then relax. It takes a little bit of time to build the image.

* `scp` the resulting image file to a host you want to work on---one that has Singularity installed, **and** has TensorFlow-capable GPUs.

* Test your image, e.g., by running `singularity exec --nv <your image> python3 keras_mnist_test.py`

If all goes well, you should see something like:

```
$ singularity exec --nv tf_keras.simg python3 keras_mnist_test.py 
Using TensorFlow backend.
60000 train samples
10000 test samples
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
dense_1 (Dense)              (None, 512)               401920    
_________________________________________________________________
dropout_1 (Dropout)          (None, 512)               0         
_________________________________________________________________
dense_2 (Dense)              (None, 512)               262656    
_________________________________________________________________
dropout_2 (Dropout)          (None, 512)               0         
_________________________________________________________________
dense_3 (Dense)              (None, 10)                5130      
=================================================================
Total params: 669,706
Trainable params: 669,706
Non-trainable params: 0
_________________________________________________________________
Train on 60000 samples, validate on 10000 samples
Epoch 1/20
2018-07-17 17:55:10.972714: I tensorflow/core/platform/cpu_feature_guard.cc:137] Your CPU supports instructions that this TensorFlow binary was not compiled to use: SSE4.1 SSE4.2
2018-07-17 17:55:12.698975: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1105] Found device 0 with properties: 
name: Quadro P5000 major: 6 minor: 1 memoryClockRate(GHz): 1.7335
pciBusID: 0000:0b:00.0
totalMemory: 15.90GiB freeMemory: 15.78GiB
2018-07-17 17:55:13.019224: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1105] Found device 1 with properties: 
name: Quadro P5000 major: 6 minor: 1 memoryClockRate(GHz): 1.7335
pciBusID: 0000:11:00.0
totalMemory: 15.90GiB freeMemory: 15.78GiB
2018-07-17 17:55:13.019478: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1120] Device peer to peer matrix
2018-07-17 17:55:13.019769: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1126] DMA: 0 1 
2018-07-17 17:55:13.019843: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1136] 0:   Y N 
2018-07-17 17:55:13.019893: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1136] 1:   N Y 
2018-07-17 17:55:13.019981: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1195] Creating TensorFlow device (/device:GPU:0) -> (device: 0, name: Quadro P5000, pci bus id: 0000:0b:00.0, compute capability: 6.1)
2018-07-17 17:55:13.020032: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1195] Creating TensorFlow device (/device:GPU:1) -> (device: 1, name: Quadro P5000, pci bus id: 0000:11:00.0, compute capability: 6.1)
60000/60000 [==============================] - 20s 333us/step - loss: 0.2449 - acc: 0.9251 - val_loss: 0.1060 - val_acc: 0.9658
Epoch 2/20
60000/60000 [==============================] - 4s 68us/step - loss: 0.1024 - acc: 0.9684 - val_loss: 0.0777 - val_acc: 0.9763
```

## Other Useful Resources:

* [TensorFlow Installation Instructions](https://www.tensorflow.org/install/install_linux)

* [A Singularity Google Group discussion about GPUs](https://groups.google.com/a/lbl.gov/forum/#!topic/singularity/CezfXNjLGe0)

* [CUDA/NVIDIA driver compatibility chart](https://stackoverflow.com/questions/30820513/what-is-version-of-cuda-for-nvidia-304-125/30820690#30820690). Note that TensorFlow does **not** support CUDA > 9.0 as of this writing.

* [A similar repository from Clemson University](https://github.com/clemsonciti/singularity-images/tree/master/caffe). It differs from this repository in that it's kind of old, uses deprecated features from Singularity, makes stronger assumptions about versions, and is more complex.
