#!/usr/bin/env bash
# To be used with the udev rule: /etc/udev/rules.d/999-aws-ebs-nvme.rules

kern_name=${1}
incr=0
while [[ -e "/dev/ephemeral${incr}" ]] && [[ $(readlink "/dev/ephemeral${incr}") != "${kern_name}" ]]; do
  incr=$[$i+1]
done
echo "ephemeral${incr}"
