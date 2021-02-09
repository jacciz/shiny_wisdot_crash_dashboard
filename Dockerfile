
FROM rocker/r-ver:4.0.3

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker-versioned" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Carl Boettiger <cboettig@ropensci.org>"

ENV S6_VERSION=v1.21.7.0
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default

RUN /rocker_scripts/install_geospatial.sh
RUN /rocker_scripts/install_shiny_server.sh

# https://github.com/rocker-org/shiny/issues/60 # for spatial stuff
# system libraries of general use

# copy necessary files
## app folder
COPY . ./app
## renv.lock file
COPY /renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::consent(provided = TRUE)'
RUN Rscript -e 'renv::restore()'

# install other R packages required
  RUN R -e "install.packages(c('littler', 'shinydashboard','shinyWidgets', 'plotly', 'leaflet', 'dplyr', 'ggplot2', 'lubridate', 'leaflet.extras2', 'tibble', 'data.table', 'fst', 'dashboardthemes', 'sf', 'Rmpfr', 'leafgl'), repos='https://cloud.r-project.org/')"

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
#CMD ["R", "-e", "shiny::runApp('/root/crash_dashboard')"]
