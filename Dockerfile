FROM rocker/r-ver:4.0.5
# Rocker image includes R, Shiny, and tidyverse
# Golem will create a new Dockerfile. must copy part of old dockerfile

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker-versioned" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Carl Boettiger <cboettig@ropensci.org>"

# RUN R -e "install.packages( 'BiocManager', repos='https://cloud.r-project.org/')"
RUN /rocker_scripts/install_geospatial.sh

# copy necessary files
## app folder
COPY . ./app
## renv.lock file
# COPY /renv.lock ./renv.lock

RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
#RUN R -e 'install.packages("remotes")'
#RUN Rscript -e 'remotes::install_version("stringr",upgrade="never", version = "1.4.0")'
#RUN Rscript -e 'remotes::install_version("tibble",upgrade="never", version = "3.1.2")'
#RUN Rscript -e 'remotes::install_version("rlang",upgrade="never", version = "0.4.10")'
#RUN Rscript -e 'remotes::install_version("processx",upgrade="never", version = "3.5.2")'
RUN Rscript -e 'remotes::install_version("sysfonts",upgrade="never", version = "0.8.3")'
RUN Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.5.1.1")'
#RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.7")'
#RUN Rscript -e 'remotes::install_version("ggplot2",upgrade="never", version = "3.3.4")'
RUN Rscript -e 'remotes::install_version("scales",upgrade="never", version = "1.1.1")'
RUN Rscript -e 'remotes::install_version("htmlwidgets",upgrade="never", version = "1.5.3")'
#RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.2.1")'
#RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.33")'
#RUN Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.1")'
#RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.6.0")'
RUN Rscript -e 'remotes::install_version("data.table",upgrade="never", version = "1.14.0")'
#RUN Rscript -e 'remotes::install_version("tidyr",upgrade="never", version = "1.1.3")'
RUN Rscript -e 'remotes::install_version("sf",upgrade="never", version = "1.0-0")'
RUN Rscript -e 'remotes::install_version("leaflet",upgrade="never", version = "2.0.4.1")'
#RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.0.2")'
#RUN Rscript -e 'remotes::install_version("remotes",upgrade="never", version = "2.4.0")'
#RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
#RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.9")'
RUN Rscript -e 'remotes::install_version("showtext",upgrade="never", version = "0.9-2")'
RUN Rscript -e 'remotes::install_version("shinyWidgets",upgrade="never", version = "0.6.0")'
RUN Rscript -e 'remotes::install_version("shinydashboard",upgrade="never", version = "0.7.1")'
RUN Rscript -e 'remotes::install_version("shinybusy",upgrade="never", version = "0.2.2")'
RUN Rscript -e 'remotes::install_version("RSQLite",upgrade="never", version = "2.2.7")'
#RUN Rscript -e 'remotes::install_version("qpdf",upgrade="never", version = "1.1")'
#RUN Rscript -e 'remotes::install_version("plyr",upgrade="never", version = "1.8.6")'
RUN Rscript -e 'remotes::install_version("plotly",upgrade="never", version = "4.9.4.1")'
RUN Rscript -e 'remotes::install_version("pool",upgrade="never", version = "0.1.6")'
RUN Rscript -e 'remotes::install_version("leafgl",upgrade="never", version = "0.1.1")'
#RUN Rscript -e 'remotes::install_version("lubridate",upgrade="never", version = "1.7.10")'
RUN Rscript -e 'remotes::install_version("leaflet.extras2",upgrade="never", version = "1.1.0")'
RUN Rscript -e 'remotes::install_version("ggtext",upgrade="never", version = "0.1.1")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.3.1")'
#RUN Rscript -e 'remotes::install_version("dbplyr",upgrade="never", version = "2.1.1")'
RUN Rscript -e 'remotes::install_version("dashboardthemes",upgrade="never", version = "1.1.3")'
RUN Rscript -e 'remotes::install_github("hrbrmstr/waffle@3f61463e6ab8d088ecff35db7cc1edfe633ee9f3")'

# expose port
EXPOSE 3838

#CMD R -e "options('shiny.port'=3838,shiny.host='0.0.0.0');crash_dashboard::run_app()"

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
