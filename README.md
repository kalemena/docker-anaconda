# Docker Anaconda 

[![Build Status](https://travis-ci.org/kalemena/docker-anaconda.svg?branch=master)](https://travis-ci.org/kalemena/docker-anaconda)
[![Docker Version](https://images.microbadger.com/badges/version/kalemena/anaconda.svg)](https://microbadger.com/images/kalemena/anaconda)
[![Docker Hub](https://images.microbadger.com/badges/image/kalemena/anaconda.svg)](https://hub.docker.com/r/kalemena/anaconda/tags)

Building image:

[source,bash]
----
$ docker build -t kalemena/anaconda:3-2018.12 .
----

Running image, then open http://localhost:8888/ (password is 'root')

[source,bash]
----
$ docker run -p 8888:8888 -v "$PWD/notebooks:/opt/notebooks" -d kalemena/anaconda:3-2018.12
----

# Resources

* Docker re-factored image originaly from evheniy/docker-data-science 