function [I, Q] = GNSSsignalgen(svnum, signal,fs,n_periods)
% GNSSsignalgen Generates a GNSS signal.
%   [I Q] = GNSSsignalgen(svnum, modulation,fs,n_periods) returns the
%   real and imaginary parts of a GNSS signal with normalized power.
%
%   Inputs
%       svnum --> Satellite number. GPS: [1-32], Galileo: [1-50].
%                 Can be a vector.
%       signal -->  L1CA: GPS L1 C/A signal
%                   L2C: GPS L2C signal
%                   L2CM: GPS L2C data component
%                   L2CL: GPS L2C pilot component
%                   L5: GPS L5 signal without secondary codes
%                   L5+: GPS L5 signal with secondary codes
%                   L5I: GPS L5 signal data component without secondary
%                   codes
%                   L5Q: GPS L5 signal pilot component without secondary
%                   codes
%                   L5I+: GPS L5 signal data component with secondary
%                   codes
%                   L5Q+: GPS L5 signal pilot component with secondary
%                   codes
%                   E1OS: Galileo E1OS signal with secondary codes
%                   E1OS+: Galileo E1OS signal without secondary codes
%                   E1OS_complex: Galileo E1OS signal without secondary 
%                   codes with the E1C component in the imaginary part 
%                   (see observations below).
%                   E1OS+_complex: Galileo E1OS signal with secondary 
%                   codes with the E1C component in the imaginary part 
%                   (see observations below).
%                   E1OS_B: Galileo E1OS data component
%                   E1OS_C: Galileo E1OS pilot component without secondary
%                   codes
%                   E1OS+_C: Galileo E1OS pilot component with secondary
%                   codes
%                   E5: Galileo E5 signal without secondary codes
%                   E5+: Galileo E5 signal with secondary codes
%                   E5A: Galileo E5A signal without secondary codes
%                   E5B: Galileo E5A signal without secondary codes

%       fs --> sampling frequency.
%       n_periods --> periods of the original signal lenght. Default is
%       "1".
%
%   Observations
%       # In the ICD is said that the E1OS modulation is a real signal,
%       but I believe is actually complex so as to create a constant
%       power envelope (like ALL the other GNSS signals). Compare for
%       example plot(I.^2+Q.^2) with 'E1OS' and with 'EOS_complex'.
%       # L5+, E1OS+ --> Include the secondary codes 
%       # PRN chipping rates --> 
%       L1CA/L2CM/L2CL/L2C/E1OS/E1OS+/E1OS_complex: 1.023 MCps
%       L5/L5+/E5: 10.23 MCps
%       # Period lenght --> L1CA/L5/E5: 1 ms, L2CM: 20ms, L2CL: 1.5s,
%       E1OS: 4ms, L5+: 20ms, E1OS+: 100ms, E5+:
%       # Have in mind that the tranmsitted signals by the satellites are 
%       bandlimited. If the desired sampling frequency is higher than the 
%       original bandwidth, the signal may be generated using the latter as
%       fs and then resampled to obtain the desired rate.
%       # The signals are repeated cyclicy regardless of the sampling
%       frequency, however for the E1OS and E5 signals, this is true only
%       if the sampling frequency is multiple of 1.023 MHz. The reason is
%       that the period of the sampled signal may be much larger than the 
%       original signal lenght. Actually this also implies that the 
%       sub-carriers have not their expected period. However these 
%       differences are very very small, and the adquistion is believed to 
%       not be compromised.
%       # This code have been tested satisfactorily to acquire real L1C/A,
%       L2CM, L2CL, L2C, L5, E1OS, E5A, E5B and E5 signals.
%   
%   References
%       # L1CA/L2: GPS Interface Control Document IS-GPS-200
%       # L5: GPS Interface Control Document IS-GPS-705
%       # Galileo: Galileo Open Service Signal In Space Interface Control
%       Document (OS SIS ICD)
%--------------------------------------------------------------------------
% Version log (main changes)
%   02/03/2017 --> Log started
%   14/06/2017 --> Added L2C
%   17/11/2017 --> Added secondary codes for L5, E1OS and E5.
%   16/01/2019 --> svnum can now be a vector
%                  included E1OS_complex
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual at protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

