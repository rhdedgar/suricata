# /usr/local/bin/start.sh will start the service

# FROM registry.access.redhat.com/ubi8/ubi-minimal
FROM fedora:34

# Pause indefinitely if asked to do so.
ARG OO_PAUSE_ON_BUILD
RUN test "$OO_PAUSE_ON_BUILD" = "true" && while sleep 10; do true; done || :

RUN dnf install -y suricata && \
    dnf clean all && \
    suricata-update && \
    sed -i -e 's/default-log-dir: \/var\/log\/suricata/default-log-dir: \/host\/var\/log/' /etc/suricata/suricata.yaml && \
    sed -i -e 's/default-rule-path: \/var\/lib\/suricata\/rules/default-rule-path: \/etc\/suricata\/rules/' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - http-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - app-layer-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - decoder-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - dhcp-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - dns-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - files.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - http-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - ipsec-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - kerberos-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - modbus-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - nfs-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - ntp-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - smb-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - smtp-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - stream-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e '/^rule-files:/a\ \ - sre-events.rules' /etc/suricata/suricata.yaml && \
    sed -i -e 's/- suricata.rules/- tls-events.rules/' /etc/suricata/suricata.yaml

ADD scripts/ /usr/local/bin/

USER 0

# Start processes
CMD /usr/local/bin/start.sh
