#What is the accelerated SDK?#

It's a SDK to build applications to Raspberry Pi board. It's accelerated because the build applications (toolchain, cmake, make, etc) have the same architecture as your desktop. It avoids the performance penalty you would suffer when running them with qemu.

The build performance is close to the desktop build.

**Important:** This chroot must not be used as rootfs.

#Installing the SDK#

###preparing the host machine###

**Ubuntu/Debian-based**
<pre>
  sudo apt-get install qemu-user-static
</pre>

**Archlinux**

Install the `binfmt-support` package from the AUR, available at https://aur.archlinux.org/packages/binfmt-support/
Refer to https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages for instructions on how to install packages from the AUR.

You will also need to use something like the following script to enable support for ARM (arm/armeb) program execution by the kernel. 

<pre>
#!/bin/sh
# enable automatic ARM (arm/armeb) program execution by the kernel

# load the binfmt_misc module
if [ ! -d /proc/sys/fs/binfmt_misc ]; then
    sudo /sbin/modprobe binfmt_misc
fi

if [ ! -f /proc/sys/fs/binfmt_misc/register ]; then
    sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
fi

# unregister if they exist
for a in arm armeb; do
    if [ -f /proc/sys/fs/binfmt_misc/${a} ]; then
        echo -1 | sudo tee /proc/sys/fs/binfmt_misc/${a} >/dev/null
    fi
done

# register the interpreter for each cpu except for the native one
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:C' | sudo tee /proc/sys/fs/binfmt_misc/register >/dev/null
echo ':armeb:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-armeb-static:C' | sudo tee /proc/sys/fs/binfmt_misc/register >/dev/null

for a in arm armeb; do
    if [ -f /proc/sys/fs/binfmt_misc/${a} ]; then
        echo 1 | sudo tee /proc/sys/fs/binfmt_misc/${a} >/dev/null
    fi
done
</pre>

Run the above script before starting the sdk. Notice it uses `/usr/bin/qemu-arm-static` and `/usr/bin/qemu-armeb-static`, but those programs will be available within the SDK, so there is no need to install `qemu` on the host system. 

###sdk tarball###

Use the latest one available at this repository.

<pre>
sudo tar xf rpi-sdk-x86_64.tar.xz
</pre>

###chroot start script###

Use the latest one available at this repository.

<pre>
chmod +x start-rpi-sdk
</pre>

**Suggestion**: Put it on a $PATH directory (/usr/bin, ~/bin, whatever...)

# Upgrading packages inside SDK #

Several binaries were manually copied from host machine to the chroot. The related packages were pinned (locked) to prevent their upgrade as we don't want to decrease the SDK performance.

It's safe to run <pre>sudo apt-get upgrade</pre> though. However, it's a good idea to be careful when doing the upgrade ;)

#Using the SDK#
<pre>
sudo start-rpi-sdk rpi-sdk
</pre>
**Important:** start-rpi-sdk does several mounts (proc, dev, devpts and sys) into chroot directories before chroot. After you leave the chroot, the script umounts these directories. It is also prepared to handle SIGINT and SIGTERM.  **However, check if there is something mounted before REMOVING the SDK directory to avoid the wasting of your /dev, for instance.**

#Building Nix (without icecc)#
<pre>
sudo start-rpi-sdk SDK_PATH

git clone git://github.com/WebKitNix/webkitnix.git
cd webkitnix

# Build Nix dependencies (except for webrtc, which doesn't currently build on the Pi)
Tools/Scripts/update-webkitnix-libs -s libwebrtc

# Build Nix in RELEASE.
Tools/Scripts/build-webkit --nix --cmakeargs="-DDISABLE_STRICT_BUILD=ON -DCMAKE_PREFIX_PATH=/opt/vc" --opengles2 --prefix=/opt/nix
</pre>

#Building Nix (with icecc)#

**Note 1**: This document assumes that you already have an icecc daemon configured and running in your **host** machine. You **don't** need to run the iceccd inside the chroot.
**Note 2**: The icecc binaries in the chroot are patched to work with this SDK, do not overwrite them.

<pre>
sudo start-rpi-sdk SDK_PATH

# Preparing environment to use icecc
mkdir icecc
pushd icecc
icecc --build-native
export ICECC_VERSION=/home/pi/icecc/`ls`
export ICECC_PLATFORM=x86_64    # Put your arch here
export PATH=/usr/lib/icecc/bin:$PATH
popd

