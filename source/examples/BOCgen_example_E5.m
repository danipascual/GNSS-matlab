% Uncomment individual Example lines.

%---- Example 1: E5 (nyquist frequency)
fs = 120*1.023e6;
n_E5_periods = 1;

%---- Example 2: E5 (nyquist frequency, several periods)
% fs = 120*1.023e6;
% n_E5_periods = 8.2;

%---- Example 3: E5 (sub-nyquist frequency, several periods)
% fs = 10*1.023e6;
% n_E5_periods = 2.2;

%---- Example 4: E5 (higher frequency, several periods)
% fs = 130*1.023e6;
% n_E5_periods = 1.2;

%---- Example 4: E5 (higher frequency non multiple, several periods)
% fs = 130*1e6;
% n_E5_periods = 1.2;

%---- Example 4: E5 (lower frequency non multiple, several periods)
% fs = 10*1e6;
% n_E5_periods = 1.2;

coh_time = n_E5_periods*1e-3;
fh = BOCgen;
[sd1, sd2, sp1 sp2]  = fh.BOC_E5(coh_time,fs);

%==========================================================================  
%% Plots
%==========================================================================  
t_boc_chips = linspace(0,1.023e6*120*coh_time,length(sd1));

figure; 
        hold on;
        stairs(t_boc_chips,sd1,'b');
        stairs(t_boc_chips,sd2,'r');
        grid on;
        title('Data spread codes');
        xlabel('BOC symbol period')
        ylabel('amplitude');        
        legend('Data spread code', 'Data spread code delayed');
        
figure; hold on;        
        stairs(t_boc_chips,sp1,'b');
        stairs(t_boc_chips,sp2,'r');        
        grid on;  
        title('Pilot spread codes');
        xlabel('BOC symbol period')
        ylabel('amplitude'); 
        legend('Pilot spread code', 'Pilot spread code delayed');
        
% Next plots just shows that consecutive BOC symbols are identical              
sub_period = round(fs/1.023e6*120);       
n_periods = floor(length(sd1)/sub_period);  
figure, hold on;
for i=1:n_periods-1
     plot(sd2(sub_period*(i-1)+1:sub_period*i)-sd2(sub_period*i+1:sub_period*(i+1)));    
end    

figure, hold on;
for i=1:n_periods-1
     plot(sd1(sub_period*(i-1)+1:sub_period*i)-sd1(sub_period*i+1:sub_period*(i+1)));    
end    

figure, hold on;
for i=1:n_periods-1
     plot(sp1(sub_period*(i-1)+1:sub_period*i)-sp1(sub_period*i+1:sub_period*(i+1)));    
end    

figure, hold on;
for i=1:n_periods-1
     plot(sp2(sub_period*(i-1)+1:sub_period*i)-sp2(sub_period*i+1:sub_period*(i+1)));    
end    