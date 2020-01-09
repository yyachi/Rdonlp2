ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
MAINTAINER yyachi <yyachi@misasa.okayama-u.ac.jp>

USER root
RUN apt-get update && apt-get install -y \
qpdf
USER jovyan
RUN mkdir -p src/Rdonlp2
ADD . src/Rdonlp2/
RUN Rscript -e 'setwd("~/src/Rdonlp2");devtools::check();devtools::install()'
