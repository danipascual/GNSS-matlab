# GNSS code, signal and spectrum generation for Matlab

All the contents were developed for the [passive remote sensing group (RSLab)](http://www.tsc.upc.edu/rslab/Passive%20Remote%20Sensing/welcome) at the [Signal Theory and Communications Department (TSC)](http://www.tsc.upc.edu/en) of the [Universitat Politècnica de Catalunya (UPC)](http://www.upc.edu/?set_language=en).

The first version of this program was uploaded in the [IEEE Remote Sensing Code Library (RSCL)](https://rscl-grss.org/) with DOI: [10.21982/M8F59K](https://rscl-grss.org/coderecord.php?id=479) 

New versions of this program may be found at [GitHub](https://github.com/danipascual/GNSS-matlab) 

## Contents
##### \documentation
* GNSS_signals_v1.0.pdf: A summary of the GNSS codes, signals, spectrum and auto-correlation functions.
* Official ICD documents.

##### \prn_codes
* Matlab data container (.mat) files with next unsampled codes:
* GPS: L1CA, L2CM, L2CL, L5I, L5Q.
	Galileo: E1B, E1C, E5aI, E5aQ, E5bI, E5bQ.
	BeiDou-2: B1I

##### \real_data
* capture_01.dat: 
    8 bits complex (8 bit I + 8 bit Q)
	fs = 10 MSps
	duration = 10 ms
	band: GPS L1
	PRN: 5 and 9

* capture_02.dat: 
    8 bits complex (8 bit I + 8 bit Q)
	fs = 25 MSps
	duration = 16 ms
	band: Galileo E1
	PRN: 12		

* capture_03.dat: 
    8 bits complex (8 bit I + 8 bit Q)
	fs = 10 MSps
	duration = 20 ms
	band: GPS L5
	PRN: 1

* capture_04.mat
    fs = 2.5 MSps
    duration = 1 s
    band: GPS L2
    PRN: 26
##### \source
* GNSScodegen.m: Generates GNSS unsampled codes.
    GPS: L1CA, L2CM, L2CL, L5I, L5Q.
    Galileo: E1B, E1C, E5aI, E5aQ, E5bI, E5bQ.
    BeiDou-2: B1I.

* GNSSsignalgen.m: Generates sampled GNSS signals.
	GPS: L1CA, L2C, L2CL, L2CM, L5.
	Galileo: E1OS, E5.

* BOCgen.m: Generates the sub-carriers needed for the BOC-based   modulations.

* GNSSspectrumgen.m: Generate GNSS analytical spectra.
    GPS L1: L1CA, L1P, L1M, L1C, L1Cd, L1Cp, L1Cp1, L1Cp2, L1, L1_new.
    GPS L2: L2C, L2P, L2M, L2, L2_new.
	GPS L5: L5I, L5Q, L5, L5_new   
	Galileo E1: E1PRS/EA, E1OS.
	Galileo E6: E6PRS/E6OS.
	Galileo E5: E5, E5A, E5B.
	BeiDou-2 Current: 
		B1: B11, B12, B1
	    B2: B2I, B2Q, B2
	    B3: B3
	BeiDou-2 Future: 
		B1: B1Cd, B1Cp, B1C, B1_new
		B2: B2_new
	    B3: B3_new, B3A, B3composite

###### \examples
Example files calling the above functions.

## Licence
You may find a specific licence files in each directory.

## Contact
Daniel Pascual (daniel.pascual at protonmail.com)