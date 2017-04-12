% Uncomment individual Example lines.

%---- Example 1: E1OS (nyquist frequency)
fs = 12*1.023e6;
n_E1OS_periods = 1;

%---- Example 2: E1OS (nyquist frequency, several periods)
% fs = 12*1.023e6;
% n_E1OS_periods = 11.782;    % arbitrary

%---- Example 3: E1OS (higher frequency, several periods)
% fs = 21*1.023e6;
% n_E1OS_periods = 11.782;

%---- Example 4: E1OS (higher frequency, sub period)
% fs = 21*1.023e6;
% n_E1OS_periods = 0.8;

%---- Example 5: E1OS (sub-nyquist frequency, several periods)
% fs = 8*1.023e6;
% n_E1OS_periods = 11.782;

%---- Example 6: E1OS (sub-nyquist frequency non multiple, several periods)
% fs = 8*1e6;
% n_E1OS_periods = 1.2;

%---- Example 7: E1OS (higher frequency non multiple, several periods)
% fs = 16*1e6;
% n_E1OS_periods = 1.2;

coh_time = n_E1OS_periods*4e-3;
fh = BOCgen;
[sboc_1, sboc_6] = fh.BOC_E1OS(coh_time,fs);
sub_1 = sboc_6+sboc_1;
sub_2 = -sboc_6+sboc_1;

%==========================================================================  
%% Plots
%==========================================================================  
t_boc_chips = linspace(0,1.023e6*coh_time,length(sboc_1));

figure,
       stairs(t_boc_chips,sub_1,'b');
       grid on;
       title('E1B sub-carrier');
       xlabel('BOC symbol period')
       ylabel('amplitude');
figure,       
       stairs(t_boc_chips,sub_2,'b') ;
       grid on;
       title('E1C sub-carrier');
       xlabel('BOC symbol period')
       ylabel('amplitude');
       
       
% Next plot just shows that consecutive BOC symbols are identical        
sub_period = round(fs/1.023e6);       
n_periods = floor(length(sboc_1)/sub_period);  
figure, hold on;
for i=1:n_periods-1
     plot(sub_1(sub_period*(i-1)+1:sub_period*i)-sub_1(sub_period*i+1:sub_period*(i+1)));    
end