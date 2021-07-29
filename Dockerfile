FROM ubuntu:20.04

ENV SOURCE "https://github.com/CBDD/rDock/archive/refs/heads/dev-2021.zip"
ENV DEBIAN_FRONTEND "noninteractive apt-get install -y --no-install-recommends tzdata"

ENV RBT_HOME "/opt/rdock"
ENV PATH "$RBT_HOME/bin:$PATH"
ENV LD_LIBRARY_PATH "$RBT_HOME/lib:$LD_LIBRARY_PATH"

RUN apt update && apt upgrade -y

RUN apt install g++ make libpopt0 libpopt-dev wget unzip -y

RUN wget -O rdock.zip $SOURCE && unzip rdock.zip
RUN cd /rDock*/build && make linux-g++-64

RUN mkdir $RBT_HOME -p
RUN cp -r /rDock*/data $RBT_HOME
RUN cp -r /rDock*/bin $RBT_HOME
RUN cp -r /rDock*/lib $RBT_HOME
