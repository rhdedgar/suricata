#!/bin/bash -e

# This is useful so we can debug containers running inside of OpenShift that are
# failing to start properly.

if [ "$OO_PAUSE_ON_START" = "true" ] ; then
  echo
  echo "This container's startup has been paused indefinitely because OO_PAUSE_ON_START has been set."
  echo
  while true; do
    sleep 10
  done
fi

echo 'version v0.0.9'
echo
echo This container hosts the following applications:
echo
echo '/bin/suricata'
echo
echo 'Start suricata IDS.'
echo '----------------'
# the first active broadcast interface value is what we want to listen on, usually ens5 or eth10
/usr/sbin/suricata -c /etc/suricata/suricata.yaml -i "$(ip a | awk '/inet.*brd/{print $NF; exit}')"
