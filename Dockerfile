ARG R_VERSION=4.0.4
FROM inseefrlab/rstudio:${R_VERSION} AS renv
LABEL org.opencontainers.image.source https://github.com/MTES-MCT/parcours-r
RUN sudo apt-get update && sudo apt install -y cargo \
  && rm -rf /var/lib/apt/lists/*
ENV RENV_VERSION=0.13.2
RUN installGithub.r rstudio/renv@${RENV_VERSION}

FROM renv
COPY renv.lock renv.lock
RUN Rscript -e "renv::restore()"
