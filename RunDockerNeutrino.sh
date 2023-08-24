#!/bin/bash
sudo docker run --name geniecontainer --rm -e DISPLAY=$DISPLAY -v $PWD:/opt/Home -p 8888:8888 jankierzkowski/neutrino_genie
exit
