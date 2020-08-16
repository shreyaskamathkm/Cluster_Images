#!/bin/bash  -i
echo "Downloading Cuda Installer"

CUDA_VER=10.2
CUDA=cuda_10.2.89_440.33.01_linux.run
#CUDNN_TAR_FILE=cudnn-10.2-linux-x64-v7.6.5.32.tgz
Anaconda_verion=Anaconda3-2020.07-Linux-x86_64.sh


if [ -f "$CUDA" ]; then
	echo "$CUDA exist"
else
	echo "$CUDA does not exist"
	echo "Downloading file"
    	wget http://developer.nvidia.com/compute/cuda/$CUDA_VER/Prod/local_installers/$CUDA
fi

echo "Installing Cuda Installer"

chmod +x $CUDA
sudo sh $CUDA --silent --toolkit

echo "Adding Path to bashrc"

echo export PATH=/usr/local/cuda-$CUDA_VER'/bin${PATH:+:${PATH}}' >> ~/.bashrc
echo export LD_LIBRARY_PATH=/usr/local/cuda-$CUDA_VER'/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
echo export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64'${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc

source ~/.bashrc


echo "Executing NVCC"
echo "which nvcc"

echo "Installing Anaconda"

if [[ ! -e /opt/anaconda ]]; then
    sudo mkdir /opt/anaconda
elif [[ ! -d /opt/anaconda ]]; then
    echo "/opt/anaconda already exists but is not a directory"
fi

sudo chmod ugo+w /opt/anaconda

if [ -f "anaconda.sh" ]; then
	echo "anaconda.sh exist"
else
	echo "anaconda.sh does not exist"
	echo "Downloading file"
    	wget  https://repo.anaconda.com/archive/$Anaconda_verion -O ./anaconda.sh
fi

bash ./anaconda.sh -b -p /opt/anaconda/anaconda3


echo '# >>> conda initialize >>>' >> ~/.bashrc
echo '# !! Contents within this block are managed by "conda init" !!' >> ~/.bashrc
echo '__conda_setup="$('/opt/anaconda/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"' >> ~/.bashrc
echo 'if [ $? -eq 0 ]; then' >> ~/.bashrc
echo '    eval "$__conda_setup"' >> ~/.bashrc
echo 'else' >> ~/.bashrc
echo '    if [ -f "/opt/anaconda/anaconda3/etc/profile.d/conda.sh" ]; then' >> ~/.bashrc
echo '        . "/opt/anaconda/anaconda3/etc/profile.d/conda.sh"' >> ~/.bashrc
echo '    else' >> ~/.bashrc
echo '        export PATH="/opt/anaconda/anaconda3/bin:$PATH"' >> ~/.bashrc
echo '    fi' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo "unset __conda_setup" >> ~/.bashrc
echo "# <<< conda initialize <<<" >> ~/.bashrc


echo "Please install CUDNN Seperately"
echo "Installation complete"


#wget --user=username --ask-password https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.2_20191118/$CUDNN_TAR_FILE
#tar -xzvf ${CUDNN_TAR_FILE}

#sudo cp -P cuda/include/cudnn.h /usr/local/cuda-$CUDA_VER/include
#sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-$CUDA_VER/lib64/
#sudo chmod a+r /usr/local/cuda-$CUDA_VER/lib64/libcudnn*
