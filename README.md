# What is PERA?
Pervasive Encryption Readiness Assessment (or simply PERA) is an offering proposed by the IBM Client Center of Montpellier. PERA is a study help for client expecting having answer about the following questions:
* **READINESS** - Am I ready to start a Pervasive Encryption project? (Hardware, Software, Skills, Processes...)
* **VOLUMES** - Does my today volume of data justify to jump-in Pervasive Encryption project? (Volume of elligible data sets, data mapping, volume of elligible network connections, network mapping)
* **PERFORMANCE** - What could be the overhead? (Performance, Consumption, Project elapse...)

# PERA advantages
The PERA study requires a very small client investment in time and effort.
Montpellier client center team having more than 10 years of zMAX study, PERA has the similar approach and efficiency.
The team in charge of PERA has more than 1 year of customer experience spent in Pervasive Encryption projects.
PERA is based on technical study from where we see everything:
* Their encryption maturity
* Their data set structures
* Their network architecture and the volume of network connections
* How optimized is their environment

Two main livrables:
  * 1day on-site summary presentation
  * 200+ pages report


# PERA delivery time

# What data need are required for a PERA?

In order to be able to analyze the hardware crypto utilization, z/OS and some key subsystems, we need to gather SMF records for all systems that will define the scope of the Crypto assessment study.

## SMF Records
SMF records allow us to analyse your z/OS crypto performance and configuration to potentially detect bottleneck and propose optimization recommendations. We need to following SMF records for a standard Crypto assessment study:
Hardware and z/OS:
* SMF 70-79
* SMF 14, 15
* SMF 30
* SMF 42
* SMF 82
* SMF 89
* SMF 113
* SMF 119 (if running z/OS 2.3)

We expect to have SMF 7x and SMF 113 (if collected) for all partitions of all machines. Before sending any data to our ftp server, you will need to contact us to receive a user and a password for this server.

## Mandatory SMF Data

A standard PERA assessment analyzes the hardware, z/OS, ICSF and z/OS configurations.
SMF records for 2 to 3 days representing a period of significant activity. You can send all the SMF records type, and we will sort them in IBM Client Center, or limit the records to:
* RMF records: 70-79
* Batch analysis: 30
* DFSMS: 42
* SMS Activity: 14, 15
* ICSF: 82
* For products information: SMF 89 (Optional)
* Hardware instrumentation: 113 produced by HIS address space
* zERT Connection details: SMF 119 (if running z/OS 2.3)

Usually, we need SMF 7x and SMF 113 for all LPAR, for all CPC, SMF 30 for the same period than SMF 7x, but for production only, for each collected day.

SMF 119 for 2 “loaded” hours only, for production only, for a collected day.

**NOTE:** Hardware Instrumentation is very important for the study, beyond Hardware Instrumentation Services aka HIS address space running. In the activation profile for the user’s LPAR, access the security tab and verify that the following settings are checked. For Counters mode one can check Basic Counter, Problem State Counter, Crypto Activity Counter and Extended Counter within Counter Facility Security Options. For this analysis, we require all to be checked (enabled):
* Counter Facility Security Options
* Basic counter set authorization control
* Problem state counter set authorization control
* Crypto activity counter set authorization control
* Extended counter set authorization control

More information available here: http://www-01.ibm.com/support/docview.wss?uid=tss1tc000066&aid=3 

**NOTE:** Some results to be presented in the Crypto Assessment assumes that the following performance APARs have been applied to systems: **OA53718**, **OA53664**.

**NOTE:** For pervasive encryption estimations, there are required APARs that provide enhancements to DFSMS SMF 42.6 for pervasive encryption. z/OS V2.1 and V2.2 require **OA52132**, and **OA52734** is required for V2.3.

**NOTE:** If the machine where SMF records are collected from has no zAAP and no zIIP, PROJECTCPU=YES must be specified in IEAOPTxx (at least during the collected period, but can remain active)


## Splitting SMF file by record type

SMF datasets are generally huge. It is a good option to create multiple files to be terse and sent.
You can use the following JCL to create 4 files:
* One file for SMF 70-79 · One file for SMF 30
* One file for SMF 82
* One file for SMF 113
An example for SMF 70:79 is provided below:
```
//SMF7X EXEC PGM=IFASMFDP,REGION=64M
//DUMPIN DD DISP=SHR,DSN=file-with-all-your-smf-records
//DUMPOUT DDDSN=File-with-SMF-70:79-only,
       DISP=(,CATLG),
       UNIT=3390,SPACE=(TRK,(30000,4500),RLSE)
//SYSPRINT DD SYSOUT=*
INDD(DUMPIN,OPTIONS(DUMP))
       DATE(1900000,2099366)
       START(0000)
       END(2400)
OUTDD(DUMPOUT,TYPE(70:79))
```

## Tersing SMF records
The SMF dataset must be on DASD. We cannot successfully unterse dataset compressed from tape to Dasd.
You can use the following JCL sample to compress a SMF dataset:
```
//SPACK EXEC PGM=AMATERSE,PARM='SPACK'
//*
//SYSPRINT DD SYSOUT=*,DCB=(LRECL=133,BLKSIZE=0,RECFM=FBA)
//SYSUT1 DD DISP=SHR,DSN=One of the five smf datasets above
//*Organization . . . : PS
//* Record format . . . : VBS
//* Record length . . . : 32767
//*Blocksize ....:32760 
//SYSUT2 DD UNIT=3390,
//       DISP=(,CATLG),
//       SPACE=(TRK,(15000,5000),RLSE), size can vary
//      DSN=tersed.dataset1.to.n (PS FB 1024 6144) 
//*                   6144 or any multiple of 1024 
```
There is nothing else to do before sending the data.

## Sending the tersed files
The data collected will be sent to IBM Crypto assessment team through FTP using the following JCL template after having updated the fields in blue.
The directory your_directory must be created before submitting the JCL, if not existing already.
```
//*------------------------------------------------------------------
//TSOB EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=* 
//SYSOUT   DD SYSOUT=*
//*
//SYSTSIN DD *
 FTP ftpicc.edu.ihost.com
//INPUT DD *
 zntc 
 xxxxxxx password will be provided in a separate mail
 BIN cd your_directory
 PUT 'host.smf.tersed.file' name-on-ftp-server 
 PUT ... 
 PUT ... 
QUIT 
```


# Contact us
Contacts for information and support about the PERA Assessment:
* guillaume_hoareau@fr.ibm.com
* jmdarees@fr.ibm.com

