# PERDA for Linux on IBM Z

# Key aspect of the study
* Linux version
* Linux configuration
* Linux on IBM Z encryption libraries
* Linux crypto daemons
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

**$ icastats -v**
```
icastats: libica version 3.2.1
Copyright IBM Corp. 2009, 2010, 2011, 2014.
```

**$ icainfo -v**
```
icainfo: libica version 3.2.1
Copyright IBM Corp. 2007, 2016.
```

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

**$ sudo apt search opencryptoki**
```
Sorting... Done
Full Text Search... Done
libica-dev/bionic 3.2.1-0ubuntu1 s390x
  hardware cryptography support for IBM System z hardware (dev package)

libica-utils/bionic,now 3.2.1-0ubuntu1 s390x [installed]
  hardware cryptography support for Linux on z Systems (utils)

libica3/bionic,now 3.2.1-0ubuntu1 s390x [installed,automatic]
  hardware cryptography support for IBM System z hardware

libopencryptoki-dev/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (development)

libopencryptoki0/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (library)

opencryptoki/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (daemon)

tpm-tools-pkcs11/bionic 1.3.9.1-0.2ubuntu3 s390x
  Management tools for the TPM hardware (PKCS#11 tools)
...
```
# linux crypto daemons
**$ lsmod | grep aes_s390**
```
aes_s390               24576  0
```

**$ lsmod | grep des_s390**
```
des_s390               20480  0
des_generic            28672  1 des_s390
```

**$ lsmod | grep sha**
```
des_s390               20480  0
des_generic            28672  1 des_s390
```

**$ lsmod | grep rng**
```
s390_trng              16384  0
prng                   16384  0
```

**$ cat /proc/driver/z90cryp**
```
zcrypt version: 2.1.1
Cryptographic domain: 1
Total device count: 1
PCICA count: 0
PCICC count: 0
PCIXCC MCL2 count: 0
PCIXCC MCL3 count: 0
CEX2C count: 0
CEX2A count: 0
CEX3C count: 0
CEX3A count: 1
requestq count: 0
pendingq count: 0
Total open handles: 0
Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) 4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A 7=CEX3C 8=CEX3A
  0800000000000000 0000000000000000 0000000000000000 0000000000000000 
Waiting work element counts
  0000000000000000 0000000000000000 0000000000000000 0000000000000000 

Per-device successfully completed request counts
    00000000 00026b78 00000000 00000000 00000000 00000000 00000000 00000000
    00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
```

**$ lszcrypt**
```
card01: CEX5A
```

**$ lszcrypt -VVV**
```
card01: CEX5A       online  hwtype=11 depth=8 request_count=0 pendingq_count=0 requestq_count=0 functions=0x68800000
```

**$ lszcrypt -c 01**
```
card01 provides capability for:
RSA 4K Clear Key
```

**$ pkcsconf -t*
```
Token #3 Info:
Label: IBM OS PKCS#11                  
Manufacturer: IBM Corp.                       
Model: IBM SoftTok     
Serial Number: 123             
Flags: 0x880045 (RNG|LOGIN_REQUIRED|CLOCK_ON_TOKEN|USER_PIN_TO_BE_CHANGED|SO_PIN_TO_BE_CHANGED)
Sessions: 0/18446744073709551614
R/W Sessions: 18446744073709551615/18446744073709551614
PIN Length: 4-8
Public Memory: 0xFFFFFFFFFFFFFFFF/0xFFFFFFFFFFFFFFFF
Private Memory: 0xFFFFFFFFFFFFFFFF/0xFFFFFFFFFFFFFFFF
Hardware Version: 1.0
Firmware Version: 1.0
Time: 18:13:52
```

# Linux on IBM Z Data at rest environment

**$ sudo java -version**
```
Command 'java' not found, but can be installed with:

apt install default-jre            
apt install openjdk-11-jre-headless
apt install openjdk-8-jre-headless 

Ask your administrator to install one of them.
```

**$ sudo blkid**
```
/dev/dasda1: UUID="de305fe5-7eaa-4882-b002-aadb5901d60f" TYPE="ext4"
/dev/dasdb1: UUID="f6c3f5de-32f0-411b-a4c3-dbb41abc455c" TYPE="swap"
/dev/dasdc1: UUID="b48c5f7e-b954-421c-a3bc-9e93f5a0586b" TYPE="ext4"
```

**$ sudo dmsetup status
```
No devices found
```

**$ sudo df -h**
```
```

**$ sudo lvs**
```
```

**$ sudo vgs**
```
```

**$ sudo pvs**
```
```

# Linux on IBM Z Data in motion environment

**$ openssl version**
```
OpenSSL 1.1.0g  2 Nov 2017
```

**$ openssl engine -c**
```
(dynamic) Dynamic engine loading support
(ibmca) Ibmca hardware engine support
 [RAND, DES-ECB, DES-CBC, DES-OFB, DES-CFB, DES-EDE3, DES-EDE3-CBC, DES-EDE3-OFB, DES-EDE3-CFB, AES-128-ECB, AES-192-ECB, AES-256-ECB, AES-128-CBC, AES-192-CBC, AES-256-CBC, AES-128-OFB, AES-192-OFB, AES-256-OFB, AES-128-CFB, AES-192-CFB, AES-256-CFB, id-aes128-GCM, id-aes192-GCM, id-aes256-GCM, SHA1, SHA256, SHA512]
```


**$ ssh -V**
```
OpenSSH_7.6p1 Ubuntu-4, OpenSSL 1.0.2n  7 Dec 2017
```

**$ apache2 -v**
```
Server version: Apache/2.4.29 (Ubuntu)
Server built:   2018-06-27T17:05:04
```
