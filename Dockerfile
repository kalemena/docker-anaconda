FROM centos:7

MAINTAINER Kalemena

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
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN yum install -y epel-release; \
    yum install -y python-pip python-devel gcc; \
    yum install -y wget bzip2;

RUN wget https://repo.anaconda.com/archive/Anaconda${VERSION}-Linux-x86_64.sh; \
    bash Anaconda${VERSION}-Linux-x86_64.sh -b; \
    rm Anaconda${VERSION}-Linux-x86_64.sh;

ENV PATH /root/anaconda3/bin:$PATH

RUN conda update conda; \
    conda update anaconda; \
    conda update --all

RUN mkdir /opt/notebooks; \
    jupyter notebook --generate-config --allow-root; \
    echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='0.0.0.0'", "--port=8888", "--no-browser"]