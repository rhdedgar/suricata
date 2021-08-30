# /usr/local/bin/start.sh will start the service

# FROM registry.access.redhat.com/ubi8/ubi-minimal
FROM fedora:34

# Pause indefinitely if asked to do so.
ARG OO_PAUSE_ON_BUILD
RUN test "$OO_PAUSE_ON_BUILD" = "true" && while sleep 10; do true; done || :

RUN dnf install -y suricata && \
    dnf clean all

ADD scripts/ /usr/local/bin/

USER 0

# Start processes
CMD /usr/local/bin/start.sh
