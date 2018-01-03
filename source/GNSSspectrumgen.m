function fh = GNSSspectrumgen
%==========================================================================
%GNSSspectrumgen Functions to generate GNSS analytical spectra.
%   fh = GNSSspectrumgen  returns the handlers of the local functions:
%
%   <strong>spectrumgen_call</strong>
%   [SI SQ] = spectrumgen_call(signal,F) returns the analytical complex 
%   spectra of a GNSS signal with normalized complex power.
%
%       Inputs
%           signal --> GPS L1: L1CA, L1P, L1M, L1C, L1Cd, L1Cp, L1Cp1,L1Cp2
%                              L1, L1_new.
%                      GPS L2: L2C, L2P, L2M, L2, L2_new.
%                      GPS L5: L5I, L5Q, L5, L5_new   
%                      Galileo E1: E1PRS/EA, E1OS.
%                      Galileo E6: E6PRS/E6OS.
%                      Galileo E5: E5, E5A, E5B.
%                      BeiDou-2 Current: 
%                      	B1: B11, B12, B1
%                       B2: B2I, B2Q, B2
%                       B3: B3
%                      BeiDou-2 Future: 
%                       B1: B1Cd, B1Cp, B1C, B1_new
%                       B2: B2_new
%                       B3: B3_new, B3A, B3composite
%           F --> Baseband frequency points.
%
%       Ouputs
%           SI/SQ --> Normalized complex spectrum.
%
%   <strong>spectrum_BPSK</strong>
%   S = spectrum_BPSK(fc,F) returns spectrum of a BPSK modulation with a
%   chipping rate fc.
%
%   <strong>spectrum_BOCs</strong>
%   S = spectrum_BOCs(n,m,F) returns spectrum of a sine-phased even BOC 
%   modulation with a chipping rate fc=m*1.023e6 and sub-carrier rate 
%   fs = n*1.023e6.
%
%   <strong>spectrum_BOCc</strong>
%   S = spectrum_BOCc(n,m,F) returns spectrum of a cosine-phased even BOC
%   modulation with a chipping  rate fc=m*1.023e6 and sub-carrier rate
%   fs = n*1.023e6.
%
%   <strong>spectrum_AltBOC</strong> returns spectrum of a sine-phased
%   modified even AltBOC modulation with a chipping rate fc=m*1.023e6 and 
%   sub-carrier rate fs = n*1.023e6.
%
%   Observations
%       # I think that L2 can also transmit a C/A component, but that they
%       actually never do it.
%       # I am not sure if the future BeiDou signals will replace or 
%       complement the former signals. Now I assume they will replace them.
%       # I cound't find the official transmitted powers of the BeiDou 
%       signals anywhere. I have assumed they are -163dBm per component.
%
%   References
%       # L1CA/L2: GPS Interface Control Document IS-GPS-200
%       # L1C:  GPS Interface Control Document IS-GPS-800
%       # L5: GPS Interface Control Document IS-GPS-705
%       # Galileo: Galileo Open Service Signal In Space Interface Control
%       Document (OS SIS ICD)
%       # BeiDou: BeiDou Navigation Satellite System Signal In Space 
%       Interface Control Document 2.0
%--------------------------------------------------------------------------
% Version log (main changes)
%   02/03/2017 --> Log started
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
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

    fh.spectrumgen_call = @spectrumgen_call;        
    fh.spectrum_BPSK = @spectrum_BPSK;
    fh.spectrum_BOCs = @spectrum_BOCs;
    fh.spectrum_BOCc = @spectrum_BOCc;
    fh.spectrum_AltBOC = @spectrum_AltBOC;
