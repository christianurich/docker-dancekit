############################################################
# Dockerfile to build DynaMind Webserver
# Based on Ubuntu
# docker build -t dancekit . 
# docker run -name dancekit_instance -p 80:80 -i -t dancekit 
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Maintaner Chrisitan Urich

RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe restricted multiverse" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y  python-software-properties
RUN apt-get install -y software-properties-common

RUN  add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN  add-apt-repository -y ppa:mapnik/v2.2.0

RUN apt-get update 
RUN apt-get install -y build-essential cmake git graphviz graphviz-dev swig qt4-dev-tools python-dev python-pip libgdal1-dev libcgal-dev libqglviewer-dev-common libboost-system-dev libboost-graph-dev python-numpy python-scipy python-gdal python-matplotlib python-netcdf
RUN apt-get install  -y  libmapnik libmapnik-dev mapnik-utils python-mapnik

RUN pip install reimport
RUN pip install netCDF4
RUN pip install pygraphviz 


#Compile DynaMind
RUN git clone git://github.com/christianurich/DynaMind-ToolBox.git /home/DynaMind-ToolBox
WORKDIR /home/DynaMind-ToolBox/
RUN git checkout flask
WORKDIR /home/DynaMind-ToolBox/build
RUN cmake ../
RUN make -j2


RUN cd
WORKDIR  /home

RUN git clone https://bitbucket.org/christianurich/flask-dynamind.git

RUN export PYTHONPATH="/home/DynaMind-Toolbox/build/output:${PYTHONPATH}"

RUN pip install flask
RUN pip install cherrypy

# Expose ports
EXPOSE 80

WORKDIR /home/flask-dynamind
RUN git pull origin master
CMD python server.py

