# This image is based on nvidia/cuda:10.1-cudnn7-devel. Only wget,git,libgl1-mesa-glx and libglib2.0-0 are installed
FROM nvidia/cuda:10.1-cudnn7-devel

# install conda
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-key del 3bf863cc
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

RUN apt-get update \
    && apt-get install -y wget git libgl1-mesa-glx libglib2.0-0 libsm6 libxext6 libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version

# create environment
RUN conda create -y --name db python=3.7

# activate environment
SHELL ["conda", "run", "-n", "db", "/bin/bash", "-c"]

# force enable cuda
ENV FORCE_CUDA="1"
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

# install packages
RUN conda install ipython pip

# python dependencies
COPY ./requirement.txt ./requirement.txt
RUN pip install -r requirement.txt

# install PyTorch with cuda-10.1
RUN conda install pytorch=1.3.1 torchvision cudatoolkit=10.1 -c pytorch


# clone TextFuseNet
# RUN git clone https://github.com/ying09/TextFuseNet.git

# set the working directory
# WORKDIR TextFuseNet
WORKDIR /home

# install fvcore
# RUN pip install fvcore-master.zip

# build TextFuseNet
# RUN python setup.py build develop

# activate environment for the user
RUN echo "source activate db" > ~/.bashrc

# use demo script as an entry point
# ENTRYPOINT python demo/${DEMO_FILE} --weights model.pth --output ./output_images/
