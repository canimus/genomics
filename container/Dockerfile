FROM sangerpathogens/circlator

LABEL maintainer="Virginie Grosboillot" email="grosboillot.virginie@gmail.com"
LABEL maintainer="Herminio Vazquez" email="canimus@gmail.com"

RUN wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.1+-x64-linux.tar.gz
RUN tar -zxvf ncbi-blast-2.10.1+-x64-linux.tar.gz
ENV PATH "$PATH:/ncbi-blast-2.10.1+/bin"

VOLUME /data