end
        
        
function [SI, SQ] = spectrumgen_call(signal,F)
%==========================================================================
% 
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    switch(signal)
        %-------------------- All GNSS individual -------------------------   
        % BPSK
        case {'L1CA', 'L2C'}
            SI = spectrum_BPSK(1.023e6,F);
            SQ = zeros(size(SI));
            
        case {'E6CS'}
            SI = spectrum_BPSK(5*1.023e6,F); 
            SQ = zeros(size(SI));
        
        case {'L1P', 'L2P', 'L5I', 'L5Q'}
            SI = spectrum_BPSK(10.23e6,F);
            SQ = zeros(size(SI));
            
        % BOCs
        case{'L1Cd','L1Cp1'}       
            SI = spectrum_BOCs(1,1,F);
            SQ = zeros(size(SI));
            
        case{'L1Cp2'}                                    
            SI = spectrum_BOCs(6,1,F);
            SQ = zeros(size(SI));
            
        case {'L1M','L2M'}
            SI = spectrum_BOCs(10,5,F);
            SQ = zeros(size(SI));  
            
        case{'L1Cp'}    
            P_Cp1 = GNSS_POWERS.GPS_L1_Cp1/GNSS_POWERS.GPS_L1_Cp;
            P_Cp2 = GNSS_POWERS.GPS_L1_Cp2/GNSS_POWERS.GPS_L1_Cp;
            
            S_Cp1 = P_Cp1*spectrumgen_call('L1Cp1',F); 
            S_Cp2 = P_Cp2*spectrumgen_call('L1Cp2',F); 
            
            SI = S_Cp1 + S_Cp2;
            SQ = zeros(size(SI));            
            
        case{'L1C'}
            P_Cd = GNSS_POWERS.GPS_L1_Cd/GNSS_POWERS.GPS_L1_C;
            P_Cp = GNSS_POWERS.GPS_L1_Cp/GNSS_POWERS.GPS_L1_C;
            
            S_Cd = P_Cd*spectrumgen_call('L1Cd',F);            
            S_Cp = P_Cp*spectrumgen_call('L1Cp',F);    
            
            SI = S_Cd;
            SQ = S_Cp;
            
        case 'E1OS'
            SI = (10/11)*spectrum_BOCs(1,1,F)+(1/11)*spectrum_BOCs(6,1,F);            
            SQ = zeros(size(SI));                
            
        % BOCc            
        case {'E6A','E6PRS'}
            SI = spectrum_BOCc(10,5,F);
            SQ = zeros(size(SI));
            
        case {'E1A','E1PRS'}
            SI = spectrum_BOCc(15,2.5,F);
            SQ = zeros(size(SI));
            
        %-------------------- GPS L1  -------------------------------------               
        % Prior to Block III
        case 'L1'
            P_M = GNSS_POWERS.GPS_L1_M/GNSS_POWERS.GPS_L1;
            P_P = GNSS_POWERS.GPS_L1_P/GNSS_POWERS.GPS_L1;
            P_CA =  GNSS_POWERS.GPS_L1_CA/GNSS_POWERS.GPS_L1;

            S_CA = P_CA*spectrumgen_call('L1CA',F); 
            S_P = P_P*spectrumgen_call('L1P',F); 
            S_M = P_M*spectrumgen_call('L1M',F); 

            SI = S_P+S_M;
            SQ = S_CA;
            
        % Block III (includes L1C)
        case 'L1_new'       
            
            P_M = GNSS_POWERS.GPS_L1_M/GNSS_POWERS.GPS_L1_new;
            P_P = GNSS_POWERS.GPS_L1_P/GNSS_POWERS.GPS_L1_new;
            P_CA = GNSS_POWERS.GPS_L1_CA/GNSS_POWERS.GPS_L1_new;
            P_C = GNSS_POWERS.GPS_L1_C/GNSS_POWERS.GPS_L1_new;

            S_CA = P_CA*spectrumgen_call('L1CA',F); 
            S_P = P_P*spectrumgen_call('L1P',F); 
            S_M = P_M*spectrumgen_call('L1M',F); 
            [S_Cd, S_Cp] = spectrumgen_call('L1C',F); 
            S_Cd = S_Cd*P_C;
            S_Cp = S_Cp*P_C;

            SI = S_P+S_M+S_Cd;
            SQ = S_CA+S_Cp;
            
        %-------------------- GPS L2  -------------------------------------   
        case 'L2_new' 
            
            P_P = GNSS_POWERS.GPS_L2_P_new/GNSS_POWERS.GPS_L2_new;
            P_C = GNSS_POWERS.GPS_L2_C/GNSS_POWERS.GPS_L2_new;   
            P_M = GNSS_POWERS.GPS_L2_M/GNSS_POWERS.GPS_L2_new;   
            
            S_P = P_P*spectrumgen_call('L2P',F); 
            S_C = P_C*spectrumgen_call('L2C',F); 
            S_M = P_M*spectrumgen_call('L2M',F);             
            
            SI = S_P+S_M;
            SQ = S_C;
            
        case 'L2_new_2'
            
            P_P = GNSS_POWERS.GPS_L2_P_new/GNSS_POWERS.GPS_L2_new_2;
            P_C =  GNSS_POWERS.GPS_L2_C_new/GNSS_POWERS.GPS_L2_new_2;   
            P_M =  GNSS_POWERS.GPS_L2_M/GNSS_POWERS.GPS_L2_new_2;   
            
            S_P =   P_P*spectrumgen_call('L2P',F); 
            S_C =   P_C*spectrumgen_call('L2C',F); 
            S_M =   P_M*spectrumgen_call('L2M',F);    
            
            SI = S_P+S_M;
            SQ = S_C;
            
        %-------------------- GPS L5  -------------------------------------               
        case {'L5', 'L5_new'}
            SI = 0.5*spectrumgen_call('L5I',F);
            SQ = SI;            

        %-------------------- Galileo E1 ----------------------------------   
        case {'E1'}
            P_E1PRS = 0.5;
            P_E1OS = 0.5;
            
            S_E1PRS = P_E1PRS*spectrumgen_call('E1PRS',F);
            S_E1OS = P_E1OS*spectrumgen_call('E1OS',F);
            
            SI = S_E1OS;
            SQ = S_E1PRS;
            
        %-------------------- Galileo E6 ----------------------------------   
        case 'E6'
            P_E6A = 0.5;
            P_E6B = 0.5;            
            
            S_E6PRS = P_E6A*spectrumgen_call('E6PRS',F); 
            S_E6CS = P_E6B*spectrumgen_call('E6CS',F); 
             
            SI = S_E6CS;
            SQ = S_E6PRS;

        %-------------------- Galileo E5 ----------------------------------   
       case 'E5'
            SI = 0.5*spectrum_AltBOC(15,10,F);
            SQ = SI;
        
        case {'E5A','E5B'}
            aux = spectrum_AltBOC(15,10,F); 
            len = floor(length(aux)/2);
            aux2 = [aux(1:len+1) zeros(1,len)]; 
            len2 = floor(length(aux2)/2);
            [~, aux3] =  max(aux2);
            SI =  0.5*2*circshift(aux2',len2-aux3)';  % actually is not exactly multply by 2..
            SQ = SI;
            
        %-------------------- BeiDou-2 current ----------------------------   
        % B1
        case {'B1','B11','B12'}
            SI = 0.5*spectrum_BPSK(2*1.023e6,F);
            SQ = 0.5*spectrum_BPSK(2*1.023e6,F);
            
        % B2
        case {'B2Q'}
            SI = spectrum_BPSK(10*1.023e6,F); 
            SQ = zeros(size(SI));
        case {'B2I'}
            SI = spectrum_BPSK(2*1.023e6,F);
            SQ = zeros(size(SI));
        case{'B2'}
            P_B2Q = 0.5;
            P_B2I = 0.5;

            SQ = P_B2Q*spectrumgen_call('B2Q',F); 
            SI = P_B2I*spectrumgen_call('B2I',F);  
            
        % B3
        case{'B3'}
             SI = 0.5*spectrum_BPSK(10*1.023e6,F);
             SQ = SI;            
             
        %-------------------- BeiDou-2 future -----------------------------   
        % B1
        case {'B1Cd'}
            SI = spectrum_BOCs(1,1,F);
            SQ = zeros(size(SI));
            
        case {'B1Cp'}
            SI = spectrum_BOCs(6,1,F);
            SQ = zeros(size(SI));
            
        case {'B1C'}            
            P_B1Cd = (10/11);
            P_B1Cp = (1/11);  
            
            S_B1Cd = P_B1Cd*spectrumgen_call('B1Cd',F); 
            S_B1Cp = P_B1Cp*spectrumgen_call('B1Cp',F); 
            
            SI = S_B1Cd + S_B1Cp;   
            SQ = zeros(size(SI));
            
        case {'B1_new'}               
            SI = spectrum_BOCs(14,2,F);
            SQ = zeros(size(SI));
            
        case {'B1composite'}
            P_B1C = GNSS_POWERS.BEIDOU_B1C/GNSS_POWERS.BEIDOU_B1_composite;            
            P_B1_new = GNSS_POWERS.BEIDOU_B1_new/GNSS_POWERS.BEIDOU_B1_composite;            
            
            S_B1C = P_B1C*spectrumgen_call('B1C',F); 
            S_B1_new = P_B1_new*spectrumgen_call('B1_new',F); 
            
            SI = S_B1C+S_B1_new;
            SQ = zeros(size(SI));
        
        % B2
        case{'B2_new'}
            SI = 0.5*spectrum_AltBOC(15,10,F);
            SQ = 0.5*spectrum_AltBOC(15,10,F);

        % B3
        case{'B3_new'}
            SI = 0.5*spectrum_BPSK(10*1.023e6,F);
            SQ = 0.5*SI;
        case{'B3A'}
            S = spectrum_BOCs(15,2.5,F);
            SQ = zeros(size(SI));
            
        case {'B3composite'}   
            P_B3_new = GNSS_POWERS.BEIDOU_B3_new/GNSS_POWERS.BEIDOU_B3_composite;            
            P_B3A = GNSS_POWERS.BEIDOU_B3A/GNSS_POWERS.BEIDOU_B3_composite;            
            
            S_B3_new = P_B3_new*spectrumgen_call('B3_new',F); 
            S_B3A = P_B3A*spectrumgen_call('B3A',F); 
            
            SI = S_B3_new;            
            SQ = S_B3A;            
    end
    end

function S = spectrum_BPSK(fc,F)
%==========================================================================
% BPSK of chipping rate fc.
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    S = sinc((1/fc)*F); 
    aux = sum(abs(S).^2)/length(S); 
    S = S/sqrt(aux);
    S = abs(S).^2;
end

function S = spectrum_BOCs(n,m,F) 
%==========================================================================
% sine-phased BOC even of a chipping rate fc=m*1.023e6 and sub-carrier rate
% of fs = n*1.023e6.
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    fs = n*1.023e6;
    fc = m*1.023e6;

    S = sinc((1/fc)*F).*tan(pi*F/(2*fs));     
    aux = sum(abs(S).^2)/length(S);
    S = S/sqrt(aux);
    S = abs(S).^2;
end

function S = spectrum_BOCc(n,m,F)   
%==========================================================================
% cosine-phased BOC even of a chipping rate fc=m*1.023e6 and sub-carrier
% rate of fs = n*1.023e6.
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    fs = n*1.023e6;
    fc = m*1.023e6;

    S = 2*sinc((1/fc)*F).*((sin(pi*F/(4*fs)).^2)./cos(pi*F/(2*fs)));     
    aux = sum(abs(S).^2)/length(S);
    S = S/sqrt(aux);
    S = abs(S).^2;
end

function S = spectrum_AltBOC(n,m,F)  
%==========================================================================
% sine-phased AltBOC even of a chipping rate fc=m*1.023e6 and sub-carrier
% rate of fs = n*1.023e6.
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    fs = n*1.023e6;
    fc = m*1.023e6;

    S = (4*fc./((pi*F).^2)).* ((cos(pi*F/(fc))).^2).* (((cos(pi*F/(2*fs))).^2) - cos(pi*F/(2*fs)) - 2*cos(pi*F/(2*fs)).*cos(pi*F/(4*fs)) + 2 ) ./ ((cos(pi*F/(2*fs))).^2);
    S_ = S;
    S_(find(isnan(S))) = 0;
    aux = sum(abs(S_))/length(S);     
    S = S/aux;
    S = abs(S);
end