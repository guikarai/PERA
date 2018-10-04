# PERDA for Linux on IBM Z

# Key aspect of the study
* Linux version
* Linux configuration
* Linux on IBM Z encryption libraries
* Linux on IBM Z Data at rest environment
* Linux on IBM Z Data in motion environment

# Linux Version

**$ cat /etc/issue**
```
Ubuntu 18.04.1 LTS \n \l
```

**$ uname -r**
```
4.15.0-34-generic
```

## Linux Configuration

**$ lsmem**
```
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x00000000ffffffff   4G online        no  0-15

Memory block size:       256M
Total online memory:       4G
Total offline memory:      0B
```

**$ lscpu**
```
Architecture:        s390x
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              2
On-line CPU(s) list: 0,1
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s) per book:  1
Book(s) per drawer:  1
Drawer(s):           2
NUMA node(s):        1
Vendor ID:           IBM/S390
Machine type:        3906
CPU dynamic MHz:     5208
CPU static MHz:      5208
BogoMIPS:            21881.00
Hypervisor:          z/VM 6.4.0
Hypervisor vendor:   IBM
Virtualization type: full
Dispatching mode:    horizontal
L1d cache:           128K
L1i cache:           128K
L2d cache:           4096K
L2i cache:           2048K
L3 cache:            131072K
L4 cache:            688128K
NUMA node0 CPU(s):   0,1
Flags:               esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs sie
```

# Linux on IBM Z encryption libraries

**$ sudo apt search libica**
```     
Sorting... Done
Full Text Search... Done
libica-dev/bionic 3.2.1-0ubuntu1 s390x
  hardware cryptography support for IBM System z hardware (dev package)

libica-utils/bionic,now 3.2.1-0ubuntu1 s390x [installed]
  hardware cryptography support for Linux on z Systems (utils)

libica3/bionic,now 3.2.1-0ubuntu1 s390x [installed,automatic]
  hardware cryptography support for IBM System z hardware

...

```
**$ sudo apt search openssl-ibmca**
```
Sorting... Done
Full Text Search... Done
openssl-ibmca/bionic,now 1.4.1-0ubuntu1 s390x [installed]
  libica based hardware acceleration engine for OpenSSL
```


§ openSSL (libcrypto API)
– option: configure ibmca engine
– z14 GCM support via ibmca engine
§ openCryptoki (PKCS#11 API)
– with ica token (calls libica)
§ GSKit
– used by IBM software
– latest release supports Z14 CPACF
§ IBM Java 8 IBMJCE (JCE API)
§ latest release supports Z14 CPACF 

# Linux on IBM Z Data at rest environment


# Linux on IBM Z Data in motion environment

**$ sudo apt search openssl-ibmca**
```
Sorting... Done
Full Text Search... Done
openssl-ibmca/bionic,now 1.4.1-0ubuntu1 s390x [installed]

  libica based hardware acceleration engine for OpenSSL
```

