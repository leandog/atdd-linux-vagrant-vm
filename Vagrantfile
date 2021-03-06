# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/calculate_hardware.rb'
require_relative 'lib/os_detector.rb'

if ARGV[0] == "up" then
  has_installed_plugins = false

  unless Vagrant.has_plugin?("vagrant-timezone")
    system("vagrant plugin install vagrant-timezone")
    has_installed_plugins = true
  end

  if has_installed_plugins then
    puts "Vagrant plugins were installed. Please run `vagrant up` again to install the VM"
    exit
  end
end

vagrant_dir = File.expand_path(File.dirname(__FILE__))

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = :host
  end

  config.vm.box_check_update = false
  config.vm.box = "leandog/training-base"
  config.vm.hostname = "leandog-atdd-vm"
  config.ssh.forward_agent = true
  config.vm.synced_folder(".", "/vagrant")

  # Don't enforce TLS Certificate pinning because of Corporate Environment packet inspection systems
  config.vm.box_download_insecure = true

  config.vm.provider "virtualbox" do |vb|

    # Tell VirtualBox that we're expecting a UI for the VM
    vb.gui = true

    # Give the virtual machine a name
    vb.name = "LDATDDDev"

    # Enable sharing the clipboard
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]

    # Set # of CPUs and the amount of RAM, in MB, that the VM should allocate for itself, from the host
    CalculateHardware.set_minimum_cpu_and_memory(vb, 2, 2048)

    # Set Northbridge
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]

    # Set the amount of RAM that the virtual graphics card should have
    vb.customize ["modifyvm", :id, "--vram", "128"]

    # Advanced Programmable Interrupt Controllers (APICs) are a newer x86 hardware feature
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]

    # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Disable the serial port that is from Ubuntu Cloud master image
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
  end

  config.vm.provision "shell", path: "provision/bootstrap.sh", privileged: false

end
