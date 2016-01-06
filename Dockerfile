FROM ubuntu:14.04
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN apt-get -qqy update
RUN apt-get install -y -q git curl python-pip cython libxft-dev libblas-dev liblapack-dev libatlas-base-dev gfortran libhdf5-dev wget bedtools
RUN mkdir -p /home/workspace

# Install torch
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git /home/workspace/torch --recursive
WORKDIR /home/workspace/torch
RUN ./install.sh
RUN source ~/.bashrc

# Install python dependencies
RUN pip install numpy matplotlib seaborn pandas h5py sklearn pysam

# Install basset
RUN git clone https://github.com/davek44/Basset.git /home/workspace/Basset
WORKDIR /home/workspace/Basset
ENV BASSETDIR /home/workspace/Basset
ENV PATH $BASSETDIR/src:$PATH
ENV LUAPATH $BASSETDIR/src:$LUAPATH
ENV PYTHONPATH $BASSETDIR/src:$PYTHONPATH
RUN ./install_dependencies.py