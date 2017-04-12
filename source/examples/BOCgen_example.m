fboc = 10*1.023e6;
coh_time = 1e-3/10;
fs = 20*1.023e6;

fh = BOCgen;
[cboc] = fh.BOCsgen(fboc,coh_time,fs);  % Sine BOC
%[cboc] = fh.BOCcgen(fboc,coh_time,fs); % Cosine BOC

%==========================================================================  
%% Plots
%========================================================================== 
t_boc_chips = linspace(0,fboc*coh_time,length(cboc));
figure, stairs(t_boc_chips,cboc)
        title('BOC signal');
        ylabel('Amplitude')
        xlabel('BOC symbol period')

% Next plot just shows that consecutive BOC symbols are identical        
sub_period = round(fs/fboc);       
n_periods = floor(length(cboc)/sub_period);  
figure, hold on;
for i=1:n_periods-1
     plot(cboc(sub_period*(i-1)+1:sub_period*i)-cboc(sub_period*i+1:sub_period*(i+1)));    
end 