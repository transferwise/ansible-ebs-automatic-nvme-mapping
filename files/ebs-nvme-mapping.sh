#!/bin/bash

PATH="${PATH}:/usr/sbin"

for blkdev in $( nvme list | awk '/^\/dev/ { print $1 }' )
do
  mapping=$(nvme id-ctrl --raw-binary "${blkdev}" | cut -c3073-3104 | tr -s ' ' | sed 's/ $//g')
  if [[ "/dev/${mapping}" == /dev/* ]]
  then
    ( [[ -b "${blkdev}" ]] && [[ -L "/dev/${mapping}" ]] ) || ln -s "${blkdev}" "${mapping}"
  fi
done

