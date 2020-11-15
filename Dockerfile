FROM intel/oneapi-hpckit

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && \
    apt-get install -qq xsltproc && \
    python -m pip install lxml

COPY exciting /home/tutorials/exciting

WORKDIR /home/tutorials/exciting

# `perl setup.pl` should be run prior to building
RUN make


# perl script to parse output of test is broken
# > cd test/test02; perl assert.pl
# >   Can't use a hash as a reference at assert.pl line 93.
#RUN make test


#=====================================================================================
# The following shell variables are needed for executing scripts in exciting tutorials
#
ENV EXCITINGROOT=/home/tutorials/exciting
ENV EXCITINGBIN=$EXCITINGROOT/bin
ENV EXCITINGTOOLS=$EXCITINGROOT/tools
ENV EXCITINGSTM=$EXCITINGTOOLS/stm
ENV EXCITINGVISUAL=$EXCITINGROOT/xml/visualizationtemplates
ENV EXCITINGCONVERT=$EXCITINGROOT/xml/inputfileconverter
#-------------------------------------------------------------------------------------
ENV TIMEFORMAT="   Elapsed time = %0lR"
#-------------------------------------------------------------------------------------
ENV WRITEMINMAX="1"
#-------------------------------------------------------------------------------------
ENV PYTHONPATH=$PYTHONPATH:$EXCITINGSTM
ENV PATH=$PATH:$EXCITINGTOOLS:$EXCITINGBIN:$EXCITINGSTM
#-------------------------------------------------------------------------------------
# Probably need to put these definitions in .bashrc
#function DOS  () { xsltproc $EXCITINGVISUAL/xmldos2grace.xsl dos.xml > $1 ; }
#function BAND () { xsltproc $EXCITINGVISUAL/xmlband2agr.xsl bandstructure.xml ; }
#=====================================================================================


CMD ["/bin/bash"]
