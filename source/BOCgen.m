function fh = BOCgen
%==========================================================================
%BOCgen Functions to generate BOC sub-carriers.
%   fh = BOCgen returns the handlers of the local functions:
%
%   <strong>BOCsgen</strong>
%   [sboc] = BOCsgen(fboc, coh_time,fs) returns a sine-phased BOC of
%   frequency fboc, sampled with fs and with a duration of coh_time.
%
%   <strong>BOCcgen</strong>
%   [cboc] = BOCcgen(fboc,coh_time,fs) returns a sine-phased BOC of
%   frequency fboc, sampled with fs and with a duration of coh_time.
%
%   <strong>BOC_E1OS</strong>
%   [sboc_1, sboc_6] = BOC_E1OS(coh_time,fs) returns the 2 sub-carriers to
%   generate a Galileo E1OS signal, sampled with fs and with a duration 
%   of coh_time.
% 
%   <strong>BOC_E5</strong>
%   [sd1, sd2, sp1 sp2] = BOC_E5(coh_time,fs) returns the 4 sub-carriers to
%   generate a Galileo E5 signal, sampled with fs and with a duration of
%   coh_time.
%
%   Observations     
%       # All the sub-carriers are real and normalized in power, except for
%       the E1OS and E5, which are already weighted to generate the signal.
%       # This code have been tested satisfactorily to acquire real L1C/A, 
%       L5 and E1OS signals, but there has not been any chance yet to test 
%       it with E5 signals.
% 
%   References
%       # Galileo Open Service Signal In Space Interface ControlDocument
%       (OS SIS ICD)
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

    fh.BOCsgen = @BOCsgen;
    fh.BOCcgen = @BOCcgen;
    fh.BOC_E1OS = @BOC_E1OS; 
    fh.BOC_E5 = @BOC_E5;
end

function [sboc] = BOCsgen(fboc,coh_time,fs)
%==========================================================================
% sine-phased BOC sub-carrier
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    sine_period = [-1 1];
    sboc = sample(sine_period,fs*coh_time,2*fboc,fs,0);

%--------------------------------------------------------------------------
% I first tried to generate the sub-carriers with the sign function.
% However Matlab has issues when rounding, and the resulting frequency was
% not perfectly repeated after some cycles.
    
%     t = linspace(0,coh_time,fs*coh_time);
%     sboc = sign(sin(2*pi*fboc*t)); 
    
end

function [cboc] = BOCcgen(fboc,coh_time,fs)
%==========================================================================
% cosine-phased BOC sub-carrier
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    sine_period = [1 -1];
    cboc = sample(sine_period,fs*coh_time,2*fboc,fs,0);

%--------------------------------------------------------------------------
% I first tried to generate the sub-carriers with the sign function.
% However Matlab has issues when rounding, and the resulting frequency was
% not perfectly repeated after some cycles.
    
%     t = linspace(0,coh_time,fs*coh_time);
%     cboc = sign(cos(2*pi*fboc*t));    
end

function [sboc_1, sboc_6] = BOC_E1OS(coh_time,fs)
%==========================================================================
% CBOC in-phase and anti-phase sub-carriers for E1OS
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    fboc_1 = 1*1.023e6;
    fboc_6 = 6*1.023e6;
    
    sine_period = [1 -1];

    sboc_1 = sample(sine_period,fs*coh_time,2*fboc_1,fs,0); 
    sboc_6 = sample(sine_period,fs*coh_time,2*fboc_6,fs,0);  

    sboc_1 = sqrt(10/11)*sboc_1;
    sboc_6 = sqrt(1/11)*sboc_6;
    
%--------------------------------------------------------------------------
% I first tried to generate the sub-carriers with the sign function.
% However Matlab has issues when rounding, and the resulting frequency was
% not perfectly repeated after some cycles.

% Attempt 1
% t = linspace(0,coh_time,fs*coh_time);    
% sboc_1 = sign(sin(2*pi*fboc_1*t)); 
% sboc_1(sboc_1==0) =  1;
% 
% sboc_6 = sign(sin(2*pi*fboc_6*t)); 
% sboc_6(sboc_6==0) =  1;

