#COLLECT INFORMATION ABOUT A DEBIAN, UBUNTU LINUX ENVIRONMENT
touch PERDA.LINUX.txt
echo "******************** THE FOLLOWING RESULTS OF A PERDA ASSESSMENT TOOL ********************" > PERDA.LINUX.txt
echo -e "\n#2 CPACF Enablement verification" >> PERDA.LINUX.txt
echo -e "\n##2_1 CPUINFO" >> PERDA.LINUX.txt
cat /proc/cpuinfo >> PERDA.LINUX.txt
echo -e "\n#3 Linux Version" >> PERDA.LINUX.txt
echo -e "\n##3_1 KERNEL" >> PERDA.LINUX.txt
uname -a >> PERDA.LINUX.txt
echo -e "\n##3_2 RELEASE" >> PERDA.LINUX.txt
cat /etc/*release* >> PERDA.LINUX.txt
echo -e "\n#4 Linux Configuration" >> PERDA.LINUX.txt
echo -e "\n##4_1 CPU" >> PERDA.LINUX.txt
lscpu >> PERDA.LINUX.txt
echo -e "\n##4_2 Memory" >> PERDA.LINUX.txt
lsmem >> PERDA.LINUX.txt
echo -e "\n##4_3 DASD" >> PERDA.LINUX.txt
lsdasd >> PERDA.LINUX.txt
echo -e "\n##4_4 Disk space" >> PERDA.LINUX.txt
df -h >> PERDA.LINUX.txt
echo -e "\n#5 Verification of support for Hardware Cryptographic operation" >> PERDA.LINUX.txt
echo -e "\n##5_1 libICA" >> PERDA.LINUX.txt
sudo apt search libica3 >> PERDA.LINUX.txt
echo -e "\n##5_2 icainfo version" >> PERDA.LINUX.txt
icainfo -v >> PERDA.LINUX.txt
echo -e "\n##5_3" icainfo>> PERDA.LINUX.txt
icainfo >> PERDA.LINUX.txt
echo -e "\n#5_4 icastats version" >> PERDA.LINUX.txt
icastats -v >> PERDA.LINUX.txt
echo -e "\n##5_5 icastats" >> PERDA.LINUX.txt
sudo icastats -A >> PERDA.LINUX.txt
echo -e "\n##5_6 opencryptoki libraries" >> PERDA.LINUX.txt
sudo apt search opencryptoki >> PERDA.LINUX.txt
echo -e "\n##5_7 mod aes" >> PERDA.LINUX.txt
lsmod | grep aes_s390 >> PERDA.LINUX.txt
echo -e "\n##5_8 mod des" >> PERDA.LINUX.txt
lsmod | grep des_s390 >> PERDA.LINUX.txt
echo -e "\n##5_9 mod sha" >> PERDA.LINUX.txt
lsmod | grep sha >> PERDA.LINUX.txt
echo -e "\n##5_10 mod rng" >> PERDA.LINUX.txt
lsmod | grep rng >> PERDA.LINUX.txt
echo -e "\n##5_11 adjunc processor device driver" >> PERDA.LINUX.txt
cat /proc/driver/z90cryp >> PERDA.LINUX.txt
echo -e "\n##5_12 adjunc processor device driver version" >> PERDA.LINUX.txt
lszcrypt -VVV >> PERDA.LINUX.txt
echo -e "\n##5_13 adjunc processor device driver stats" >> PERDA.LINUX.txt
lszcrypt -c 01 >> PERDA.LINUX.txt
echo -e "\n##5_14 OpenCryptoki token" >> PERDA.LINUX.txt
pkcsconf -t >> PERDA.LINUX.txt
echo -e "\n##5_15 JAVA version" >> PERDA.LINUX.txt
sudo java -version >> PERDA.LINUX.txt
echo -e "\n#7 Linux on IBM Z Data at rest environment" >> PERDA.LINUX.txt
echo -e "\n##7_1 BLKID" >> PERDA.LINUX.txt
sudo sudo blkid >> PERDA.LINUX.txt
echo -e "\n##7_2 DMSETUP" >> PERDA.LINUX.txt
sudo dmsetup status >> PERDA.LINUX.txt
echo -e "\n##7_3 LVS">> PERDA.LINUX.txt
sudo lvs >> PERDA.LINUX.txt
echo -e "\n##7_4 VGS" >> PERDA.LINUX.txt
sudo vgs >> PERDA.LINUX.txt
echo -e "\n##7_5 PVS" >> PERDA.LINUX.txt
sudo pvs >> PERDA.LINUX.txt
echo -e "\n##7_6 SWAPON" >> PERDA.LINUX.txt
swapon -s >> PERDA.LINUX.txt
echo -e "\n#8 Linux on IBM Z Data in motion environment" >> PERDA.LINUX.txt
echo -e "\n##8_1 OpenSSL-IBMCA" >> PERDA.LINUX.txt
sudo apt search openssl-ibmca >> PERDA.LINUX.txt
echo -e "\n##8_2 OpenSSL Version" >> PERDA.LINUX.txt
openssl version >> PERDA.LINUX.txt
echo -e "\n##8_3 OpenSSL Engine" >> PERDA.LINUX.txt
openssl engine -c >> PERDA.LINUX.txt
echo -e "\n##8_4 OpenSSH Version" >> PERDA.LINUX.txt
ssh -V >> PERDA.LINUX.txt
echo -e "\n##8_5 Apache Version" >> PERDA.LINUX.txt
apache2 -v >> PERDA.LINUX.txt
echo -e "\nEND OF PERDA DATA COLLECTION" >> PERDA.LINUX.txt
