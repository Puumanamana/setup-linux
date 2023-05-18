FROM condaforge/mambaforge:23.1.0-1

COPY python-datascience.yml /tmp/
RUN mamba env create -f /tmp/python-datascience.yml

COPY r-datascience.yml /tmp/
RUN mamba env create -f /tmp/r-datascience.yml

COPY bioinfo.yml /tmp/
RUN mamba env create -f /tmp/bioinfo.yml

COPY base.yml /tmp/
RUN mamba env update -f /tmp/base.yml
RUN mamba clean -afy
RUN npm install -g http-server

EXPOSE 8080

WORKDIR /workspace
