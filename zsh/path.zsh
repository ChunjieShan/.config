# PATH
export PATH=~/local_install/bin/:$PATH


export VULKAN_SDK=~/local_install/vulkansdk/x86_64
export PATH=/usr/local/cuda/bin:$PATH
export PATH=/usr/local/cuda-11.1/bin${PATH:+:${PATH}}
export CUDA_ROOT=/usr/local/cuda

export PATH=$PATH:$CUDA_ROOT/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/rick/local_install/boost-1-65/lib

CUDA_HOME=/usr/local/cuda
export C_INCLUDE_PATH=${CUDA_HOME}/include:${C_INCLUDE_PATH}
export LIBRARY_PATH=${CUDA_HOME}/lib64:$LIBRARY_PATH

export AUTOGRAPH_VERBOSITY=10

export PATH=$GOPATH/bin:$PATH
# export PATH=/home/rick/Code/Projects/AI/CV/2.Caffe_Long/build/tools:$PATH
export PATH=/home/rick/.emacs.d/bin:$PATH
export PATH=/home/rick/local_install/node/bin:$PATH
export CMAKE_ROOT=/home/linuxbrew/.linuxbrew/Cellar/cmake/3.18.0/bin
export PATH=$CMAKE_ROOT:$PATH
export PATH=/home/linuxbrew/.linuxbrew/Cellar/cmake/3.18.0/bin:$PATH
export PATH=/home/rick/local_install/nncase:$PATH
export PATH=/home/rick/.jdks/openjdk-15.0.1/bin:$PATH
export PATH=/home/rick/local_install/apache-opennlp-1.9.3/bin:$PATH
export PATH=/home/rick/local_install/sqlite:$PATH
export PATH=/home/rick/Code/Tools/crawler/Image-Downloader/bin:$PATH
export TRT_RELEASE=~/local_install/TensorRT-7.0.0.11
export LD_LIBRARY_PATH=$TRT_RELEASE/lib:$LD_LIBRARY_PATH


export GOPATH=/usr/local/go

# export PYTHONPATH=/home/rick/Code/Projects/AI/CV/2.Caffe_Long/python:$PYTHONPATH
export PYTHONPATH=/home/rick/Code/Projects/pytorch-network-slimming:$PYTHONPATH
# export PYTHONPATH=$PYTHONPATH:/home/rick/Code/Learning/Python/Object_detection_demo/models/research:/home/rick/Code/Learning/Python/Object_detection_demo/models/research/slim
export PYTHONPATH=$PYTHONPATH:/home/rick/Code/Projects/AI/CV/Object-detection/models/research:/home/rick/Code/Projects/AI/CV/Object-detection/models/research/slim
export PYTHONPATH=$PYTHONPATH:/home/rick/Code/Projects/AI/CV/Object-detection/cocoapi/PythonAPI:/home/rick/Code/Projects/AI/CV/Object-detection/cocoapi/PythonAPI/pycocotools
# export PYTHONPATH=$PYTHONPATH:/home/rick/Code/Learning/Python/Object_detection_demo/cocoapi/PythonAPI:/home/rick/Code/Learning/Python/Object_detection_demo/cocoapi/PythonAPI/pycocotools
export LD_LIBRARY_PATH=/opt/intel/openvino_2021.2.185/deployment_tools/inference_engine/external/tbb/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH="/home/rick/local_install/Qt/Tools/QtCreator/bin:$PATH"
export PATH="/home/rick/local_install/Qt/5.15.0/gcc_64/bin:$PATH"
export PATH="/home/rick/local_install/gcc-arm-none-eabi-10-2020-q4-major/bin:$PATH"


PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig  
export PKG_CONFIG_PATH

export TESSDATA_PREFIX=/usr/local/share/tessdata

# export QTDIR=/home/rick/local_install/Qt/5.15.2/gcc_64
# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${QTDIR}/lib
# export PATH=${QTDIR}/bin:${PATH}

LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_PREVIEW_COMMAND='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'

# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/rick/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/rick/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rick/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/rick/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
