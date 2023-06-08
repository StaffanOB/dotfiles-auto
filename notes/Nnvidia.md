# How to Install Nvidia Drivers on Debian Linux 11 or 10 - LinuxCapable
Most users always seek to get more performance out of their graphics cards. One
of the better ways is to install Nvidia Drivers, which depending on your
installation method, comes with an open-source variant. The following tutorial
will teach you how to install Nvidia Graphic Drivers on Debian 11 Buster or
Debian 11 Bullseye repositories and to install Nvidia drivers directly from
Nvidia repositories, with open-source and proprietary drivers available.


Update Debian
-------------
Before proceeding with the tutorial, ensuring your system is up-to-date with
all existing packages is good.


```
sudo apt update
```

Optionally, you can list the updates for users who require review or are curious.

```
sudo apt --list upgradable
```
Proceed to upgrade any outdated packages using the following command.

```
sudo apt upgrade
```

### Previous Nvidia Installations
Please note installing Nvidia drivers over the standard packages can result in
unexpected issues, especially if you install the Nvidia drivers from Debian’s
repository, then import the Nvidia Cuda repository and try to re-install or
upgrade directly over those packages. If you use one method, stick to it, and
if you want to swap, ensure you remove the previous installation to avoid
conflicts.

Below I will briefly go through some options for removing the previous Nvidia Drivers.

First, use a blanket command to remove any traces of Nvidia installation on your system.

```
sudo apt autoremove nvidia* --purge
```
The second method is for anyone that installed the Nvidia drivers using the
**“.run”** file, a method I use suggest as an installation method but is shared
amongst other Linux blogs. Given the alternatives using the Nvidia Cuda
repository, I recommend using this over runfile installations.

To remove the runfile type of installation, use the following command.

```
sudo /usr/bin/nvidia-uninstall
```


Lastly, remove the CUDA toolkit runfile installation using the following command.

```
sudo /usr/local/cuda-X.Y/bin/cuda-uninstall
```


These few methods may remove the Nvidia Drivers.

#1st Method: Install NVIDIA Drivers: Debian Repository
------------------------------------------------------

### Installation Pre setup

The first task is enabling the **“contrib”** and **“non-free”** repositories to
your Debian repositories. This can be quickly done using the following
commands.

First, add the contrib repository.

```
sudo add-apt-repository contrib
```


Now add the non-free repository.

```
sudo add-apt-repository non-free
```


Once added, update your repository list.

```
sudo apt update
```


Before installing any Nvidia drivers, you will need to install the proper
kernel headers for the NVIDIA driver to build with. You can install either
64bit or 32bit, and you can find this out by running the lscpu command:

```
lscpu | grep CPU
```


_Example output:_

```
CPU op-mode(s):                  32-bit, 64-bit
CPU(s):                          2
On-line CPU(s) list:             0,1
CPU family:                      23
CPU MHz:                         3900.025
NUMA node0 CPU(s):               0,1
```


From the output, the system is 64bit, so the following headers need to be
installed.

```
sudo apt install linux-headers-amd64
```


32-bit Debian systems, use the following command instead.

**DO NOT USE THE BELOW COMMANDS IF YOU ARE ON A 64-BIT SYSTEM.**

_**32-bit non-PAE kernel:**_

```
sudo apt install linux-headers-686
```


_**32-bit PAE kernel:**_

```
sudo apt install linux-headers-686-pae
```


### Install Nvidia Drivers

Next, you can install the **“nvidia-detect,”** which will automatically suggest
the best package for your graphics card.

To do this, use the following command:

```
sudo apt install nvidia-detect
```


Now that Nvidia-detect is installed run the command to check your current
Nvidia Graphics Card:

```
nvidia-detect
```


The output has shown the machine in the example has a GeForce GTX 1650 card and
that it is recommended to install the **nvidia-driver package**, but this is
just a recommendation.

Next, install the recommended package:

```
sudo apt install nvidia-driver linux-image-amd64
```


You will see a note about the free Nouveau graphics driver conflicting with the
installed new driver. As per the message, you need to reboot to correct this;
for now, press the **“ENTER KEY”** to proceed.

Once installed, reboot your system.

```
reboot now
```


Once logged back in, run the **“nvidia-smi”** command to confirm the new Nvidia
Drivers have been installed.

```
nvidia-smi
```


### Install Nvidia Legacy Drivers

If your Nvidia Graphics card is quite old from 400 Series downwards, you will
need to install the legacy drivers. The process is the same, just with a new
install command:

```
sudo apt install nvidia-legacy-390xx-driver firmware-misc-nonfree -y
```


