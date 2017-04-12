%==========================================================================
%   Observations
%       # I think that L2 can also transmit a C/A component, but they
%       actually never do it.
%       # I am not sure if the future BeiDou signals will replace or 
%       complement the former signals. Now I assume they will replace.
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

classdef GNSS_POWERS
    properties (Constant)
        % GPS L1
        GPS_L1_P = 10^((-161.5-3)/10);       
        GPS_L1_CA = 10^((-158.5-3)/10);
        GPS_L1_M = 10^((-157-3)/10);
        GPS_L1_C = 10^((-157-3)/10);
        GPS_L1_Cd = 1/4*GNSS_POWERS.GPS_L1_C;
        GPS_L1_Cp1 = (29/33)*(3/4)*GNSS_POWERS.GPS_L1_C;
        GPS_L1_Cp2 = (4/33)*(3/4)*GNSS_POWERS.GPS_L1_C;
        GPS_L1_Cp = GNSS_POWERS.GPS_L1_Cp1+GNSS_POWERS.GPS_L1_Cp2;

        GPS_L1 = GNSS_POWERS.GPS_L1_P+GNSS_POWERS.GPS_L1_CA+GNSS_POWERS.GPS_L1_M;
        GPS_L1_new = GNSS_POWERS.GPS_L1+GNSS_POWERS.GPS_L1_C;

        % GPS L5
        GPS_L5 = 10^((-157.9-3)/10)*2;
        GPS_L5_new = 10^((-157-3)/10)*2;

        % GPS L2
        GPS_L2_P =  10^((-164.5-3)/10);
        GPS_L2_P_new = 10^((-161.5-3)/10);
        GPS_L2_C = 10^((-160-3)/10);
        GPS_L2_C_new = 10^((-158.5-3)/10);
        GPS_L2_M = 10^((-157-3)/10);
     
        GPS_L2 = GNSS_POWERS.GPS_L2_P;       
        GPS_L2_new = GNSS_POWERS.GPS_L2_P_new+GNSS_POWERS.GPS_L2_C+GNSS_POWERS.GPS_L2_M;    
        GPS_L2_new_2 = GNSS_POWERS.GPS_L2_P_new+GNSS_POWERS.GPS_L2_C_new + GNSS_POWERS.GPS_L2_M;

        % Galileo E1
        GALILEO_E1A = 10^(-157/10);
        GALILEO_E1B = 10^(-157/10)*(10/11);
        GALILEO_E1C = 10^(-157/10)*(1/11);
        GALILEO_E1 = GNSS_POWERS.GALILEO_E1A+GNSS_POWERS.GALILEO_E1B+GNSS_POWERS.GALILEO_E1C;

        % Galileo E6
        GALILEO_E6A = 10^(-155/10);
        GALILEO_E6B = 10^(-155/10)*0.5;
        GALILEO_E6C = 10^(-155/10)*0.5;
        GALILEO_E6 = GNSS_POWERS.GALILEO_E6A+GNSS_POWERS.GALILEO_E6B+GNSS_POWERS.GALILEO_E6C;   

        % Galileo E5
        GALILEO_E5= 10^(-155/10)*2;       

        % BeiDou-2 
        BEIDOU_B11 = 10^(-163/10)*2;
        BEIDOU_B12 =  10^(-163/10)*2;
        BEIDOU_B1 = GNSS_POWERS.BEIDOU_B11+GNSS_POWERS.BEIDOU_B12;
        BEIDOU_B2I = 10^(-163/10);
        BEIDOU_B2Q = 10^(-163/10);
        BEIDOU_B2 =  GNSS_POWERS.BEIDOU_B2I+GNSS_POWERS.BEIDOU_B2Q;
        BEIDOU_B3 =  10^(-163/10)*2;

        % I assume -163...
        BEIDOU_B1Cd = 10^(-163/10)*(10/11);
        BEIDOU_B1Cp = 10^(-163/10)*(1/11);
        BEIDOU_B1C = GNSS_POWERS.BEIDOU_B1Cd+GNSS_POWERS.BEIDOU_B1Cp;
        BEIDOU_B1_new = 10^(-163/10);
        BEIDOU_B1_composite = GNSS_POWERS.BEIDOU_B1C+GNSS_POWERS.BEIDOU_B1_new;
        BEIDOU_B1_full = GNSS_POWERS.BEIDOU_B1+GNSS_POWERS.BEIDOU_B1_composite;

        BEIDOU_B2_new = 10^(-163/10)*2
        BEIDOU_B2_full = GNSS_POWERS.BEIDOU_B2+GNSS_POWERS.BEIDOU_B2_new;

        BEIDOU_B3_new = 10^(-163/10)*2;
        BEIDOU_B3A = 10^(-163/10);
        BEIDOU_B3_composite = GNSS_POWERS.BEIDOU_B3_new+GNSS_POWERS.BEIDOU_B3A;
        BEIDOU_B3_full = GNSS_POWERS.BEIDOU_B3_composite+GNSS_POWERS.BEIDOU_B3;    
    end
end