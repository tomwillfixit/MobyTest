#!/bin/bash

#Wouldn't be a demo without a bash script

# moby tool needs docker running to pull in images
exec dockerd &

# You will see some errors in the output. This can be ignored. Just complaining about the image not existing before it is pulled.

# ERRO[0522] Handler for POST /v1.23/containers/create returned error: No such image: linuxkit/mkimage-iso-bios:6ebdce90f63991eb1d5a578e6570dc1e5781e9fe@sha256:0c6116d4c069d17ebdaa86737841b3be6ae84f6c69a5e79fe59cd8310156aa96

#start the image build
moby build JenkinsOS.yml

#At this point you will have a bunch of images created based on the "format" specified in JenkinsOS.yml

# Copy them out to the host
# I didn't test this. Laptop almost dead and starbucks wifi is terrible.
mv * /images 
