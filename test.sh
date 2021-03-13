#!/bin/bash
if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'Apache2 is running' | wc -l) > 0 ]
then
 echo "Process is running."
else
  echo "Process is not running."
fi
