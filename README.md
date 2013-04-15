#What is the accelerated SDK?#

It's a SDK to build applications to Raspberry Pi board. It's accelerated because the build applications (toolchain, cmake, make, etc) have the same architecture as your desktop. It avoids the performance penalty you would suffer when running them with qemu.

The build performance is close to the desktop build.

**Important:** This chroot must not be used as rootfs.

#Installing the SDK#

###preparing the host machine###
<pre>
  sudo apt-get install qemu-user-static
</pre>
###sdk tarball###

Use the latest one available at this repository.

<pre>
sudo tar xf rpi-sdk-20130405.tar.xz
</pre>

###chroot start script###

Use the latest one available at this repository.

<pre>
  chmod +x start-rpi-sdk
</pre>

**Suggestion**: Put it on a $PATH directory (/usr/bin, ~/bin, whatever...)

### Upgrading packages inside SDK ###

Several binaries were manually copied from host machine to the chroot. The related packages were pinned (locked) to prevent their upgrade as we don't want to decrease the SDK performance.

It's safe to run <pre>sudo apt-get upgrade</pre> though. However, it's a good idea to be careful when doing the upgrade ;)

#Using the SDK#
<pre>
  sudo start-rpi-sdk rpi-sdk
</pre>
**Important:** start-rpi-sdk does several mounts (proc, dev, devpts and sys) into chroot directories before chroot. After you leave the chroot, the script umounts these directories. It is also prepared to handle SIGINT and SIGTERM.  **However, check if there is something mounted before REMOVING the SDK directory to avoid the wasting of your /dev, for instance.**

#Building Nix#
<pre>
  sudo start-rpi-sdk SDK_PATH

  git clone git://github.com/WebKitNix/webkitnix.git
  cd webkitnix

  <b># Build Nix dependencies. It takes ~10min.</b>
  Tools/Scripts/update-webkitnix-libs

  <b># Build Nix in RELEASE. It takes ~50min</b>
  Tools/Scripts/build-webkit --nix --cmakeargs#"-DCMAKE_PREFIX_PATH#/opt/vc" --no-llint --opengles2 --prefix#/opt/nix
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
  sudo tar xf /home/pi/nix-deps.tar -C /opt/nix-deps
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
  sudo tar xf /home/pi/nix.tar -C /opt/nix
</pre>
