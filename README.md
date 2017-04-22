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
```
tom-laptop:/scratch/MobyTest# ls images
JenkinsOS-efi.iso  JenkinsOS-initrd.img  JenkinsOS.iso  JenkinsOS.vmdk
```

You can use VirtualBox or qemu to verify they boot successfully.

There is a handy script in the [linuxkit/scripts](https://github.com/linuxkit/linuxkit/tree/master/scripts) directory to boot the iso using qemu in a container.

Here are the manual steps. The QEMU_IMAGE will likely change :
```
QEMU_IMAGE=linuxkit/qemu:4563d58e97958f4941fbef9e74cabc08bd402144@sha256:b2db0b13ba1cbb6b48218f088fe0a4d860e1db2c4c6381b5416536f48a612230
FILE=/scratch/MobyTest/images/JenkinsOS.iso
BASE=$(basename "$FILE")
MOUNTS="-v $FILE:/tmp/$BASE"
DEVKVM="--device=/dev/kvm"

docker run -it --rm $MOUNTS $DEVKVM "$QEMU_IMAGE"

```

When the VM has booted you'll see something like : 
```
Welcome to LinuxKit

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

```

So far so good. What now?

### Runc

Check which containers are running :
```
/usr/bin/runc list

ID          PID         STATUS      BUNDLE                         CREATED                          OWNER
dhcpcd      693         running     /containers/services/dhcpcd    2017-04-22T00:25:00.450608657Z   root
jenkins     715         running     /containers/services/jenkins   2017-04-22T00:25:00.458477205Z   root
ntpd        729         running     /containers/services/ntpd      2017-04-22T00:25:00.815188054Z   root
```

We can see our Jenkins container, defined [here](JenkinsOS.yml) is running.

### Services and Filesystem

What is inside /containers/services/jenkins?
```
/containers/services/jenkins # ls
config.json  rootfs

```
The config.json is read-only and contains the metadata for the container service.
The rootfs contains the usual directories of a linux subsystem and our jenkins_home is in rootfs/var/jenkins_home.

# Summary

That's as far as I got. Hope it helps some folks get up and running faster. This is a nice way to use the commands we already know and try out linuxKit without installing tooling locally.

