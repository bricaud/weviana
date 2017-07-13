FROM python:3.5-slim
MAINTAINER Benjamin Ricaud <benjamin.ricaud@eviacybernetics.com>
RUN pip3 --no-cache-dir install --upgrade pip && \
	pip3 --no-cache-dir install numpy && \
	pip3 --no-cache-dir install django && \
	pip3 --no-cache-dir install networkx

RUN	pip3 --no-cache-dir install tqdm && \
	pip3 --no-cache-dir install python-louvain &&\
	pip3 --no-cache-dir install gremlinpython

RUN apt-get update -y &&\
	apt-get install -y ghostscript tesseract-ocr tesseract-ocr-fra git


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

CMD python3 -V && pip freeze && \
	gs -v && tesseract -v && \ 
	python3 manage.py makemigrations && python3 manage.py migrate && python3 manage.py runserver 0:8010 
	

EXPOSE 8010