# PERA Samples

### Client LPAR Scorecard regarding z/OS Data set encryption
  For each client LPAR we use to provide a scorecard. The main objective of this scorecard is to highlight several aspect that matters for every z/OS Data set encryption projects.
  * **Total number of eligible data sets:** Usefull to estimate how much rich of data sets an LPAR is versus the others. This help to priorize which LPARs concentrate the volume of data set to be protected by encryption.
  * **z/OS Treemap view:** Helpful to represent z/OS data set structures, groups of data set, to intuit ownership and what could the policy to encrypt data sets.
  * **Extended-Format view:** Helpful to represent if an intermediate step is required before encrypted data at speed and volume. This step is dimensionning and can slow down your project and must be detected as soon as possible.
  * **Encrypted view:** Viewing how much your ellligible data is encrypted.
  * **Compressed view:** Viewing how much your ellligible data for encryption are compressed.

  ![alt text](https://github.com/guikarai/PERA/blob/master/IMAGES/pera-scorecard.png)

### Client eligible data sets for z/OS Data set encryption
For all the LPAR analysed during a study, we use to focus on those having the biggest volume of data set. it is helpful to priorize which LPARs concentrate the volume of data set to be protected by encryption. In that case, 4 LPARS concentrates 95% of eligible data sets to be protected.
  ![alt text](https://github.com/guikarai/PERA/blob/master/IMAGES/pera-dataset.png)

### Client eligible data sets per type for z/OS Data set encryption
For all the LPAR analysed during a study, we use to focus and to identify data set types. In that case, Linear and Physical sequential data sets represents 95% of eligible data sets.
  ![alt text](https://github.com/guikarai/PERA/blob/master/IMAGES/pera-per-type.png)

### Client eligible data sets and the "Extended format"
For all the LPAR analysed during a study, we use to focus and to identify if eligible data set are in extended format or not. I that case extended format data sets are ready for being encrypted. Non-extended format are potential data sets that can be encrypted if they become extended format after a data migration process as intermediate steps. This chart in this case shows how inequal LPARs are and in most of the case, the encryption to be become pervasive on eligible data set will required data set to be in extended format.
  ![alt text](https://github.com/guikarai/PERA/blob/master/IMAGES/pera-extended.png)


### z/OS Coupling Facility Encryption

### z/OS Data Set Encryption