Once complete, do not forget to reboot your system.

```
sudo reboot now
```


Next, run the **“nvidia-smi”** command to verify the installation.

```
nvidia-smi
```


The 340 series can technically be installed; however, it is no longer
supported, and several major security flaws exist in those drivers. It is not
advised to install these drivers if you need to replace 390xx with 340xx, but
Debian does not recommend this.

#2nd Method: Install Nvidia Drivers – Nvidia Repository
-------------------------------------------------------

The second method will install the latest drivers for your desktop or server
using the Cuda repository. I would recommend using these drivers since when an
update is released, you will receive it straight away. This is good for
security and performance since Nvidia often does new releases, and now you can
install the open-source option.

### Determine your Graphics Card

The first step for users with aging NVIDIA Graphics cards is to determine what
it is and if it is supported, users with brand new cards can skip this part as
there is no doubt they will be supported.

First, find your graphics card module.

```
lspci | grep -e VGA
```


_Example output:_

```
03:00.0 VGA compatible controller: NVIDIA Corporation TU117 [GeForce GTX 1650] (rev a1)
```


### Importing Nvidia Repository

First, ensure you install the following packages, which may be already installed.

```
sudo apt install dirmngr ca-certificates software-properties-common apt-transport-https dkms curl -y
```


Next, import the GPG key, and ensure you match the import to your distribution
version.

#### Import GPG key for Debian 11 Bullseye:

```
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1
```


#### Import GPG key for Debian 10 Buster:

```
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/3bf863cc.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1
```


Second, import the repository for your Debian system, and again ensure you
import the correct one to match your Debian distribution version.

#### Import Nvidia Repository for Debian 11 Bullseye:

```
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list
```


#### Import Nvidia Repository for Debian 10 Buster:

```
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list
```


Enable the **CONTRIB** repository. Run this even if you already have it enabled
to be safe.

```
sudo add-apt-repository contrib
```


### Install Nvidia Drivers – Proprietary or Opensource options
Update your sources list to reflect the newly added repository.

```
sudo apt update
```


Next, install the latest NVIDIA drivers.

Install NVIDIA Drivers Without Cuda Support (Proprietary):

```
sudo apt install nvidia-driver nvidia-smi nvidia-settings
```


Install NVIDIA Drivers With Cuda Support (Proprietary):

```
sudo apt install nvidia-driver cuda nvidia-smi nvidia-settings
```


Install NVIDIA Drivers Without Cuda Support (Opensource):

```
sudo apt install nvidia-driver nvidia-kernel-open-dkms nvidia-smi nvidia-settings
```


Install NVIDIA Drivers With Cuda Support (Opensource):

```
sudo apt install nvidia-driver nvidia-kernel-open-dkms cuda nvidia-smi nvidia-settings
```


Note that the download is large and can take a while; given this is a general
release, it is recommended to install all the drivers to avoid any issues or
inconsistencies on your Debian desktop.

One good thing about the Nvidia repository installation is that if you forgot
to remove the previous one, you would see a prompt for users with pre-existing
installations before the installation continues. Select **Yes** to remove any
existing drivers, failure to do this may cause system instability. Once done,
the installation will be complete.

Once the installation is complete, you will be prompted to reboot your PC to
enable the NVIDIA drivers.

_Example:_

Reboot your system once done.

```
sudo reboot
```


Verify the installation by running NVIDIA-SMI as the manual installation steps
showed beforehand.

```
nvidia-smi
```


_Example output:_

Alternatively, you can open the GUI for desktop users using the following command.

```
nvidia-settings
```


Or open the application icon located in the following path.

**_Activities > Show Applications > Nvidia X Server_**

_Example output:_

### Install 32-bit Support for Nvidia Drivers

32-bit support can be easily enabled and installed first. Install the 64-bit
drivers above, then proceed with the following steps.

First, enable 32-bit architecture.

```
sudo dpkg --add-architecture i386
```


Update the APT-CACHE to reflect the changes to the architecture.

```
sudo apt update
```


Install 32-bit support, and remove the Cuda package **“libcuda1-i386”** for
those users not requiring it.

```
sudo apt install libcuda1-i386 nvidia-driver-libs-i386
```


Reboot your PC.

```
sudo reboot
```


Conclusion
----------

The tutorial has demonstrated two methods of installing the Nvidia Drivers on
your Debian system. Please take care doing this; like with custom kernel,
custom driver installs can be troublesome; anyone on Linux should utilize the
vast amount of free backup utilities in case things go pair shaped.
