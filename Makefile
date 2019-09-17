  
default: all


all: kitchen

xenial64-vbox.box: xenial64.json ../scripts/packages.sh http/preseed.cfg
	packer validate xenial64.json
	packer build -force -only=xenial64-vbox xenial64.json

xenial64-vmware.box: xenial64.json ../scripts/packages.sh http/preseed.cfg
	packer validate xenial64.json
	packer build -force -only=xenial64-vmware xenial64.json

kitchen-vbox: xenial64-vbox.box
	bundle exec kitchen test vbox

kitchen-vmware: xenial64-vmware.box
	bundle exec kitchen test vmware

kitchen: kitchen-vbox kitchen-vmware

.PHONY: clean
clean:
	-vagrant box remove -f xenial64 --provider virtualbox
	-vagrant box remove -f xenial64 --provider vmware_desktop
	-rm -fr output-*/ *.box
	