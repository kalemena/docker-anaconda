FROM python:3.8.8

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena Anaconda" \
      org.label-schema.description="Kalemena Anaconda" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-anaconda" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=${VERSION} \
      org.label-schema.schema-version="1.0"

RUN apt-get update -y \
    && apt-get install -y \
        wget \
        libgl1-mesa-glx libegl1-mesa \
        libxrandr2 libxrandr2 \
        libxss1 libxcursor1 \
        libxcomposite1 libasound2 \
        libxi6 libxtst6 \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8
ENV PATH=$PATH:/root/anaconda3/bin

RUN wget https://repo.anaconda.com/archive/Anaconda${VERSION}-Linux-x86_64.sh \
    && bash Anaconda${VERSION}-Linux-x86_64.sh -b \
    && rm Anaconda${VERSION}-Linux-x86_64.sh \
    && conda update -y conda \
    && conda update -y anaconda \
    && conda update -y --all \
    && conda clean -a -y

ADD requirements.txt /

RUN conda install --file /requirements.txt -y \
    && conda clean -a -y;

RUN mkdir /opt/notebooks \
    && jupyter notebook --generate-config --allow-root \
    && echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

CMD ["jupyter", "lab", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='0.0.0.0'", "--port=8888", "--no-browser"]

