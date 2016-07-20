# Just for testing that the install script works
FROM ubuntu:16.04

RUN mkdir /scripts

COPY ./scripts /scripts
WORKDIR /scripts

CMD bash install.sh
