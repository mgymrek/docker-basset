FROM ubuntu:14.04
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>

# Install Ubuntu packages
RUN apt-get -qqy update
RUN apt-get install -y -q git curl python-pip cython libxft-dev libblas-dev liblapack-dev libatlas-base-dev gfortran libhdf5-dev wget bedtools
RUN mkdir -p /home/workspace
RUN mkdir -p /home/workspace/cuda

# Install torch
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git /home/workspace/torch --recursive
WORKDIR /home/workspace/torch
RUN ./install.sh
RUN bash -c "source ~/.bashrc"

# Install python dependencies
RUN pip install numpy matplotlib seaborn pandas h5py sklearn pysam

# Install CUDA
#WORKDIR /home/workspace/cuda
#RUN wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
#RUN dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
#RUN apt-get update
#RUN apt-get install cuda

# Install basset
RUN git clone https://github.com/davek44/Basset.git /home/workspace/Basset
WORKDIR /home/workspace/Basset
ENV BASSETDIR /home/workspace/Basset
ENV PATH $BASSETDIR/src:$PATH
ENV LUA_PATH "$BASSETDIR/src/?.lua;$LUA_PATH"
ENV PYTHONPATH $BASSETDIR/src:$PYTHONPATH
RUN ./install_dependencies.py