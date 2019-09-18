# packer-ubuntu-nginx
This repository has the Packer and Vagrant files to create a Virtualbox image that run Nginx under Ubuntu 18 and test it with Kitchen

# Create Virtualbox image

```
$ make nginx64-vbox
```

# Test that Nginx is installed

```
$ make kitchen
bundle exec kitchen list
Instance              Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-vbox-nginx64  Vagrant  Shell        Inspec    Ssh        Verified     <None>
bundle exec kitchen verify
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