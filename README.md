# ansible-speedtest

The prupose of this repository is to benchmark ansible on configuration roles

## Context

The server is an OVH Public cloud instance:

    * flavor: hg-7-ssd
    * image: Debian 7
    * DC: BHS1
    * VCPUs: 2
    * RAM: 6.8G
    * Disk: 100G SSD

Software informations

```bash
$ cat /etc/debian_version
7.11

$ uname -a
Linux test-max-ansible 3.2.0-4-amd64 #1 SMP Debian 3.2.82-1 x86_64 GNU/Linux

$ cat /etc/apt/sources.list
deb http://debian.mirrors.ovh.net/debian/ wheezy main contrib non-free
deb-src http://debian.mirrors.ovh.net/debian/ wheezy main contrib non-free

deb http://debian.mirrors.ovh.net/debian-security/ wheezy/updates main
deb-src http://debian.mirrors.ovh.net/debian-security/ wheezy/updates main

$ python --version
Python 2.7.3

$ pip --version
pip 1.1 from /usr/lib/python2.7/dist-packages (python 2.7)

$ ansible --version
ansible 2.2.0.0
  config file =
  configured module search path = Default w/o overrides
```

Benchmark are performed on a Debian

## Installation

Requirements

```bash
$ apt-get install python-pip
$ pip install ansible
```

This will setup a default configuration

## Benchmark

From 1 entry to 1000:

```bash
$ time ansible-playbook apply_1-1000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0


real	0m2.601s
user	0m2.244s
sys	0m0.304s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
1000
```

from 1000 entries to 1000 (no changes):

```bash
$ time ansible-playbook apply_1-1000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0


real	0m2.578s
user	0m2.156s
sys	0m0.364s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
1000
```

from 1000 entries to 1:

```bash
$ time ansible-playbook apply_default.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0


real	0m1.388s
user	0m1.088s
sys	0m0.240s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
1
```

from 1 entry to 1 (no changes):

```bash
$ time ansible-playbook apply_default.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0


real	0m1.350s
user	0m1.016s
sys	0m0.292s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
1
```

from 1 to 10000:

```bash
$ time ansible-playbook apply_1-10000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0


real	0m11.750s
user	0m10.997s
sys	0m0.768s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
10000
```

from 10000 to 10000 (no changes):

```bash
$ time ansible-playbook apply_1-10000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf] ********************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0


real	0m12.305s
user	0m11.533s
sys	0m0.764s

$ cat /etc/ansible-benchmark/firewall.conf | wc -l
10000
```

from 0 to 10000 using 10 files, 1000 per file:

```bash
$ time ansible-playbook apply_10-1000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=10   unreachable=0    failed=0


real	0m6.771s
user	0m5.416s
sys	0m1.048s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
10000
```

from 10000 to 10000 using 10 files, 1000 per file (no changes):

```bash
$ time ansible-playbook apply_10-1000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=0    unreachable=0    failed=0


real	0m6.919s
user	0m5.524s
sys	0m1.120s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
10000
```

from 10000 to 10 using 10 files, 1 per file:

```bash
$ time ansible-playbook apply_10-1.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=10   unreachable=0    failed=0


real	0m3.610s
user	0m2.560s
sys	0m0.744s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
10
```

from 10 to 100000 using 10 files, 10000 per file:

```bash
$ time ansible-playbook apply_10-10000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=10   unreachable=0    failed=0


real	0m33.202s
user	0m29.974s
sys	0m3.376s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
100000
```

from 100000 to 100000 using 10 files, 10000 per file (no changes):

```bash
$ time ansible-playbook apply_10-10000.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
ok: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=0    unreachable=0    failed=0


real	0m32.528s
user	0m29.442s
sys	0m3.252s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
100000
```

from 100000 to 10 using 10 files, 1 per file:

```bash
$ time ansible-playbook apply_10-1.yml
 [WARNING]: Host file not found: /etc/ansible/hosts

 [WARNING]: provided hosts list is empty, only localhost is available


PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [config : Ensure /etc/ansible-benchmark directory] ************************
ok: [localhost]

TASK [config : Write firewall.conf.1] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.2] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.3] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.4] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.5] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.6] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.7] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.8] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.9] ******************************************
changed: [localhost]

TASK [config : Write firewall.conf.10] *****************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=12   changed=10   unreachable=0    failed=0


real	0m3.108s
user	0m2.220s
sys	0m0.628s

$ cat /etc/ansible-benchmark/firewall.conf.* | wc -l
10
```

## Benchmark using puppet

See `puppet` directory

```bash
$ puppet --version
3.7.2
```

from 0 to 100000 using 10 files, 10000 per file:

```bash
$ time puppet apply manifests/site.pp --modulepath=modules
Notice: Compiled catalog for test-max-ansible.local in environment production in 1.02 seconds
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.5]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.7]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.8]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.1]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.4]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.10]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.2]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.9]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.3]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.6]/ensure: defined content as '{md5}1171c16fe2002399cb7c6fa3ce891886'
Notice: Finished catalog run in 0.27 seconds

real	0m2.319s
user	0m1.864s
sys	0m0.220s
```

from 100000 to 100000 using 10 files, 10000 per file (no changes):

```bash
$ time puppet apply manifests/site.pp --modulepath=modules
Notice: Compiled catalog for test-max-ansible.local in environment production in 1.03 seconds
Notice: Finished catalog run in 0.07 seconds

real	0m2.110s
user	0m1.776s
sys	0m0.184s
```

from 0 to 10000 using 10 files, 1000 per file:

```bash
$ time puppet apply manifests/site.pp --modulepath=modules
Notice: Compiled catalog for test-max-ansible.local in environment production in 0.26 seconds
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.5]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.7]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.8]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.1]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.4]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.10]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.2]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.9]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.3]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: /Stage[main]/Config/File[/etc/puppet-benchmark/firewall.conf.6]/ensure: defined content as '{md5}4f19d463649940385a4175b372b163a7'
Notice: Finished catalog run in 0.15 seconds

real	0m1.510s
user	0m1.080s
sys	0m0.184s
```
