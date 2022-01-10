FROM rocker/r-base:latest
LABEL maintainer="Camilo Velázquez-Rodríguez <cavelazq@vub.ac.be>"

# Install packages in the system
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    python3 \
    python3-pip \
    python3-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN install.r \
    dynamicTreeCut \
    stringr \
    cluster \
    clValid \
    dplyr \
    shiny \
    shinycssloaders \
    treemap \
    highcharter \
    RColorBrewer \
    ggplot2 \
    parallel \
    lvplot \
    knitr \
    rmarkdown \
    reticulate

# Install Python packages
RUN pip3 install numpy pandas scikit-learn

# Configuration of the application
RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

RUN addgroup --system app && adduser --system --ingroup app app
WORKDIR /home/app/features
COPY clusters-exploration .
RUN chown app:app -R /home/app/features
USER app
EXPOSE 3838

RUN echo 'RETICULATE_PYTHON="/usr/bin/python3"' > /home/app/.Renviron

# Configuration of the application running
CMD ["R", "-e", "shiny::runApp('/home/app/features')"]