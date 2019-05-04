#!/bin/bash

PATH="${PATH}:/usr/sbin"

for blkdev in $( nvme list | awk '/^\/dev/ { print $1 }' )
do
  # get mapping info from disk headers
  mapping=$(nvme id-ctrl --raw-binary "${blkdev}" | cut -c3073-3104 | tr -s ' ' | sed 's/ $//g' | sed 's/\/dev\///')
  # test if its block device and symlink does not exist. Then create symlink
  ( [[ -b "${blkdev}" ]] && [[ ! -L "/dev/${mapping}" ]] ) && ln -s "${blkdev}" "/dev/${mapping}"
done
