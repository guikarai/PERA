# Data collection procedure for a Pervasive Encryption Readiness Assessment

In order to be able to analyze the hardware crypto utilization, z/OS and some key subsystems, we need to gather SMF records for all systems that will define the scope of the Crypto assessment study.

## SMF Records
SMF records allow us to analyse your z/OS crypto performance and configuration to potentially detect bottleneck and propose optimization recommendations. We need to following SMF records for a standard Crypto assessment study:
Hardware and z/OS:
* **SMF 70-79**
* **SMF 14, 15**
* **SMF 30**
* **SMF 42**
* **SMF 82**
* **SMF 89**
* **SMF 113**
* **SMF 119** (if running z/OS 2.3)

We expect to have SMF 7x and SMF 113 (if collected) for all partitions of all machines. Before sending any data to our ftp server, you will need to contact us to receive a user and a password for this server.

## Mandatory SMF Data

A standard PERA assessment analyzes the hardware, z/OS, ICSF and z/OS configurations.
SMF records for 2 to 3 days representing a period of significant activity. You can send all the SMF records type, and we will sort them in IBM Client Center, or limit the records to:
* **RMF records:** 70-79
* **Batch analysis:** 30
* **DFSMS:** 42
* **SMS Activity:** 14, 15
* **ICSF:** 82
* **For products information:** SMF 89 (Optional)
* **Hardware instrumentation:** 113 produced by HIS address space
* **zERT Connection details:** SMF 119 (if running z/OS 2.3)

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

**Important Note about Secure FTP (FTPS) over SSL/TLS**
FTPS (FTP over SSL/TLS - FTP Secure) is an extention to standard FTP protocol. If secure transmission is not enforced, a FTPS server can be accessed by any FTP client. Secure communication can be activated at any time using the command "auth tls".

The FTPS protocol extension allows either to encrypt the control channel only or to encrypt both, control and data channel.
If you use MVS for secure FTP, you have to import one certificates into the RACF keyring. The certificate is a GeoTrust Root Certificate. When using the MVS (OS/390, z/OS) FTP client, please be sure to obtain the CA ROOT Certificate from GeoTrust: http://cacerts.digicert.com/DigiCertGlobalCAG2.crt

Copy the entire contents of the certificate from (and including) the -----BEGIN CERTIFICATE----- and -----END CERTIFICATE----- lines.

**ftpicc.edu.ihost.com coded x509 certficate:**
```
-----BEGIN CERTIFICATE-----
MIIFRDCCBCygAwIBAgIQB9S4H6hcHIbR2KfQfep47zANBgkqhkiG9w0BAQsFADBE
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMR4wHAYDVQQDExVE
aWdpQ2VydCBHbG9iYWwgQ0EgRzIwHhcNMTgwMTI1MDAwMDAwWhcNMTkwOTI4MTIw
MDAwWjB1MQswCQYDVQQGEwJGUjEdMBsGA1UECBMUTGFuZ3VlZG9jLVJvdXNzaWxs
b24xFDASBgNVBAcTC01vbnRwZWxsaWVyMRcwFQYDVQQKEw5DSUUgSUJNIEZyYW5j
ZTEYMBYGA1UEAwwPKi5lZHUuaWhvc3QuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAxr8MTGzSbMRKLXZSTrhTnHmml3h70b7i4djqBMXv2Bpr15SM
kGOQjFrIdbpVKGCzCBPIuQLBL+Zl3Y4INHBCoWqC7FxD9LTrIJqRsl6wsNSxu81I
Rf+onDxP6ElSHJYnu2MIWVpdwFOmjk25MSvZjT51TBClrKXfNJwme1brl4FL9ISn
Hr0zhfgAs/J30OfeHOYb2DMprPiQSz83M/DIB83IAYMWmw2if/NG+gmz6SKtjdvT
wd+6EYC3uXnYUfm2SHmIC/P5WP0UKxuRZM2eECyePNLRb73+dsv0zDxms5N2xZJr
ANdLA5x2T+sBtipbfhrT8FoKfHMuCK5gSiaYiQIDAQABo4IB/zCCAfswHwYDVR0j
BBgwFoAUJG4rLdBqklFRJWkBqppHponnQCAwHQYDVR0OBBYEFDDQHbhbn+CltAPW
ZDFmJ0ztXdAIMD8GA1UdEQQ4MDaCDyouZWR1Lmlob3N0LmNvbYINZWR1Lmlob3N0
LmNvbYIUZnRwaWNjLmVkdS5paG9zdC5jb20wDgYDVR0PAQH/BAQDAgWgMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjB3BgNVHR8EcDBuMDWgM6Axhi9odHRw
Oi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRHbG9iYWxDQUcyLmNybDA1oDOg
MYYvaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0R2xvYmFsQ0FHMi5j
cmwwTAYDVR0gBEUwQzA3BglghkgBhv1sAQEwKjAoBggrBgEFBQcCARYcaHR0cHM6
Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAIBgZngQwBAgIwdAYIKwYBBQUHAQEEaDBm
MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wPgYIKwYBBQUH
MAKGMmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEdsb2JhbENB
RzIuY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggEBALQRBLBRzTtn
bhmMmPWKHNFoaao9ViIVNQJCk5UL+ywNXt5uKWdgfsVtTm3/UcVgZgcARoD08igN
hgEO2CzdlIKORUHObiISuyZGTduwQpUgeQOtlt7DzYskgJZnXDTg8OrhEev1XkBp
bEqyrfd+cKb4QPnUrWzgS3BlFBO3/W5SpfNDuV1f2zEcVZBfUNE2oUwZeqo2+9zs
kD4EyKSbbilyDHbS99pfG8b1xiWDbHpjeNgeTweCdgwSKCU7PnHuRwIaEXHsO/+X
8lVy/mnD87SIFB+CCFKkORE5xIERUKAD3n0jiOOw1VffuEuozEaBq9vqwrxMlS1z
GSVtrFdicdI=
-----END CERTIFICATE-----
```

