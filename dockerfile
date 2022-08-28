##
## Sample Containerfile for running the Rumble Explorer in a container, with 
## screenshot support.
##
FROM debian:stable-slim

WORKDIR /opt/runzero

RUN apt update && \
    apt install -y chromium   # add wireless-tools if you want WiFi scanning

ADD ${AGENT_URL} runzero-explorer.bin

RUN chmod +x runzero-explorer.bin

## For full functionality the Rumble scanner needs to send and receive raw 
## packets, which requires elevated privileges. 
USER root

## The argument `manual` tells Rumble not to look for SystemD or upstart.
ENTRYPOINT [ "/opt/runzero/runzero-explorer.bin", "manual"]
