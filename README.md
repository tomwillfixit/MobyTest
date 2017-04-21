# MobyTest

This repo will be used in future as an end-to-end test using infraKit, linuxKit and swarmKit.

# Disclaimer 

Although I'm a #DockerCaptain this stuff is new to me. With that in mind I'm playing about with the new moby tooling. 

# First attempt

Followed the steps [here](https://github.com/linuxkit/linuxkit) and installed moby locally.  Using the JenkinsOS.yml created a bootable .iso which ran an alpine based Jenkins container.

## Commands
```
moby build JenkinsOS.yml
moby run JenkinsOS

```

## Pros

Fairly straight forward
Fails fast if you are missing any dependencies

## Cons

Had to install a bunch of stuff locally like go, make, qemu etc

# Second attempt

Thought it would be even cooler to use Docker in Docker to run the moby tool, therefore avoiding messing with my host.

## Commands

```
docker build -t mobytest:jenkins .
docker run -it --privileged -v ${PWD}/images:/images mobytest:jenkins
```
 
When the commands complete you should have 4 images stored in ${PWD}/images.

That's as far as I got. Hope it helps some folks get up and running faster.

# Next steps

Start the image from inside the alpine container using qemu and verify it.