**ftpicc.edu.ihost.com decoded x509 certficate:**
```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            07:d4:b8:1f:a8:5c:1c:86:d1:d8:a7:d0:7d:ea:78:ef
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=DigiCert Inc, CN=DigiCert Global CA G2
        Validity
            Not Before: Jan 25 00:00:00 2018 GMT
            Not After : Sep 28 12:00:00 2019 GMT
        Subject: C=FR, ST=Languedoc-Roussillon, L=Montpellier, O=CIE IBM France, CN=*.edu.ihost.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:c6:bf:0c:4c:6c:d2:6c:c4:4a:2d:76:52:4e:b8:
                    53:9c:79:a6:97:78:7b:d1:be:e2:e1:d8:ea:04:c5:
                    ef:d8:1a:6b:d7:94:8c:90:63:90:8c:5a:c8:75:ba:
                    55:28:60:b3:08:13:c8:b9:02:c1:2f:e6:65:dd:8e:
                    08:34:70:42:a1:6a:82:ec:5c:43:f4:b4:eb:20:9a:
                    91:b2:5e:b0:b0:d4:b1:bb:cd:48:45:ff:a8:9c:3c:
                    4f:e8:49:52:1c:96:27:bb:63:08:59:5a:5d:c0:53:
                    a6:8e:4d:b9:31:2b:d9:8d:3e:75:4c:10:a5:ac:a5:
                    df:34:9c:26:7b:56:eb:97:81:4b:f4:84:a7:1e:bd:
                    33:85:f8:00:b3:f2:77:d0:e7:de:1c:e6:1b:d8:33:
                    29:ac:f8:90:4b:3f:37:33:f0:c8:07:cd:c8:01:83:
                    16:9b:0d:a2:7f:f3:46:fa:09:b3:e9:22:ad:8d:db:
                    d3:c1:df:ba:11:80:b7:b9:79:d8:51:f9:b6:48:79:
                    88:0b:f3:f9:58:fd:14:2b:1b:91:64:cd:9e:10:2c:
                    9e:3c:d2:d1:6f:bd:fe:76:cb:f4:cc:3c:66:b3:93:
                    76:c5:92:6b:00:d7:4b:03:9c:76:4f:eb:01:b6:2a:
                    5b:7e:1a:d3:f0:5a:0a:7c:73:2e:08:ae:60:4a:26:
                    98:89
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier: 
                keyid:24:6E:2B:2D:D0:6A:92:51:51:25:69:01:AA:9A:47:A6:89:E7:40:20

            X509v3 Subject Key Identifier: 
                30:D0:1D:B8:5B:9F:E0:A5:B4:03:D6:64:31:66:27:4C:ED:5D:D0:08
            X509v3 Subject Alternative Name: 
                DNS:*.edu.ihost.com, DNS:edu.ihost.com, DNS:ftpicc.edu.ihost.com
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 CRL Distribution Points: 

                Full Name:
                  URI:http://crl3.digicert.com/DigiCertGlobalCAG2.crl

                Full Name:
                  URI:http://crl4.digicert.com/DigiCertGlobalCAG2.crl

            X509v3 Certificate Policies: 
                Policy: 2.16.840.1.114412.1.1
                  CPS: https://www.digicert.com/CPS
                Policy: 2.23.140.1.2.2

            Authority Information Access: 
                OCSP - URI:http://ocsp.digicert.com
                CA Issuers - URI:http://cacerts.digicert.com/DigiCertGlobalCAG2.crt

            X509v3 Basic Constraints: critical
                CA:FALSE
    Signature Algorithm: sha256WithRSAEncryption
         b4:11:04:b0:51:cd:3b:67:6e:19:8c:98:f5:8a:1c:d1:68:69:
         aa:3d:56:22:15:35:02:42:93:95:0b:fb:2c:0d:5e:de:6e:29:
         67:60:7e:c5:6d:4e:6d:ff:51:c5:60:66:07:00:46:80:f4:f2:
         28:0d:86:01:0e:d8:2c:dd:94:82:8e:45:41:ce:6e:22:12:bb:
         26:46:4d:db:b0:42:95:20:79:03:ad:96:de:c3:cd:8b:24:80:
         96:67:5c:34:e0:f0:ea:e1:11:eb:f5:5e:40:69:6c:4a:b2:ad:
         f7:7e:70:a6:f8:40:f9:d4:ad:6c:e0:4b:70:65:14:13:b7:fd:
         6e:52:a5:f3:43:b9:5d:5f:db:31:1c:55:90:5f:50:d1:36:a1:
         4c:19:7a:aa:36:fb:dc:ec:90:3e:04:c8:a4:9b:6e:29:72:0c:
         76:d2:f7:da:5f:1b:c6:f5:c6:25:83:6c:7a:63:78:d8:1e:4f:
         07:82:76:0c:12:28:25:3b:3e:71:ee:47:02:1a:11:71:ec:3b:
         ff:97:f2:55:72:fe:69:c3:f3:b4:88:14:1f:82:08:52:a4:39:
         11:39:c4:81:11:50:a0:03:de:7d:23:88:e3:b0:d5:57:df:b8:
         4b:a8:cc:46:81:ab:db:ea:c2:bc:4c:95:2d:73:19:25:6d:ac:
         57:62:71:d2
```

