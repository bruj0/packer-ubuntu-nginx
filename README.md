# packer-ubuntu-nginx
This repository has the Packer and Vagrant files to create a Virtualbox image that run Nginx under Ubuntu 18 and test it with Kitchen

# Validate the Packer config
* Set the correct token in the variable VAGRANT_CLOUD_TOKEN 
* Make sure you have access to the "box_tag"  image in Vagrant Cloud.
```
$ export VAGRANT_CLOUD_TOKEN="....."
$ packer validate nginx64.json
```

# Create the Virtualbox image

```
$ packer build -force nginx64.json
```

# Test that Nginx is installed
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