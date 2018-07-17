Bootstrap: docker 
From: library/ubuntu:16.04

%labels

    AUTHOR dmerrell@cs.wisc.edu


%files

    cuda___CUDA_VERSION___linux.run 	/opt/cuda___CUDA_VERSION___linux.run
    cudnn-__CUDNN_VERSION__.tgz          /opt/cudnn-__CUDNN_VERSION__.tgz


%post
    
    # Install python3 and pip
    apt-get update
    apt-get -y install python3 python3-pip python3-dev
    
    # Install some perl stuff
    apt-get -y install libmodule-install-perl


    #################################
    # Install the NVIDIA requirements
    #################################
    
    # CUDA Toolkit
    chmod +x ./opt/cuda___CUDA_VERSION___linux.run
    ./opt/cuda___CUDA_VERSION___linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-__CUDA_VERSION__
    export LD_LIBRARY_PATH="/usr/local/cuda-__CUDA_VERSION__/lib64:$LD_LIBRARY_PATH"
    ldconfig

    # cuDNN SDK
    tar -xvzf /opt/cudnn-__CUDNN_VERSION__.tgz
    cp cuda/include/cudnn.h /usr/local/cuda-__CUDA_VERSION__/include/
    cp cuda/lib64/libcudnn* /usr/local/cuda-__CUDA_VERSION__/lib64/
    chmod a+r /usr/local/cuda-__CUDA_VERSION__/include/cudnn.h /usr/local/cuda-__CUDA_VERSION__/lib64/libcudnn*
    
    # Install NVIDIA drivers:
    apt-get -y install nvidia-__NVIDIA_MV__

    # libcupti-dev library
    apt-get -y install libcupti-dev
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/cuda-__CUDA_VERSION__/extras/CUPTI/lib64
    ldconfig

    #################################
    # Install python packages
    #################################

    pip3 install pandas

    pip3 install sklearn

    pip3 install tensorflow-gpu==__TENSORFLOW_VERSION__

    pip3 install keras
   
 
    #################################
    # Clean up
    #################################

    # remove nvidia installers
    rm /opt/*.run
    rm /opt/*.tgz


%environment

    # NVIDIA-related environment variables
    export PATH="/NVIDIA-Linux-x86_64-__NVIDIA_VERSION__:$PATH"
    export LD_LIBRARY_PATH="/NVIDIA-Linux-x86_64-__NVIDIA_VERSION__:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-__CUDA_VERSION__/lib64:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/cuda/extras/CUPTI/lib64


