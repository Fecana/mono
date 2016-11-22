FROM ioft/i386-ubuntu

MAINTAINER Fecana

RUN apt-get update

RUN apt-get install -y mono-devel mono-vbnc nuget build-essential

EXPOSE 12345