% Attempt 2   
% t = linspace(0,coh_time,fs*coh_time);
% 
% T1 = 1/fboc_1;
% t1=mod(t,T1);    
% T2 = 1/fboc_6;
% t2=mod(t,T2);       
% 
% sboc_1 =  sign(sin(2*pi*fboc_1*t1)); 
% sboc_1(sboc_1==0) =  1;
% 
% sboc_6 = sign(sin(2*pi*fboc_6*t2)); 
% sboc_6(sboc_6==0) =  1;

% sboc_1 = sqrt(10/11)*sboc_1;
% sboc_6 = sqrt(1/11)*sboc_6;
%--------------------------------------------------------------------------
end

function [sd1, sd2, sp1 sp2]  = BOC_E5(coh_time,fs)
%==========================================================================
% sub-carriers for E5 AltBOC
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual [at] protonmail.com) 
% Copyright 2017 Daniel Pascual
% License: GNU GPLv3
%==========================================================================

    a = (sqrt(2)+1)/2;
    b = 1/2;
    c= (sqrt(2)-1)/2;
    d = -c;
    e = -b;
    f=  -a;

    spread_data = [a b e f f e b a];
    spread_pilot =[d b e c c e b d];

    M = 120;
    N = round(fs/1.023e6);
    T = M/gcd_true(M,N);
    P = N/gcd_true(M,N);
    L_M = lcm_true(T,8);
    L_N = L_M*P/T;

    ro=[0:L_N-1];
    idxs = floor(8*15 * mod(ro/N,1/15 ));

    aux = floor(N*1.023e6*coh_time/L_N);      
    idxs = repmat(idxs,1,aux);

    if (length(idxs)>floor(fs*coh_time))
        idxs = idxs(1:floor(fs*coh_time));
    elseif (length(idxs)<floor(fs*coh_time))
        idxs = [idxs idxs(1:floor(fs*coh_time)-length(idxs))];
    end

    delay = 2;
    
    spread_data2 = circshift(spread_data',delay)';
    spread_pilot2 = circshift(spread_pilot',delay)';    

    sd1 = spread_data(idxs+1)';
    sp1 = spread_pilot(idxs+1)';
    sd2 = spread_data2(idxs+1)';
    sp2 = spread_pilot2(idxs+1)';  

%--------------------------------------------------------------------------
% I first tried to generate the sub-carriers with the sign function.
% However Matlab has issues when rounding, and the resulting frequency was
% not perfectly repeated after some cycles.       

%         n = 15;
%         fboc = n*1.023e6;
% 
%         % Attempt 1
%         t = linspace(0,coh_time,fs*coh_time)';      
% 
%         % Attempt 2
%     %     T = 1/fboc;
%     %     t=0:1/fs:(coh_time*fs)/fs-(1/fs);
%     %     t=mod(t,T);
% 
%         delay = 1/(4*n*1.023e6);
% 
%         sd1 = (sqrt(2)/4)*sign(cos(2*pi*fboc*t-pi/4)) + 0.5*sign(cos(2*pi*fboc*t)) + (sqrt(2)/4)*sign(cos(2*pi*fboc*t+pi/4)) ;
%         sp1 = -(sqrt(2)/4)*sign(cos(2*pi*fboc*t-pi/4)) + 0.5*sign(cos(2*pi*fboc*t)) - (sqrt(2)/4)*sign(cos(2*pi*fboc*t+pi/4))  ;
% 
%         sd2 = (sqrt(2)/4)*sign(cos(2*pi*fboc*(t- delay)-pi/4 )) + 0.5*sign(cos(2*pi*fboc*(t- delay) )) + (sqrt(2)/4)*sign(cos(2*pi*fboc*(t- delay)+pi/4))  ;
%         sp2 = -(sqrt(2)/4)*sign(cos(2*pi*fboc*(t- delay)-pi/4- delay)) + 0.5*sign(cos(2*pi*fboc*(t- delay))) - (sqrt(2)/4)*sign(cos(2*pi*fboc*(t- delay)+pi/4))  ;

end