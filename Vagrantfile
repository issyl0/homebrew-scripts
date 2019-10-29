Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "microscopium"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--usb', 'on']
    # This is my red Yubikey.
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'SmartCard', '--vendorid', '0x1050', '--productid', '0x0407']
  end

 config.vm.provision :shell, path: "homebrew-linux-maintainer-setup.sh", privileged: false
end
