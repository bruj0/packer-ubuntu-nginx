  
default: all


all: kitchen

nginx64-vbox: nginx64.json ../scripts/nginx.sh http/preseed.cfg
	packer validate nginx64.json
	packer build -force nginx64.json

kitchen-vbox: box/virtualbox/nginx64-0.1.box
	bundle exec kitchen list
	bundle exec kitchen verify


kitchen: kitchen-vbox

.PHONY: clean
clean:
	-vagrant box remove -f xenial64 --provider virtualbox
	