# How to Install VirtualBox on Debian 11 (Bullseye): A Step-by-Step Guide
**This tutorial shows the easiest way to install VirtualBox on Debian 11, a
general-purpose full virtualizer app for x86 hardware.**

VirtualBox is cross-platform, free, and open-source software that allows you to
virtualize the x86 computing architecture. It has allowed open-source
enthusiasts and IT professionals to host many operating systems on a single
host machine for years.

Although VirtualBox is primarily aimed at home users, it is also commonly
utilized in professional environments.

Unfortunately, in Debian’s case, due to a lack of cooperation from upstream on
security support for older releases, VirtualBox is unavailable for installation
in the official Debian stable repositories.

However, there is an effortless way to install VirtualBox on Debian 11, which
we will show you in this guide.

Install VirtualBox on Debian 11 (Bullseye)
------------------------------------------

The tutorial will use the `sudo` command and assuming you have sudo privileges.

Step 1: Download and Import VirtualBox’s GPG Keys
-------------------------------------------------

To ensure that the packages we receive to install the VirtualBox are genuine,
first, we should download and import the VirtualBox signed GPG keys on our
Debian 11 system.

To do so, type the following commands:

```
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg
```


![Import VirtualBox’s repository GPG Key](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-add-key.png)

Import VirtualBox’s repository GPG Key.

Notice that the command produces no output.

Step 2: Add VirtualBox Repository for Debian 11
-----------------------------------------------

After importing the GPG keys, we’ll add the official VirtualBox repository to
our Debian 11 system. This implies that the update package will be made
available with the rest of your system’s regular updates if a new version is
released.

To accomplish it, type the command shown below.

```
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bullseye contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
```


![Add VirtualBox Repository for Debian 11](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-add-repository.png)

Add VirtualBox Repository for Debian 11.

Step 3: Run System Update
-------------------------

Before we proceed with VirtualBox installation on our Debian 11 system, we
should update the list of available packages. So, run the below command to
update the APT repositories index.

```
sudo apt update
```


![Updating the list of available packages](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-apt-update.png)

Updating the list of available packages.

As you can see, our new VirtualBox repository is now available and ready to be
used.

Step 4: Install VirtualBox on Debian 11 (Bullseye)
--------------------------------------------------

Everything is already prepared for the actual installation. Now, to install
VirtualBox on Debian 11, run the following commands:

```
sudo apt install virtualbox-7.0
```


When prompted, type `Y` to confirm that you want to install it and press `Enter`.

![Installing VirtualBox on Debian 11 (Bullseye)](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-install-virtualbox-7.png)

Installing VirtualBox on Debian 11 (Bullseye).

That’s all. The VirtualBox is installed and ready to be used on your Debian 11
Linux system.

Step 5: Install VirtualBox Extension Pack
-----------------------------------------

This is an optional step, but I strongly encourage it because it will make
working with VirtualBox on your Debian system easier and more convenient.
VirtualBox Extension Pack unlocks many great features, such as:

*   USB 2 and USB 3 support
*   VirtualBox Remote Desktop Protocol (VRDP)
*   Host webcam passthrough
*   Disk image encryption with AES algorithm
*   Intel PXE boot ROM

One peculiarity should be highlighted here. The VirtualBox Extension Pack’s
version must match the version of VirtualBox installed on your Debian 11
system.

So, to verify the exact version of the installed locally VirtualBox, you can
use `vboxmanage`, a build-in VirtualBox’s command:

```
vboxmanage -v | cut -dr -f1
```


![Check the installed VirtualBox version](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-virtualbox-version.png)

Check the installed VirtualBox version.

As you can see, the version of Virtualbox installed is `7.0.6`. Therefore, the
Extension Pack with the same version must then be downloaded.

So, use the below `wget` command to download the Extension Pack for VirtualBox.

If your installation is different, replace both places containing `7.0.6` in
the command below with the current version. In addition, you can also go
straight to the downloads page and look at the available versions.

```
wget https://download.virtualbox.org/virtualbox/7.0.6/Oracle_VM_VirtualBox_Extension_Pack-7.0.6.vbox-extpack
```


Next, to install the VirtualBox Extension pack, run the `vboxmanage` command as
follows:

```
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.6.vbox-extpack
```


When prompted to agree the Oracle’s license terms and conditions, type `y` to
confirm and press `Enter`.

![Installing VirtualBox Extension Pack](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-pack-install.png)

Install VirtualBox Extension Pack.

You can verify that the extension pack was installed correctly by running:

```
vboxmanage list extpacks
```


![List installed VirtualBox Extension Packs](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-extpack-version.png)

List installed VirtualBox Extension Packs.

Step 6: Add User to vboxusers Group
-----------------------------------

Before using VirtualBox, you should add your user account to the `vboxusers`
group. This is quick and simple to accomplish by running:

```
sudo usermod -a -G vboxusers $USER
```


Now perform a reboot. After login, check that you are in the `vboxusers` group
with this command:

```
groups $USER
```


![Add user to vboxusers group](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-list-groups.png)

Add user to vboxusers group.

Step 7: Running VirtualBox on Debian 11
---------------------------------------

You can start using VirtualBox by launching it from the desktop environment’s
application menu.

![Starting VirtualBox](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-debian-launcher.jpg)

Starting VirtualBox.

![VirtualBox is installed and running on Debian 11.](https://linuxiac.b-cdn.net/wp-content/uploads/2022/05/vbox-running-on-debian-11.jpg)

VirtualBox is installed and running on Debian 11.

Conclusion
----------

That concludes our guide on installing VirtualBox on Debian 11 (Bullseye). We
hope you find this guide helpful. Thanks for your time!

We recommend checking the official documentation for individuals who want to
learn more about the features offered by VirtualBox and how to use them
effectively.

Your feedback and comments are most welcome.