% Copyright 2017 Daniel Pascual
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

    if nargin == 3
        n_periods = 1;
    end

    switch(signal)

        % GPS L1 C/A ------------------------------------------------------
        case 'L1CA'
            I = GNSScodegen(svnum, 'L1CA',1);
            
            coh_time = n_periods*1e-3;
            I = sample(I, fs*coh_time, 1.023e6, fs, 0); 
            Q = zeros(size(I));

        % GPS L2 C --------------------------------------------------------
        case 'L2CM'
            L2CM = GNSScodegen(svnum, 'L2CM',1);
 
            L2CM = reshape([L2CM; zeros(size(L2CM))], [length(svnum) 10230*2]);
            
            coh_time = n_periods*20e-3;
            Q = sample(L2CM, fs*coh_time, 1.023e6, fs, 0);
            I = zeros(size(Q));
 
        case 'L2CL'
            L2CL = GNSScodegen(svnum, 'L2CL',1);
 
            L2CL = reshape([zeros(size(L2CL)); L2CL], [length(svnum) 10230*75*2]);
            
            coh_time = n_periods*1.5;
            Q = sample(L2CL, fs*coh_time, 1.023e6, fs, 0);
            I = zeros(size(Q));
 
        case 'L2C'
            L2CM = GNSScodegen(svnum, 'L2CM',1);
            L2CL = GNSScodegen(svnum, 'L2CL',1);
 
            L2C = reshape([repmat(L2CM,[1 75]); L2CL], [1 10230*75*2]);
            
            coh_time = n_periods*1.5;
            Q = sample(L2C, fs*coh_time, 1.023e6, fs, 0);
            I = zeros(size(Q));            
            
        % GPS L5 ----------------------------------------------------------            
        case 'L5'
            I = GNSScodegen(svnum, 'L5I',1);
            Q = GNSScodegen(svnum, 'L5Q',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = sqrt(0.5)*sample(Q, fs*coh_time, 10*1.023e6, fs, 0); 

        case 'L5I'
            I = GNSScodegen(svnum, 'L5Q',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = zeros(size(I));
            
        case 'L5Q'
            I = GNSScodegen(svnum, 'L5I',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = zeros(size(I));            
            
        case 'L5+'
            % Secondary code
            nh10 = GNSSsecondarygen(svnum, 'L5I');
            nh20 = GNSSsecondarygen(svnum, 'L5Q');
            nh20 = sample(nh20, fs*20e-3, 1e3, fs, 0); 
            nh10 = sample(nh10, fs*10e-3 * 2, 1e3, fs, 0); 
            
            % PRN
            I = GNSScodegen(svnum, 'L5I',1);
            Q = GNSScodegen(svnum, 'L5Q',1);
            
            n_periods_prn = 20*n_periods;
            coh_time = n_periods_prn*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = sqrt(0.5)*sample(Q, fs*coh_time, 10*1.023e6, fs, 0);             

            % Apply secondary codes by xoring
            I = sign(I)+1;
            Q = sign(Q)+1;
            I = xor(I,nh10);
            Q = xor(Q,nh20);
            I = 2*(I-0.5);
            Q = 2*(Q-0.5);
            I =  sqrt(0.5)*I;
            Q =  sqrt(0.5)*Q;  
            
        case 'L5I+'
            % Secondary code
            nh10 = GNSSsecondarygen(svnum, 'L5I');
            nh10 = sample(nh10, fs*10e-3, 1e3, fs, 0);             
            
            I = GNSScodegen(svnum, 'L5I',1);
            
            n_periods_prn = 10*n_periods;
            coh_time = n_periods_prn*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 

            % Apply secondary codes by xoring
            I = sign(I)+1;
            I = xor(I,nh10);
            I = 2*(I-0.5);
            I =  sqrt(0.5)*I;

            Q = zeros(size(I));
            
        case 'L5Q+'
            % Secondary code
            nh20 = GNSSsecondarygen(svnum, 'L5Q');
            nh20 = sample(nh20, fs*20e-3, 1e3, fs, 0);         
            
            I = GNSScodegen(svnum, 'L5Q',1);
            
            n_periods_prn = 20*n_periods;
            coh_time = n_periods_prn*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 

            % Apply secondary codes by xoring
            I = sign(I)+1;
            I = xor(I,nh20);
            I = 2*(I-0.5);
            I =  sqrt(0.5)*I;

            Q = zeros(size(I));
            
        % Galileo E1OS ----------------------------------------------------
        case 'E1OS'
            E1B = GNSScodegen(svnum,'E1B',1);
            E1C = GNSScodegen(svnum,'E1C',1);
            
            coh_time = n_periods*4e-3;
            E1B = sqrt(0.5)*sample(E1B, fs*coh_time, 1.023e6,fs,0); 
            E1C = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 
            
            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
            
            E1OS = E1B.*(sboc_6+sboc_1)...
                  -E1C.*(-sboc_6+sboc_1);    
              
            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);               
              
            I = E1OS;
            Q = zeros(size(I)); 

        case 'E1OS_complex' 

            E1B = GNSScodegen(svnum,'E1B',1);
            E1C = GNSScodegen(svnum,'E1C',1);
            
            coh_time = n_periods*4e-3;
            E1B = sqrt(0.5)*sample(E1B, fs*coh_time, 1.023e6,fs,0); 
            E1C = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 
            
            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
            
            E1OS = E1B.*(sboc_6+sboc_1)...
                  -1j*E1C.*(-sboc_6+sboc_1);    
              
            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);               
              
            I = real(E1OS);
            Q = imag(E1OS);             
            
        case 'E1OS_B'
            E1B = GNSScodegen(svnum,'E1B',1);
            
            coh_time = n_periods*4e-3;
            E1B = sample(E1B, fs*coh_time, 1.023e6,fs,0);    
            
            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
            
            E1OS = E1B.*(sboc_6+sboc_1);    
              
            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);               
              
            I = E1OS;
            Q = zeros(size(I));          
            
        case 'E1OS_C'
            E1C = GNSScodegen(svnum,'E1C',1);
            
            coh_time = n_periods*4e-3;
            E1C = sample(E1C, fs*coh_time, 1.023e6,fs,0);    
            
            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
            
            E1OS = E1C.*(-sboc_6+sboc_1);    
              
            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);               
              
            I = E1OS;
            Q = zeros(size(I));                 
            
        case 'E1OS+'
            % Secondary code
            CS25_1 = GNSSsecondarygen(svnum, 'E1C');
            CS25_1 = sample(CS25_1, fs*100e-3, 250, fs, 0); 

            % PRN
            E1B = GNSScodegen(svnum,'E1B',1);
            E1C = GNSScodegen(svnum,'E1C',1);

            n_periods_prn = 25*n_periods;
            coh_time = n_periods_prn*4e-3;
            E1B = sqrt(0.5)*sample(E1B, fs*coh_time, 1.023e6,fs,0); 
            E1C = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 

            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);

            % Apply secondary code by xoring E1C
            E1C = sign(E1C)+1;
            E1C = xor(E1C,CS25_1);
            E1C = 2*(E1C-0.5);
            E1C =  sqrt(0.5)*E1C;

            % Modulation
            E1OS = E1B.*(sboc_6+sboc_1)...
                  -E1C.*(-sboc_6+sboc_1);    

            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);             
            
            I = E1OS;
            Q = zeros(size(I));    
            
        case 'E1OS+_complex'
            % Secondary code
            CS25_1 = GNSSsecondarygen(svnum, 'E1C');
            CS25_1 = sample(CS25_1, fs*100e-3, 250, fs, 0); 

            % PRN
            E1B = GNSScodegen(svnum,'E1B',1);
            E1C = GNSScodegen(svnum,'E1C',1);

            n_periods_prn = 25*n_periods;
            coh_time = n_periods_prn*4e-3;
            E1B = sqrt(0.5)*sample(E1B, fs*coh_time, 1.023e6,fs,0); 
            E1C = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 

            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);

            % Apply secondary code by xoring E1C
            E1C = sign(E1C)+1;
            E1C = xor(E1C,CS25_1);
            E1C = 2*(E1C-0.5);
            E1C =  sqrt(0.5)*E1C;

            % Modulation
            E1OS = E1B.*(sboc_6+sboc_1)...
                  -1j*E1C.*(-sboc_6+sboc_1);    

            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);             
            
            I = real(E1OS);
            Q = imag(E1OS); 
            
        case 'E1OS+_C'
            % Secondary code
            CS25_1 = GNSSsecondarygen(svnum, 'E1C');
            CS25_1 = sample(CS25_1, fs*100e-3, 250, fs, 0); 

            % PRN
            E1C = GNSScodegen(svnum,'E1C',1);

            n_periods_prn = 25*n_periods;
            coh_time = n_periods_prn*4e-3;
            E1C = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 

            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);

            % Apply secondary code by xoring E1C
            E1C = sign(E1C)+1;
            E1C = xor(E1C,CS25_1);
            E1C = 2*(E1C-0.5);
            E1C =  sqrt(0.5)*E1C;

            % Modulation
            E1OS = E1C.*(-sboc_6+sboc_1);    

            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS./sqrt(aux);             
            
            I = E1OS;
            Q = zeros(size(I));     
            
       % Galielo E5A ------------------------------------------------------     
        case 'E5A'            
            E5aI = GNSScodegen(svnum,'E5aI',1);
            E5aQ = GNSScodegen(svnum,'E5aQ',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(E5aI, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = sqrt(0.5)*sample(E5aQ, fs*coh_time, 10*1.023e6, fs, 0); 
            
        % Galielo E5B ------------------------------------------------------            
        case 'E5B'            
            E5bI = GNSScodegen(svnum,'E5bI',1);
            E5bQ = GNSScodegen(svnum,'E5bQ',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(E5bI, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = sqrt(0.5)*sample(E5bQ, fs*coh_time, 10*1.023e6, fs, 0); 
            
        % Galielo E5 ------------------------------------------------------            
        case 'E5'
            E5aI = GNSScodegen(svnum,'E5aI',1);
            E5bI = GNSScodegen(svnum,'E5bI',1);
            E5aQ = GNSScodegen(svnum,'E5aQ',1);
            E5bQ = GNSScodegen(svnum,'E5bQ',1);
            
            coh_time = n_periods*1e-3;
            code1 = sample(E5aI, fs*coh_time, 10*1.023e6, fs, 0); 
            code3 = sample(E5bI, fs*coh_time, 10*1.023e6, fs, 0);            
            code2 = sample(E5aQ, fs*coh_time, 10*1.023e6, fs, 0); 
            code4 = sample(E5bQ, fs*coh_time, 10*1.023e6, fs, 0); 
            
            fh = BOCgen;
            [sd1, sd2, sp1, sp2] = fh.BOC_E5(coh_time,fs);
            
            E5 = (code1+1j*code2).* (sd1-1j*sd2) + ...
                 (code3+1j*code4).* (sd1+1j*sd2) + ... 
   ((code4.*code3.*code2)+1j*(code3.*code4.*code1)).* (sp1-1j*sp2) + ...  
   ((code1.*code4.*code2)+1j*(code3.*code1.*code2)).*(sp1+1j*sp2);               

            aux = sum(abs(E5).^2)/length(E5);   % Normalize power
            E5 = E5./sqrt(aux);            
                        
            I = imag(E5);  
            Q = real(E5);     

%             I = real(E5);
%             Q = -1*imag(E5); 

%             I = -1*real(E5);       
%             Q = imag(E5);

        case 'E5+'
            % Secondary codes
            E5aI_secondary = GNSSsecondarygen(svnum, 'E5aI');
            E5bI_secondary = GNSSsecondarygen(svnum, 'E5bI');             
            E5aQ_secondary = GNSSsecondarygen(svnum, 'E5aQ');             
            E5bQ_secondary = GNSSsecondarygen(svnum, 'E5bQ');       
            
            E5aI_secondary = sample(E5aI_secondary, fs*20e-3  *5, 1e3, fs, 0);    
            E5bI_secondary = sample(E5bI_secondary, fs*4e-3   *25, 1e3, fs, 0);           
            E5aQ_secondary = sample(E5aQ_secondary, fs*100e-3, 1e3, fs, 0);
            E5bQ_secondary = sample(E5bQ_secondary, fs*100e-3, 1e3, fs, 0);
            
            % PRNs
            E5aI = GNSScodegen(svnum,'E5aI',1);
            E5bI = GNSScodegen(svnum,'E5bI',1);
            E5aQ = GNSScodegen(svnum,'E5aQ',1);
            E5bQ= GNSScodegen(svnum,'E5bQ',1);
            
            n_periods_prn = 100*n_periods;
            coh_time = n_periods_prn*1e-3;
            
            code1 = sample(E5aI, fs*coh_time, 10*1.023e6, fs, 0); 
            code3 = sample(E5bI, fs*coh_time, 10*1.023e6, fs, 0);            
            code2 = sample(E5aQ, fs*coh_time, 10*1.023e6, fs, 0); 
            code4 = sample(E5bQ, fs*coh_time, 10*1.023e6, fs, 0); 
            
            % Apply xoring
            code1 = sign(code1)+1;
            code2 = sign(code2)+1;
            code3 = sign(code3)+1;
            code4 = sign(code4)+1;
            
            code1 = xor(code1,E5aI_secondary);
            code2 = xor(code2,E5aQ_secondary);
            code3 = xor(code3,E5bI_secondary);
            code4 = xor(code4,E5bQ_secondary);
            
            code1 = 2*(code1-0.5);
            code2 = 2*(code2-0.5);
            code3 = 2*(code3-0.5);
            code4 = 2*(code4-0.5);
        
            % Modulation
            fh = BOCgen;
            [sd1, sd2, sp1, sp2] = fh.BOC_E5(coh_time,fs);
            
            E5 = (code1+1j*code2).* (sd1-1j*sd2) + ...
                 (code3+1j*code4).* (sd1+1j*sd2) + ... 
   ((code4.*code3.*code2)+1j*(code3.*code4.*code1)).* (sp1-1j*sp2) + ...  
   ((code1.*code4.*code2)+1j*(code3.*code1.*code2)).*(sp1+1j*sp2);               

            aux = sum(abs(E5).^2)/length(E5);   % Normalize power
            E5 = E5./sqrt(aux);            
            
            I = imag(E5);  
            Q = real(E5);     

%             I = real(E5);
%             Q = -1*imag(E5); 

%             I = -1*real(E5);       
%             Q = imag(E5);

    end
end