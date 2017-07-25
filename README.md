# atdd-linux-vagrant-vm
A Vagrant virtual machine already built with Ruby, RVM, RubyMine, SublimeText & Git installed. This VM is meant to be used in conjunction with the LeanDog ATDD course.

## Attention!

This project requires a relatively recent computer that supports Hardware Virtualization. You MUST make sure you have AMD-V or VT-x extensions enabled in your computer's BIOS otherwise the Virtual Machine will not boot!

## Host OS Requirements

  * VirtualBox 5.1.24 or higher [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
  * Vagrant 1.9.7 or higher [https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

## Basic Workflow

  * Download a copy of this repository as a zip file
  * Unzip the downloaded file on your local operating system
  * Open a terminal/command prompt (if on Windows, launch command prompt as an Administrator). Within the terminal, navigate to the unzipped folder.
  * Execute the command `vagrant up` - Downloads the pre-made box from the cloud, and generates a VM on your machine. This box is about 2GB in size, so it might take a while depending on your connection speed.
  * Once the machine is up, you should see the lock screen and the LeanDog logo on the desktop
  * You are now ready to do the exercises in the class

## Gotchas

### Confirm VT-x or AMD-V CPU Extension Support

Check your CPU on the Intel website to see if it supports VT-x. If you have an AMD processor, confirm that it supports AMD-V extensions. Then, make sure to turn on Virtualization support in your BIOS. Apple computers that have a compatible Intel processor already have the VT-x extensions enabled in EFI.

### Hyper-V interfering with VirtualBox

If needed, turn off Hyper-V (go to Windows Features on your machine and uncheck Hyper-v – in Windows 10 use the search box on the bottom toolbar to get to the Windows Features)
