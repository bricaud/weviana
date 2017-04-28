FROM python:3.5-slim
MAINTAINER Benjamin Ricaud <benjamin.ricaud@eviacybernetics.com>
RUN pip3 --no-cache-dir install --upgrade pip && \
	pip3 --no-cache-dir install numpy && \
	pip3 --no-cache-dir install django && \
	pip3 --no-cache-dir install networkx

RUN	pip3 --no-cache-dir install tqdm && \
	pip3 --no-cache-dir install python-louvain
# For Java 8
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update -y &&\
	apt-get install -y ghostscript tesseract-ocr tesseract-ocr-fra git
RUN apt-get install -y wget unzip
# Java 8
RUN apt-get -t jessie-backports install -y openjdk-8-jdk


RUN wget --no-check-certificate -O $HOME/gremlin.zip http://apache.mirrors.ovh.net/ftp.apache.org/dist/tinkerpop/3.2.4/apache-tinkerpop-gremlin-server-3.2.4-bin.zip
RUN unzip $HOME/gremlin.zip -d /
RUN rm $HOME/gremlin.zip


# RUN apt-get install -y git
ADD https://api.github.com/repos/bricaud/grevia/git/refs/heads/master version.json
ADD https://api.github.com/repos/bricaud/OCR-classif/git/refs/heads/master version.json
ADD https://api.github.com/repos/bricaud/wevia/git/refs/heads/master version.json
RUN git clone --depth=1 https://github.com/bricaud/grevia.git grevia && \
	git clone --depth=1 https://github.com/bricaud/OCR-classif.git OCR && \
	git clone --depth=1 https://github.com/bricaud/wevia.git wevia 

# git clone --depth=1 https://github.com/taynaud/python-louvain.git louvain

ENV PYTHONPATH $PYTHONPATH:/Grevia
ENV PYTHONPATH $PYTHONPATH:/OCR
WORKDIR /wevia/
# COPY ./wevia /web2
# COPY /media/benjamin/Largo/testspdfs /media/benjamin/Largo/testspdfs
# CMD pwd
# CMD echo $PYTHONPATH
CMD python3 -V && pip freeze && \
	gs -v && tesseract -v && \ 
	python3 manage.py makemigrations && python3 manage.py migrate && python3 manage.py runserver 0:8010 &&\
	../apache-tinkerpop-gremlin-server-3.2.4/bin/gremlin-server.sh conf/gremlin-server-modern.yaml

EXPOSE 8010 8182