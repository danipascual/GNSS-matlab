function code_sampled = sample(code,nsamples,chipRate,samplFreq,sampPhase)
%==========================================================================
% Samples a code with a given sampling frequency.
% code ---> input signal.
% nsamples --> number samples
% chipRate --> input code chiprate.
% samplFreq --> sampling frequency.
% sampPhase --> phase shift.
%--------------------------------------------------------------------------
% Version log (main changes)
%   22/11/2012 --> Log started
%--------------------------------------------------------------------------
% Author: NSL (code adapted from stereo example program)
%==========================================================================

    len = length(code);    
    idxs = floor((0:nsamples-1) .* (chipRate/samplFreq) + sampPhase);
    idxs = 1+mod(idxs, len);
  	code_sampled = code(:, idxs)';    

end
  
  
  
