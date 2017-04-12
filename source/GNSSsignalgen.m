function [I Q] = GNSSsignalgen(svnum, signal,fs,n_periods)
%==========================================================================
% GNSSsignalgen Generates a GNSS signal.
%   [I Q] = GNSSsignalgen(svnum, modulation,fs,n_periods) returns the
%   real and imaginary parts of a GNSS signal with normalized power.
%
%   Inputs
%       svnum --> Satellite number. GPS: [1-32], Galileo: [1-50].
%       signal --> L1CA, L5, E1OS, E5.
%       fs --> sampling frequency.
%       n_periods --> periods of the original signal lenght. Default is
%       "1".
%
%   Observations
%       # PRN chipping rates --> L1CA/E1OS: 1.023 MCps, L5/E5: 10.23 MCps
%       # Period lenght --> L1CA/L5/E5: 1 ms, E1OS: 4ms.
%       # Have in mind that the tranmsitted signals by the satellites are 
%       bandlimited. If the desired sampling frequency is higher than the 
%       original bandwidth, the signal may be generated using the latter as
%       fs and then resampled to obtain the desired rate.
%       # The secondary codes are not included since they can have any
%       phase, similar to what happens with the data bits. This implies 
%       that when generating a signal with more than one period, the 
%       secondary code may have changed. The L1C/A signal doesn't have 
%       secondary codes.
%       # The signals are repeated cyclicy regardless of the sampling
%       frequency, however for the E1OS and E5 signals, this is true only
%       if the sampling frequency is multiple of 1.023 MHz. The reason is
%       that the period of the sampled signal may be much larger than the 
%       original signal lenght. Actually this also implies that the 
%       sub-carriers have not their expected period. However these 
%       differences are very very small, and the adquistion is believed to 
%       not be compromised.
%       # This code have been tested satisfactorily to acquire real L1C/A, 
%       L5 and E1OS signals, but there has not been any chance yet to test 
%       it with E5 signals.
%   
%   References
%       # L1CA: GPS Interface Control Document IS-GPS-200
%       # L5: GPS Interface Control Document IS-GPS-705
%       # Galileo: Galileo Open Service Signal In Space Interface Control
%       Document (OS SIS ICD)
%--------------------------------------------------------------------------
% Version log (main changes)
%   02/03/2017 --> Log started
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

        case 'L1CA'
            I = GNSScodegen(svnum, 'L1CA',1);
            
            coh_time = n_periods*1e-3;
            I = sample(I, fs*coh_time, 1.023e6, fs, 0); 
            Q = zeros(size(I));
            
        case 'L5'
            I = GNSScodegen(svnum, 'L5I',1);
            Q = GNSScodegen(svnum, 'L5Q',1);
            
            coh_time = n_periods*1e-3;
            I = sqrt(0.5)*sample(I, fs*coh_time, 10*1.023e6, fs, 0); 
            Q = sqrt(0.5)*sample(Q, fs*coh_time, 10*1.023e6, fs, 0); 

        case 'E1OS'
            E1B = GNSScodegen(svnum,'E1B',1);
            E1C = GNSScodegen(svnum,'E1C',1);
            
            coh_time = n_periods*4e-3;
            E1B_sampled = sqrt(0.5)*sample(E1B, fs*coh_time, 1.023e6,fs,0); 
            E1C_sampled = sqrt(0.5)*sample(E1C, fs*coh_time, 1.023e6,fs,0); 
            
            fh = BOCgen;
            [sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
            
            E1OS = E1B_sampled.*(sboc_6+sboc_1)...
                  -E1C_sampled.*(-sboc_6+sboc_1);    
              
            aux = sum(abs(E1OS).^2)/length(E1OS); % Normalize power
            E1OS = E1OS/sqrt(aux);               
              
            I = E1OS;
            Q = zeros(size(I));   
            
        case 'E5'
            E5aI = GNSScodegen(svnum,'E5aI',1);
            E5bI = GNSScodegen(svnum,'E5bI',1);
            E5aQ = GNSScodegen(svnum,'E5aQ',1);
            E5bQ= GNSScodegen(svnum,'E5bQ',1);
            
            coh_time = n_periods*1e-3;
            code1 = sample(E5aI, fs*coh_time, 10*1.023e6, fs, 0); 
            code3 = sample(E5bI, fs*coh_time, 10*1.023e6, fs, 0);            
            code2 = sample(E5aQ, fs*coh_time, 10*1.023e6, fs, 0); 
            code4 = sample(E5bQ, fs*coh_time, 10*1.023e6, fs, 0); 
            
            fh = BOCgen;
            [sd1, sd2, sp1 sp2] = fh.BOC_E5(coh_time,fs);
            
            E5 = (code1+1j*code2).* (sd1-1j*sd2) + ...
                 (code3+1j*code4).* (sd1+1j*sd2) + ... 
   ((code4.*code3.*code2)+1j*(code3.*code4.*code1)).* (sp1-1j*sp2) + ...  
   ((code1.*code4.*code2)+1j*(code3.*code1.*code2)).*(sp1+1j*sp2);               
            
            aux = sum(abs(E5).^2)/length(E5);   % Normalize power
            E5 = E5/sqrt(aux);            
            
            I = real(E5);
            Q = imag(E5);
%             I = -1*imag(E5);
%             Q = real(E5);            
            
    end
end