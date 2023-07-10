#!/bin/bash
sudo docker run --name geniecontainer --rm -e DISPLAY=$DISPLAY -v $GENIE_IM_WDIR:/opt/Home -p 8888:8888 jankierzkowski/neutrino_genie
exit
