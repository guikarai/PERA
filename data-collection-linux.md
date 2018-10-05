# Data collection procedure for a Pervasive Encryption Readiness & Deployment Assessment (Linux on IBM Z and KVM).
There are both sar data and Configuration/Display dumps to be collected.

# 1. SAR and Systems data

## Linux sar and processes performance data for 1-2 days
Sar data allow us to analyse your each Linux Guest and KVM Guest/Host crypto performance and their configuration to potentially detect bottleneck and propose optimization recommendations. Please Enable APPLDATA Stream from Linux to VM. Collect the sar data: 
```
sar -o OutFilename XXX YYY >/dev/null 2>&1 &
```
Note that **XXX** = collect interval in seconds and **YYY** = interval number

# 2. Configuration/Display data

A data collection script to be run for for each Linux and KVM Guest/Host can be find here under:
* RHEL, CentOS, ClefOS
* Ubuntu, Debian
* Suse, Opensuse

## 2.1. CPACF Enablement verification
A Linux on IBM Z user can easily check whether the Crypto Enablement feature is installed and which algorithms are supported in hardware. Hardware-acceleration for DES, TDES, AES, and GHASH requires CPACF. Read the features line from /proc/cpuinfo to discover whether the CPACF feature is enabled on your hardware.

**$ cat /proc/cpuinfo**
```
vendor_id       : IBM/S390
# processors    : 2
bogomips per cpu: 21881.00
features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx 
cache0          : level=1 type=Data scope=Private size=128K line_size=256 associativity=8
cache1          : level=1 type=Instruction scope=Private size=128K line_size=256 associativity=8
cache2          : level=2 type=Data scope=Private size=4096K line_size=256 associativity=8
cache3          : level=2 type=Instruction scope=Private size=2048K line_size=256 associativity=8
cache4          : level=3 type=Unified scope=Shared size=131072K line_size=256 associativity=32
cache5          : level=4 type=Unified scope=Shared size=688128K line_size=256 associativity=42
processor 0: version = FF,  identification = 233EF7,  machine = 3906
processor 1: version = FF,  identification = 233EF7,  machine = 3906
```
***Note:*** From the cpuinfo output, you can find the features that are enabled in the central processors.
If the features list has **msa** listed, it means that CPACF is enabled. 

## 2.2. Linux Version
Type uname -a. This will give you your kernel version, but might not mention the distribution your running. 

**$ uname -a**
```
Linux ghtstjav.mop.fr.ibm.com 4.4.0-109-generic #132-Ubuntu SMP Tue Jan 9 19:58:22 UTC 2018 s390x s390x s390x GNU/Linux
```