git clone git://github.com/WebKitNix/webkitnix.git
cd webkitnix

# Build Nix dependencies (except for webrtc, which doesn't currently build on the Pi)
Tools/Scripts/update-webkitnix-libs -s libwebrtc

# Build Nix in RELEASE.
Tools/Scripts/build-webkit --nix --cmakeargs="-DDISABLE_STRICT_BUILD=ON -DCMAKE_PREFIX_PATH=/opt/vc"  --makeargs="-j100" --opengles2 --prefix=/opt/nix
</pre>

#Installing Nix#

### Installing Nix dependencies ###

You can install the nix dependencies that were built using jhbuild.

In the chroot:
<pre>
mkdir nix-deps
cp -a webkitnix/WebKitBuild/Dependencies/Root/* nix-deps/.
sed -i 's,/home/pi/.*/Root,/opt/nix-deps,' nix-deps/lib/pkgconfig/*.pc
sudo chown -R root.root nix-deps/*
sudo tar cf nix-deps.tar nix-deps/*
scp nix-deps.tar pi@&lt;rasp_ip_addr&gt;:
</pre>

In the RPi board:
<pre>
sudo mkdir /opt/nix-deps
sudo tar xf /home/pi/nix-deps.tar -C /opt
</pre>

### Installing Nix ###

In the chroot:
<pre>
cd webkitnix/WebKitBuild/Release
sudo make install
cd /opt
sudo tar cf nix.tar nix/*
scp nix.tar pi@&lt;rasp_ip_addr&gt;:
</pre>

In the RPi board:
<pre>
sudo mkdir /opt/nix
sudo tar xf /home/pi/nix.tar -C /opt
</pre>

#Troubleshooting#

###I can't chroot to the SDK###

When I issue the start-rpi-sdk script, I'm getting the following error:

<pre>
user@host:~$ sudo start-rpi-sdk rpi-sdk
Mounting directories...
chroot: failed to run command `/bin/su': No such file or directory
Umounting directories...
</pre>

####Cause 1: Something is wrong with your qemu-arm installation####

Check the following commands and outputs:
<pre>
user@host:~$ ls -l rpi-sdk/usr/bin/qemu-arm-static
-rwxr-xr-x 1 root root 3236664 Feb  1 21:57 rpi-sdk/usr/bin/qemu-arm-static
user@host:~$ cat /proc/sys/fs/binfmt_misc/qemu-arm
enabled
interpreter /usr/bin/qemu-arm-static
flags: OC
offset 0
magic 7f454c4601010100000000000000000002002800
mask ffffffffffffff00fffffffffffffffffeffffff
</pre>

####Cause 2: Your linux kernel is not x86_64####

The x86_64 binaries cannot run in i386 kernels. This SDK is specific to x86_64 system architectures.

Check your architecture by running:

<pre>
uname --hardware-platform
</pre>

If you want to have an i386 compatible SDK you must build it from scratch. This repository has all intructions, patches and sources needed to do such task. Just adapt the toolchain scripts to i386 architecture and voilá.

###I can't use **sudo** inside the chroot.###

I'm getting the following error:

<pre>
pi@machine:~$ sudo ls
sudo: effective uid is not 0, is /usr/bin/sudo on a file system with the 'nosuid' option set or an NFS file system without root privileges?
</pre>

####Cause 1: Incorrect SDK tarball extraction####

You may have incorrectly extracted the sdk tarball to you computer. You MUST use **sudo**:

<pre>
sudo tar xf rpi-sdk-x86_64.tar.xz
</pre>

####Cause 2: Buggy update-binfmt####

Although the link bellow is debian related, it may affect other distributions:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=683205

To solve the problem, first make sure the following file has the described content:

<pre>
pi@machine:~$ cat /usr/share/binfmts/qemu-arm
package qemu-user-static
interpreter /usr/bin/qemu-arm-static
credentials yes
offset 0
magic \x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00
mask \xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff
</pre>

Run the following commands:

<pre>
sudo update-binfmts --import qemu-arm
sudo update-binfmts --import qemu-arm # Yes, twice. Before complaining, read the bug link
</pre>

**Note that this solution is based on ubuntu/debian distribution. Maybe in your distribution, the qemu interpreter has a different name. Maybe the /usr/share/binfmts/qemu-arm file does not exists (is in another place?). So, be careful, do not copy-and-paste commands without understand what you're doing.**
