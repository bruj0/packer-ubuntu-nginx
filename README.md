# packer-ubuntu-nginx
This repository has the Packer and Vagrant files to create a Virtualbox image that run Nginx under Ubuntu 18 and test it with Kitchen

## Dependencies and installation

* Packer v1.4.3: https://www.packer.io/docs/install/index.html
* Vagrant 2.2.5: https://www.vagrantup.com/docs/installation/
* VirtualBox: https://www.virtualbox.org/manual/ch02.html
* Kitchen: https://kitchen.ci/docs/getting-started/installing/

## Validate the Packer config
* Set the correct token in the variable VAGRANT_CLOUD_TOKEN 
* Make sure you have access to the "box_tag"  image in Vagrant Cloud.
```
$ export VAGRANT_CLOUD_TOKEN="....."
$ packer validate nginx64.json
```

## Create the Virtualbox image

```
$ packer build nginx64.json
```
## Test that Nginx is installed
* Initialize kitchen
```
$ bundle exec kitchen converge
```
* Check the output of the list to see if its in status converged
```
$ bundle exec kitchen list
```
* Run the tests
```
$ bundle exec kitchen verify
```

The output should be:
```
-----> Starting Kitchen (v2.3.2)
-----> Verifying <default-vbox-nginx64>...
verify_host_key: false is deprecated, use :never
       Loaded tests from {:path=>".Users.Projects.packer-ubuntu-nginx.test.integration.default"}

Profile: tests from {:path=>"/Users/Projects/packer-ubuntu-nginx/test/integration/default"} (tests from {:path=>".Users.Projects.packer-ubuntu-nginx.test.integration.default"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2200

  System Package nginx
     ✔  should be installed

Test Summary: 1 successful, 0 failures, 0 skipped
       Finished verifying <default-vbox-nginx64> (0m0.18s).
-----> Kitchen is finished. (0m1.73s)
```

## Upload the image to Vagrant Cloud
You must set this environment variables according to your environment:
```
MY_BASE_NAME: Your base name in Vagrant Cloud
MY_IMAGE_NAME: The name of your image in Vagrant Cloud
MY_VERSION: Image version
MY_PROVIDER: What type of image is it, ie virtualbox
```
Then run the ```pipeline.sh``` script:
```
$ ./pipeline.sh
==> Login to vagrant cloud with the token in the environment VAGRANT_CLOUD_TOKEN
==> Verify we are logged in
Currently logged in as User
==> Publish the image
You are about to publish a box on Vagrant Cloud with the following options:
User/nginx64:   (v0.1) for provider 'virtualbox'
Automatic Release:     true
==> cloud: Creating a box entry...
==> cloud: Creating a version entry...
==> cloud: Creating a provider entry...
==> cloud: Uploading provider with file /Users/User/Projects/packer-ubuntu-nginx/box/virtualbox/nginx64-0.1.box
==> cloud: Releasing box...
Complete! Published User/nginx64
tag:             User/nginx64
username:        User
name:            nginx64
private:         false
downloads:       0
created_at:      2019-09-19T07:51:06.669Z
updated_at:      2019-09-19T07:51:46.209Z
current_version: 0.1
providers:       virtualbox
old_versions:    ...
```
## DONE
- [x] Upload the image after it was tested 
- [x] Add dependencies to the README
- [x] Add how to install the tools to the README

## TODO

