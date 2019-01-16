# GNSS codes, signals and spectrum generation for Matlab

All the contents were developed for the [passive remote sensing group (RSLab)](https://prs.upc.edu/) as a part of the [Remote Sensing Laboratory](http://www.tsc.upc.edu/en/research/rslab), a research line of the [CommmSensLab Group](http://www.tsc.upc.edu/en/research/commsenslab) at the [Signal Theory and Communications Department (TSC)](http://www.tsc.upc.edu/en) of the [Universitat Politècnica de Catalunya (UPC)](http://www.upc.edu/?set_language=en).

The first version of this program was uploaded in the [IEEE Remote Sensing Code Library (RSCL)](https://rscl-grss.org/) with DOI: [10.21982/M8F59K](https://rscl-grss.org/coderecord.php?id=479) 

New versions of this program may be found at [GitHub](https://github.com/danipascual/GNSS-matlab). 

## Contents
#### \documentation
+ GNSS_signals_v1.0.pdf: A summary of the GNSS codes, signals, spectrum and auto-correlation functions.
+ Official ICD documents can be obtained from [here](https://mega.nz/#F!GXJGlKoA!Iu3S3DPCItlIXr1pQ_rI8Q).

#### \prn_codes
+ Matlab data container (.mat) files with next unsampled codes:
+ GPS: L1CA, L2CM, L2CL, L5I, L5Q.
	Galileo: E1B, E1C, E5aI, E5aQ, E5bI, E5bQ.
	BeiDou-2: B1I

#### \real_data
Real data captures can be used to test the functions. Get them [here](https://mega.nz/#F!aCxChKbA!HKGQC1X2CDfN-nmkovVjyg).

+ capture_04.mat
    + fs = 2.5 MSps
    + duration = 1.5 s
    + band: L2 (1.2276 GHz)
    + Known present PRNs: GPS L2C 26
    + data type: Matlab complex int16 (I don't remember the original bit depth, but most probably was 8 bits)

+ test_2_cut.dat
	+ fs = 20 MSps
	+ duration = 5 ms
	+ band: L1 (1.57543 GHz)
	+ Known present PRNs: GPS L1 C/A 13
	+ baseband 16 bits complex (16 bit I + 16 bit Q) 
	+ data type: signed int16

+ test_4_cut.dat
	+ band: L5 (1.17645 GHz)
	+ Known present PRNs: GPS L5 30
    + baseband 16 bits complex (16 bit I + 16 bit Q)
	+ fs = 20 MSps
	+ duration = 20 ms
	+ data type: signed int16	

+ test_5_cut.dat
	+ band: E5A (1.176450000 GHz)
	+ Known present PRNs: Galielo E5A 30
	+ baseband 16 bits complex (16 bit I + 16 bit Q)
	+ fs = 20 MSps
	+ duration = 5 ms
	+ data type: signed int8

+ test_6_cut.dat
	+ band: E5B (1.20714 GHz)
	+ Known present PRNs: Galielo E5B 7
	+ baseband 16 bits complex (16 bit I + 16 bit Q)
	+ fs = 20 MSps
	+ duration = 5 ms
	+ data type: signed int8	

+ test_11_cut.dat
	+ band: E5 (1.191795 GHz)
	+ Known present PRNs: Galielo E5 3
	+ baseband 8 bits complex (8 bit I + 8 bit Q)
	+ fs = 50 MSps
	+ duration = 100 ms
	+ data type: signed int8		

+ test_14_cut.dat
	+ band: E1 (1.57543 GHz)
	+ Known present PRNs: Galielo E1OS 3
    + baseband 8 bits complex (8 bit I + 8 bit Q)
	+ fs = 50 MSps
	+ duration = 100 ms
	+ data type: signed int8
    
#### \source

+ GNSScodegen.m: Generates GNSS unsampled codes.
    + GPS: L1CA, L2CM, L2CL, L5I, L5Q.
    + Galileo: E1B, E1C, E5aI, E5aQ, E5bI, E5bQ.
    + BeiDou-2: B1I.

+ GNSSsecondarygen.m: Generates GNSS unsampled secondary codes
	+ GPS: L5I, L5Q.
	+ Galileo: E1C, E5aI, E5aQ, E5bI, E5bQ.

+ GNSSsignalgen.m: Generates sampled GNSS signals.
	+ L1CA: GPS L1 C/A signal
	+ L2C: GPS L2C signal
	+ L2CM: GPS L2C data component
	+ L2CL: GPS L2C pilot component
	+ L5: GPS L5 signal without secondary codes
	+ L5+: GPS L5 signal with secondary codes
	+ L5I: GPS L5 signal data component without secondary codes
	+ L5Q: GPS L5 signal pilot component without secondary codes
	+ L5I+: GPS L5 signal data component with secondary codes
	+ L5Q+: GPS L5 signal pilot component with secondary codes
	+ E1OS: Galileo E1OS signal with secondary codes
	+ E1OS+: Galileo E1OS signal without secondary codes
	+ E1OS_complex: Galileo E1OS signal without secondary codes with the E1C component in the imaginary part
	+ E1OS+_complex: Galileo E1OS signal with secondary codes with the E1C component in the imaginary part 
	+ E1OS_B: Galileo E1OS data component
	+ E1OS_C: Galileo E1OS pilot component
	+ E1OS+_C: Galileo E1OS pilot component with secondary codes
	+ E5: Galileo E5 signal without secondary codes
	+ E5+: Galileo E5 signal with secondary codes
	+ E5A: Galileo E5A signal without secondary codes
	+ E5B: Galileo E5A signal without secondary codes
	
+ BOCgen.m: Generates the sub-carriers needed for the BOC-based modulations

+ GNSSspectrumgen.m: Generate GNSS analytical spectra.
    + GPS L1: L1CA, L1P, L1M, L1C, L1Cd, L1Cp, L1Cp1, L1Cp2, L1, L1_new.
    + GPS L2: L2C, L2P, L2M, L2, L2_new.
	+ GPS L5: L5I, L5Q, L5, L5_new   
	+ Galileo E1: E1PRS/EA, E1OS.
	+ Galileo E6: E6PRS/E6OS.
	+ Galileo E5: E5, E5A, E5B.
	+ BeiDou-2 Current: 
		+ B1: B11, B12, B1
	    + B2: B2I, B2Q, B2
	    + B3: B3
	+ BeiDou-2 Future: 
		+ B1: B1Cd, B1Cp, B1C, B1_new
		+ B2: B2_new
	    + B3: B3_new, B3A, B3composite

#### \examples
Example files calling the above functions.

## Licence
You may find a specific licence files in each directory.

## Contact
Daniel Pascual (daniel.pascual at protonmail.com)