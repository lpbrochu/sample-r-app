FROM r-base:latest
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
#ENTRYPOINT ["Rscript"]
