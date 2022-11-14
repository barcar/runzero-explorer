##
## Sample Containerfile for running the Rumble Explorer in a container, with 
## screenshot support.
##
FROM debian:stable-slim

WORKDIR /opt/runzero

RUN apt update && \
    apt install -y chromium curl # add wireless-tools if you want WiFi scanning

ARG AGENT_URL

RUN echo "$AGENT_URL"
RUN curl -o runzero-explorer.bin "${AGENT_URL}"

RUN chmod +x runzero-explorer.bin

## For full functionality the Rumble scanner needs to send and receive raw 
## packets, which requires elevated privileges. 
USER root

## The argument `manual` tells Rumble not to look for SystemD or upstart.
ENTRYPOINT [ "/opt/runzero/runzero-explorer.bin", "manual"]
