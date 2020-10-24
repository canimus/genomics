FROM ubuntu:20.04

LABEL 'maintainer=Virginie Grosboillot email=grosboillot.virginie@gmail.com'
LABEL 'maintainer=Herminio Vazquez email=canimus@gmail.com'

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get update
RUN apt-get -y install tzdata
RUN apt-get -y install build-essential wget

RUN echo "Europe/Amsterdam" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt install -y -q openjdk-8-jdk

RUN wget https://github.com/marbl/canu/releases/download/v2.1.1/canu-2.1.1.Linux-amd64.tar.xz

RUN apt-get install -y xz-utils
RUN unxz canu-2.1.1.Linux-amd64.tar.xz
RUN tar -xvf canu-2.1.1.Linux-amd64.tar
RUN rm canu-2.1.1.Linux-amd64.tar
ENV PATH "$PATH:/canu-2.1.1/bin"

RUN apt install -y emboss

RUN wget https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2
RUN apt-get install -y lbzip2
RUN bzip2 -d bwa-0.7.17.tar.bz2
RUN tar -xvf bwa-0.7.17.tar
RUN rm -rf bwa-0.7.17.tar

RUN apt-get install -y libz-dev
RUN cd /bwa-0.7.17 && make -j24
ENV PATH "$PATH:/bwa-0.7.17"

RUN mkdir -p /prodigal
RUN cd /prodigal && wget https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux
RUN cd /prodigal && mv prodigal.linux prodigal
RUN chmod 755 /prodigal/prodigal
ENV PATH "$PATH:/prodigal"

RUN wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
RUN bzip2 -d samtools-1.11.tar.bz2
RUN tar -xvf samtools-1.11.tar
RUN rm samtools-1.11.tar

RUN apt install -y libncurses5-dev libbz2-dev liblzma-dev

RUN cd samtools-1.11 && ./configure --prefix=/samtools-1.11/bin
RUN cd samtools-1.11 && make -j24
RUN cd samtools-1.11 && make install
ENV PATH "$PATH:/samtools-1.11"

RUN wget https://sourceforge.net/projects/mummer/files/latest/download
RUN mv download MUMmer3.23.tar.gz
RUN tar -zxvf MUMmer3.23.tar.gz
RUN rm MUMmer3.23.tar.gz
RUN cd /MUMmer3.23 && make -j24
ENV PATH "$PATH:/MUMmer3.23"

RUN wget http://cab.spbu.ru/files/release3.14.1/SPAdes-3.14.1-Linux.tar.gz
RUN tar -zxvf SPAdes-3.14.1-Linux.tar.gz
RUN rm SPAdes-3.14.1-Linux.tar.gz
ENV PATH "$PATH:/SPAdes-3.14.1-Linux/bin"

RUN apt-get install -y python3 python3-venv python3-pip
RUN pip3 install wheel
RUN pip3 install circlator

RUN wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.1+-x64-linux.tar.gz
RUN tar -zxvf ncbi-blast-2.10.1+-x64-linux.tar.gz
ENV PATH "$PATH:/ncbi-blast-2.10.1+/bin"

RUN wget https://github.com/broadinstitute/pilon/releases/download/v1.23/pilon-1.23.jar
RUN echo 'alias pilon="java -jar /pilon-1.23.jar"' >> ~/.bashrc

VOLUME /data