#COLLECT INFORMATION ABOUT A DEBIAN, UBUNTU LINUX ENVIRONMENT
touch PERDA.LINUX.txt
echo "******************** THE FOLLOWING RESULTS OF A PERDA ASSESSMENT TOOL ********************" >> PERDA.LINUX.txt
echo "#2_1" >> PERDA.LINUX.txt
cat /proc/cpuinfo >> PERDA.LINUX.txt
echo "#3_1" >> PERDA.LINUX.txt
cat uname -a >> PERDA.LINUX.txt
echo "#3_2" >> PERDA.LINUX.txt
cat */etc/release* >> PERDA.LINUX.txt
echo "#4_1" >> PERDA.LINUX.txt
lscpu >> PERDA.LINUX.txt
echo "#4_2" >> PERDA.LINUX.txt
lsmem >> PERDA.LINUX.txt
echo "#4_3" >> PERDA.LINUX.txt
lsdasd >> PERDA.LINUX.txt
echo "#4_4" >> PERDA.LINUX.txt
df -h >> PERDA.LINUX.txt
echo "#5_1" >> PERDA.LINUX.txt
sudo apt search libica3 >> PERDA.LINUX.txt
echo "#5_2" >> PERDA.LINUX.txt
icainfo -v >> PERDA.LINUX.txt
echo "#5_3" >> PERDA.LINUX.txt
icainfo >> PERDA.LINUX.txt
echo "#5_4" >> PERDA.LINUX.txt
icastats -v >> PERDA.LINUX.txt
echo "#5_5" >> PERDA.LINUX.txt
sudo icastats -A >> PERDA.LINUX.txt
echo "#5_6" >> PERDA.LINUX.txt
sudo apt search opencryptoki >> PERDA.LINUX.txt
echo "#5_7" >> PERDA.LINUX.txt
lsmod | grep aes_s390 >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
lsmod | grep des_s390 >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
lsmod | grep sha >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
lsmod | grep rng >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
cat /proc/driver/z90cryp >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
lszcrypt -VVV >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
lszcrypt -c 01 >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
pkcsconf -t >> PERDA.LINUX.txt
echo "#1_1" >> PERDA.LINUX.txt
sudo java -version >> PERDA.LINUX.txt
echo "#7_1" >> PERDA.LINUX.txt
sudo sudo blkid >> PERDA.LINUX.txt
echo "#7_2" >> PERDA.LINUX.txt
sudo dmsetup status >> PERDA.LINUX.txt
echo "#7_3" >> PERDA.LINUX.txt
sudo lvs >> PERDA.LINUX.txt
echo "#7_4" >> PERDA.LINUX.txt
sudo vgs >> PERDA.LINUX.txt
echo "#7_5" >> PERDA.LINUX.txt
sudo pvs >> PERDA.LINUX.txt
echo "#7_6" >> PERDA.LINUX.txt
swapon -s >> PERDA.LINUX.txt
echo "#8_1" >> PERDA.LINUX.txt
openssl version >> PERDA.LINUX.txt
echo "#8_2" >> PERDA.LINUX.txt
openssl engine -c >> PERDA.LINUX.txt
echo "#8_3" >> PERDA.LINUX.txt
ssh -V >> PERDA.LINUX.txt
echo "#8_4" >> PERDA.LINUX.txt
apache2 -v >> PERDA.LINUX.txt
echo "END OF PERDA DATA COLLECTION"