To find out what distribution of linux your running cat /etc/*release or cat /etc/issue* or cat /proc/version.

**$ cat /etc/*release***
```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.5 LTS"
NAME="Ubuntu"
VERSION="16.04.5 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.5 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

## 2.3. Linux Configuration

### CPU configuration
lscpu gathers CPU architecture information from sysfs, /proc/cpuinfo and any applicable architecture-specific libraries. The information includes, for example, the number of CPUs, threads, cores, sockets, and Non-Uniform Memory Access (NUMA) nodes. There is also information about the CPU caches and cache sharing, family, model, bogoMIPS, byte order, and stepping.

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

### Memory configuration
The lsmem command lists the ranges of available memory with their online status. The listed memory blocks correspond to the memory block representation in sysfs. The command also shows the memory block size and the amount of memory in online and offline state.

**$ lsmem**
```
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x00000000ffffffff   4G online        no  0-15

Memory block size:       256M
Total online memory:       4G
Total offline memory:      0B
```

### DASD configuration
Use the lsdasd command to gather information about DASD devices from sysfs and display it in a summary format.

**$ lsdasd**
```
Bus-ID     Status      Name      Device  Type  BlkSz  Size      Blocks
==============================================================================
0.0.0100   active      dasda     94:0    ECKD  4096   7042MB    1802880
0.0.1000   active      dasdb     94:4    ECKD  4096   20480MB   5243040
0.0.1001   active      dasdc     94:8    ECKD  4096   5120MB    1310760
```

### Disk space
The df command reports the amount of available disk space being used by file systems.

**$ df -h**
```
Filesystem                 Size  Used Avail Use% Mounted on
udev                       895M     0  895M   0% /dev
tmpfs                      181M   19M  162M  11% /run
/dev/dasda1                6.7G  2.6G  3.8G  41% /
tmpfs                      902M  720K  901M   1% /dev/shm
tmpfs                      5.0M     0  5.0M   0% /run/lock
tmpfs                      902M     0  902M   0% /sys/fs/cgroup
/dev/mapper/vg5964-lv5964   20G  5.0G   14G  27% /var/lib/docker
tmpfs                      181M     0  181M   0% /run/user/0
none                        20G  5.0G   14G  27% /var/lib/docker/aufs/mnt/8712743acd63f27d6816a2acaca253f1fb407a0a56db76f62d411eac061fc47e
shm                         64M     0   64M   0% /var/lib/docker/containers/5f802e174e52956443c01228d213536b315c4411157c194138ea5fc223bbaf79/shm
none                        20G  5.0G   14G  27% /var/lib/docker/aufs/mnt/7122ae3c8417d9d30d5b5138f95137ef23cb8cd8c6bee49a8b852645e3e81bfc
shm                         64M     0   64M   0% /var/lib/docker/containers/65a198b05dad2c67c4f3ec465076661936356f403e98e80ee479dc1fcaec080c/shm
none                        20G  5.0G   14G  27% /var/lib/docker/aufs/mnt/35d493e285a2241ca1b8c44c475f02d8bc9caeb4d0468c6e6f39ec615adda2d6
shm                         64M     0   64M   0% /var/lib/docker/containers/0e20927b1e084a39671f1360274b1f56c67c266306b1eb70af253d4375eed61b/shm
none                        20G  5.0G   14G  27% /var/lib/docker/aufs/mnt/2b84e7c0a6f6576ee9ceba551b88102f9c184993c4c5cd4a2f16d75901f22653
shm                         64M     0   64M   0% /var/lib/docker/containers/13357e6d4a031801b5da3b4a3610aa6867704cf5e2c6f4096e1b24eaa640f533/shm
```

## 2.4. Verification of support for Hardware Cryptographic operation

### libICA
To make use of the libica hardware support for cryptographic functions, must be install the libica version 3.0 package. it Depending on the distribution and installation parameters, some or all of them might be already installed with your initial setup.

**$ sudo apt search libica3**
```     
sudo apt search libica3
Sorting... Done
Full Text Search... Done
libica3/bionic,now 3.2.1-0ubuntu1 s390x [installed,automatic]
  hardware cryptography support for IBM System z hardware
```

The libICA package provides a command icainfo that lists the libICA supported cryptographic operations for an IBM Z system. 

**$ icainfo -v**
```
icainfo: libica version 3.2.1
Copyright IBM Corp. 2007, 2016.
```

The icainfo command to check on the CPACF feature code enablement. If the Crypto Enablement feature 3863 is installed, you will see that besides SHA, other algorithms are available with hardware support. The icainfo command displays which CPACF functions are supported by the implementation inside the libica library. 

**$ icainfo**
```
      Cryptographic algorithm support      
-------------------------------------------
 function      |  hardware  |  software  
---------------+------------+------------
         SHA-1 |    yes     |     yes
       SHA-224 |    yes     |     yes
       SHA-256 |    yes     |     yes
       SHA-384 |    yes     |     yes
       SHA-512 |    yes     |     yes
      SHA3-224 |    yes     |      no
      SHA3-256 |    yes     |      no
      SHA3-384 |    yes     |      no
      SHA3-512 |    yes     |      no
     SHAKE-128 |    yes     |      no
     SHAKE-256 |    yes     |      no
         GHASH |    yes     |      no
         P_RNG |    yes     |     yes
  DRBG-SHA-512 |    yes     |     yes
        RSA ME |     no     |     yes
       RSA CRT |     no     |     yes
       DES ECB |    yes     |     yes
       DES CBC |    yes     |     yes
       DES OFB |    yes     |      no
       DES CFB |    yes     |      no
       DES CTR |    yes     |      no
      DES CMAC |    yes     |      no
      3DES ECB |    yes     |     yes
      3DES CBC |    yes     |     yes
      3DES OFB |    yes     |      no
      3DES CFB |    yes     |      no
      3DES CTR |    yes     |      no
     3DES CMAC |    yes     |      no
       AES ECB |    yes     |     yes
       AES CBC |    yes     |     yes
       AES OFB |    yes     |      no
       AES CFB |    yes     |      no
       AES CTR |    yes     |      no
      AES CMAC |    yes     |      no
       AES XTS |    yes     |      no
       AES GCM |    yes     |      no
-------------------------------------------
No built-in FIPS support.
```

Use the icastats utility to find out whether libICA uses hardware acceleration features or works with software fallbacks. 

**$ icastats -v**
```
icastats: libica version 3.2.1
Copyright IBM Corp. 2009, 2010, 2011, 2014.
```

icastats displays statistic data about the usage of cryptographic functions provided by libica. libICA is a cryptographic library supporting SHA, RSA, DES and AES in different modes of operations. The invocation of each call to all the cryptographic functions is tracked with individual counters which can be displayed and maintained with icastats.

**$ sudo icastats -A**
```
user: root
 function     |           hardware       |            software
--------------+--------------------------+-------------------------
              |      ENC    CRYPT   DEC  |      ENC    CRYPT   DEC 
--------------+--------------------------+-------------------------
        SHA-1 |               0          |                0
      SHA-224 |               0          |                0
      SHA-256 |               0          |                0
      SHA-384 |               0          |                0
      SHA-512 |               0          |                0
     SHA3-224 |               0          |                0
     SHA3-256 |               0          |                0
     SHA3-384 |               0          |                0
     SHA3-512 |               0          |                0
    SHAKE-128 |               0          |                0
    SHAKE-256 |               0          |                0
        GHASH |               0          |                0
        P_RNG |               0          |                0
 DRBG-SHA-512 |             336          |                0
       RSA-ME |               0          |                0
      RSA-CRT |               0          |                0
      DES ECB |         0              0 |         0             0
      DES CBC |         0              0 |         0             0
      DES OFB |         0              0 |         0             0
      DES CFB |         0              0 |         0             0
      DES CTR |         0              0 |         0             0
     DES CMAC |         0              0 |         0             0
     3DES ECB |         0              0 |         0             0
     3DES CBC |         0              0 |         0             0
     3DES OFB |         0              0 |         0             0
     3DES CFB |         0              0 |         0             0
     3DES CTR |         0              0 |         0             0
    3DES CMAC |         0              0 |         0             0
      AES ECB |         0              0 |         0             0
      AES CBC |         0              0 |         0             0
      AES OFB |         0              0 |         0             0
      AES CFB |         0              0 |         0             0
      AES CTR |         0              0 |         0             0
     AES CMAC |         0              0 |         0             0
      AES XTS |         0              0 |         0             0
      AES GCM |         0              0 |         0             0
```

### openCryptoki for PKCS#11
openCryptoki is a PKCS#11 library and tools for Linux. It includes tokens supporting TPM and IBM crypto hardware as well as a software token.

**$ sudo apt search opencryptoki**
```
Sorting... Done
Full Text Search... Done
libopencryptoki-dev/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (development)

libopencryptoki0/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (library)

opencryptoki/bionic-updates 3.9.0+dfsg-0ubuntu1.1 s390x
  PKCS#11 implementation (daemon)
```

### Crypto modules
Use the lsmod command to check whether the crypto device driver module is already loaded. If the module is not loaded, use the modprobe command to load the device driver module. The cryptographic device driver consists of multiple, separate modules.

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

For the Linux virtual machine to gain access to the crypto card, you must load a specialized crypto device driver. By default, the device drivers that are required for Crypto processing are not loaded.

**$ lszcrypt**
If the device driver is loaded:
```
card01: CEX5A
```
If the device driver is not loaded:
```
lszcrypt: error - cryptographic device driver zcrypt is not loaded!
```

**$ lszcrypt -VVV**
If the device driver is loaded:
```
card01: CEX5A       online  hwtype=11 depth=8 request_count=0 pendingq_count=0 requestq_count=0 functions=0x68800000
```
If the device driver is not loaded:
```
lszcrypt: error - cryptographic device driver zcrypt is not loaded!
```

**$ lszcrypt -c 01**
If the device driver is loaded:
```
card01 provides capability for:
RSA 4K Clear Key
```
If the device driver is not loaded:
```
lszcrypt: error - cryptographic device driver zcrypt is not loaded!
```

**$ pkcsconf -t**
If the openCryptoki daemon is loaded:
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
If the openCryptoki daemon is not loaded:
```
Command 'pkcsconf' not found, but can be installed with:

apt install opencryptoki
Please ask your administrator.
```

### Java

**$ sudo java -version**
If java is installed:

If java is not installed:
```
Command 'java' not found, but can be installed with:

apt install default-jre            
apt install openjdk-11-jre-headless
apt install openjdk-8-jre-headless 

Ask your administrator to install one of them.
```

## 2.5. Linux on IBM Z Data at rest environment

**$ sudo blkid**
```
/dev/dasda1: UUID="de305fe5-7eaa-4882-b002-aadb5901d60f" TYPE="ext4"
/dev/dasdb1: UUID="f6c3f5de-32f0-411b-a4c3-dbb41abc455c" TYPE="swap"
/dev/dasdc1: UUID="b48c5f7e-b954-421c-a3bc-9e93f5a0586b" TYPE="ext4"
```

**$ sudo dmsetup status
```
vg5964-lv5964: 0 41934848 linear 
```


**$ sudo lvs**
```
LV     VG     Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv5964 vg5964 -wi-ao---- 20.00g    
```

**$ sudo vgs**
```
VG     #PV #LV #SN Attr   VSize  VFree
  vg5964   1   1   0 wz--n- 20.00g    0 
```

**$ sudo pvs**
```
PV          VG     Fmt  Attr PSize  PFree
  /dev/dasdb1 vg5964 lvm2 a--  20.00g    0 
```

**$ swapon -s**
```
Filename				Type		Size	Used	Priority
/dev/dasdc1                            	partition	5242940	583996	0
```

## 2.6. Linux on IBM Z Data in motion environment

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
