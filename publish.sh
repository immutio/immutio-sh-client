#!/bin/sh

blob=$(im ./install.sh)
sh -c "heroku config:set SH_URL=$blob -a immut"
