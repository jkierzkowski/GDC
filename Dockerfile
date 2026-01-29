FROM ubuntu:22.04

ENV LANG=C.UTF-8

WORKDIR /opt

RUN mkdir /opt/Home

#set up of Pythia 6&8 variables
ARG PYTHIA6=/opt/pythia6428
ARG PYTHIA8_DIR=/opt/pythia8309
ARG PYTHIA8_INCLUDE_DIR=/opt/pythia8309
ARG PYTHIA8_LIBRARY=/opt/pythia8309/lib

#set up of python variable
ARG PYTHON_VERSION=3.10

#set up of GENIE variables
ARG GENIE_INSTALL /opt/GENIE
ENV GENIE /opt/Generator-R-3_04_00
ENV ROOTSYS /opt/root_build

ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONPATH $ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH none

#Setting up path to GENIE
ENV PATH $GENIE/bin:$PATH

#Setting up Libraries paths
ENV LD_LIBRARY_PATH /opt/pythia6428/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /opt/root_install/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /opt/GENIE/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$PYTHIA6:$LD_LIBRARY_PATH

#Dependencies 
RUN apt-get update && apt-get -y install python3-dev\
	 python2-dev\
	 pip\
	 libzstd-dev\
	 libz-dev\
	 libxxhash-dev\
	 libxpm-dev\
	 libxml2-dev\
	 libxft-dev\
	 libxext-dev\
	 libx11-dev\
	 libtool\
	 libtiff-dev\
	 libtbb-dev\
	 libssl-dev\
	 libsqlite3-dev\
	 libpq-dev\
	 libpng-dev\
	 libpcre++-dev\
	 libmysqlclient-dev\
	 liblzma-dev\
	 liblz4-dev\
	 libjpeg-dev\
	 libgsl-dev\
	 libgraphviz-dev\
	 libglu-dev\
	 libglew-dev\
	 libgl2ps-dev\
	 libgif-dev\
	 libgfal2-dev\
	 libftgl-dev\
	 libfreetype6-dev\
	 libfftw3-dev\
	 libfcgi-dev\
	 libcfitsio-dev\
	 libafterimage-dev\
	 git\
	 gfortran\
	 gcc\
	 g++\
	 fonts-freefont-ttf\
	 dpkg-dev\
	 dcap-dev\
	 davix-dev\
	 curl\
	 cmake\
	 ca-certificates\
	 binutils\
	 automake\
	 autogen\
	 autoconf

RUN pip install pygments
RUN pip install pyyaml

#GSL
ADD gsl-2.7.1.tar.gz ./
RUN cd gsl-2.7.1\
&& ./configure\
&& make\
&& make install

#PYTHIA8
ADD pythia8309.tgz ./
RUN cd pythia8309\
&& ./configure\
&& make

#PYTHIA6 installation
RUN git clone https://github.com/GENIE-MC/Generator.git
RUN Generator/src/scripts/build/ext/build_pythia6.sh 6428
RUN mv v6_428 pythia6428

#LOG4CPP
ADD log4cpp-1.1.4rc3.tar.gz ./
RUN cd log4cpp\
&& ./autogen.sh\	
&& ./configure\	
&& make\
&& make install

#LHAPDF6
ADD LHAPDF-6.5.3.tar.gz ./
RUN cd LHAPDF-6.5.3\
&& ./configure\
&& make\
&& make install

#ROOT
RUN git clone --branch v6-26-10 https://github.com/root-project/root.git root_src
RUN mkdir root_build root_install\
&& cd root_build\
&& cmake -DCMAKE_INSTALL_PREFIX=../root_install ../root_src\
&& cmake --build . -- install -j4


#GENIE configuration & installation
ADD Generator-R-3_04_00 ./Generator-R-3_04_00
RUN cd $GENIE\
&& ./configure --prefix=/opt/GENIE \
             --disable-profiler \
             --disable-validation-tools \
             --disable-cernlib \
             --enable-lhapdf6 \
             --enable-flux-drivers \
             --enable-geom-drivers \
             --disable-doxygen \
             --enable-test \
             --enable-mueloss \
             --enable-dylibversion \
             --enable-t2k \
             --enable-fnal \
             --enable-atmo \
             --enable-nucleon-decay \
             --disable-masterclass \
             --disable-debug \
             --with-optimiz-level=O2 \
             --with-lhapdf6-lib=/opt/LHAPDF-6.5.3/lib\
             --with-pythia6-lib=/opt/pythia6428/lib \
             --with-libxml2-inc=/opt/libxml2 \
             --with-libxml2-lib=/opt/\
             --with-log4cpp-inc=/opt/log4cpp\include \
             --with-log4cpp-lib=/opt/log4cpp/lib\
&& gmake -j4\
&& gmake install

#JUPYTERLAB
RUN pip install jupyterlab

CMD ["jupyter-lab", "--no-browser", "--ip=0.0.0.0", "--notebook-dir=/opt/Home","--allow-root"]





















