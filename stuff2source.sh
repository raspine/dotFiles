#!/bin/bash
if test -f /home/jsc/.nvm/nvm.sh; then
  source /home/jsc/.nvm/nvm.sh
fi

if test -f /opt/XTC/15.2.1/SetEnv; then
  cd /opt/XTC/15.2.1
  source SetEnv
  cd -
fi