## Data collection procedure – OpenSSH
### Cipher preference check
If OpenSSH is installed and running on your z/OS environment, be aware a number of version 2 ciphers have been disabled in the recent version of the release of openssh. 
Let’s check the z/OS-specific OpenSSH daemon configuration file located by default in /etc/ssh/zos_sshd_config. In an USS terminal, please issue the following command:
```
> cat /etc/ssh/zos_sshd_config > SERVERNAME-CLIENTNAME-OPENSSH-CONFIG.txt
```
### Verifying if hardware crypto support is being used
The simplest way to verify if OpenSSH is using hardware support (/dev/random or /dev/urandom) to collect random numbers, is to start ssh in debug mode. Please issue the following command: 
```
> ssh -vvv user@host > SERVERNAME-CLIENTNAME-OPENSSH-HARDWARE.txt
```

## Data collection procedure – Network status
### AT-TLS quick check
Under Unix System Services, please issue the following command:
```
> pasearch -p <TCPIP address space> 
```
Eg. exemple: pasearch -p TCPIP

## Network stats
Please issue the following command and copy output into a text file.
```
/D TCPIP,<adresse space of TCPIP>,N,CONFIG
/D TCPIP, ,<adresse space of TCPIP>,N,STATS
/D TCPIP, ,<adresse space of TCPIP>,N,TTLS
```
Eg. exemple: /D TCPIP,TCPIP,N,STATS

## Data collection procedure – ICSF
### ICSF Display
Please issue the following command and copy output into a text file.
```
/D ICSF,CARDS
/D ICSF,LIST
/D ICSF,OPT
/D ICSF,KDS
/D ICSF,MKS
/D ICSF, OPTIONS
```

### ICSF Health Check
The Health Checks can be accessed using the System Display and Search Facility (SDSF) option in ISPF. SDSF provides a CK option to access the Health Checker.
Selecting the Health Checker (CK) option displays the available checks. The checks are displayed alphabetically by name. The ICSF checks start with ‘ICSF’ and ‘CSF’:
```
SDSF HEALTH CHECKER DISPLAY  BA01
NAME                             CheckOwner       State             
ICSF_COPROCESSOR_STATE_NEGCHANGE IBMICSF          ACTIVE(ENABLED)   
ICSF_DEPRECATED_SERV_WARNINGS    IBMICSF          ACTIVE(ENABLED)   
ICSF_KEY_EXPIRATION              IBMICSF          ACTIVE(ENABLED)   
ICSF_MASTER_KEY_CONSISTENCY      IBMICSF          ACTIVE(ENABLED)   
ICSF_OPTIONS_CHECKS              IBMICSF          ACTIVE(ENABLED)   
ICSF_UNSUPPORTED_CCA_KEYS        IBMICSF          ACTIVE(ENABLED)   
ICSFMIG7731_ICSF_RETAINED_RSAKEY IBMICSF          INACTIVE(ENABLED)
RACF_CERTIFICATE_EXPIRATION      IBMRACF          ACTIVE(ENABLED)
RACF_CSFKEYS_ACTIVE              IBMRACF          ACTIVE(ENABLED)
RACF_CSFSERV_ACTIVE              IBMRACF          ACTIVE(ENABLED)
RACF_ENCRYPTION_ALGORITHM        IBMRACF          ACTIVE(ENABLED)
```
For each of the preceding heath check display, please copy report in a text file.

