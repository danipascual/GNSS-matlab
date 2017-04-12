 fh = GNSSspectrumgen;
 F = linspace(-50e6,50e6,1001);
  
%-------------------- GPS L1  ---------------------------------------------               
[S_L1_I, S_L1_Q] =  fh.spectrumgen_call('L1',F);
S_L1 = S_L1_I+S_L1_Q;
S_L1CA =  fh.spectrumgen_call('L1CA',F);        
S_L1P =  fh.spectrumgen_call('L1P',F);
S_L1M =  fh.spectrumgen_call('L1M',F);
[S_L1C_d, S_L1C_p] = fh.spectrumgen_call('L1C',F); 
S_L1C = S_L1C_d+S_L1C_p;
[S_L1_new_I, S_L1_new_Q] =  fh.spectrumgen_call('L1_new',F);
S_L1_new = S_L1_new_I+S_L1_new_Q;

figure, hold on;
        plot(F/1e6,10*log10(S_L1));
        plot(F/1e6,10*log10(S_L1_I),'r');
        plot(F/1e6,10*log10(S_L1_Q),'c');
        title('1-Watt L1 spectrum (prior to Block III)')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('Composite','I','Q')
        grid on;
        ylim([-30 30])

figure, hold on;
        plot(F/1e6,10*log10(S_L1C_d));
        plot(F/1e6,10*log10(S_L1C_p),'r');
        title('1-Watt L1C spectrum ')        
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('I (Data)','Q (Pilot)')
        grid on;    
        ylim([-30 30])
        
figure, hold on;
        plot(F/1e6,10*log10(S_L1CA));
        plot(F/1e6,10*log10(S_L1P),'r');
        plot(F/1e6,10*log10(S_L1M),'c');
        plot(F/1e6,10*log10(S_L1C),'black');
        title('L1 Block III components spectra 1-Watt normalized')        
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('C/A','P','M','L1C')
        grid on;    
        ylim([-30 30])        
        
figure, hold on;
        plot(F/1e6,10*log10(S_L1));
        plot(F/1e6,10*log10(S_L1_new),'r');
        title('1-Watt L1 spectrum comparison')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('Prior to Block III','Block III')
        grid on;
        ylim([-30 30])      
        
%-------------------- Galileo  --------------------------------------------               
[S_E1_I, S_E1_Q] =  fh.spectrumgen_call('E1',F);
[S_E6_I, S_E6_Q] =  fh.spectrumgen_call('E6',F);
[S_E5_I, S_E5_Q] =  fh.spectrumgen_call('E5',F);
[S_E5A_I, S_E5A_Q] =  fh.spectrumgen_call('E5A',F);

figure, hold on;
        plot(F/1e6,10*log10(S_E1_I));
        plot(F/1e6,10*log10(S_E1_Q),'r');
        title('1-Watt E1 spectrum ')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('OS','PRS')
        grid on;
        ylim([-30 30])   
        
figure, hold on;
        plot(F/1e6,10*log10(S_E6_I));
        plot(F/1e6,10*log10(S_E6_Q),'r');
        title('1-Watt E6 spectrum ')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('OS','PRS')
        grid on;
        ylim([-30 30])     
        
figure, hold on;
        plot(F/1e6,10*log10(S_E5_I));
        plot(F/1e6,10*log10(S_E5_Q),'r');
        title('1-Watt E5 spectrum ')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('I','Q')
        grid on;
        ylim([-30 30])          
        
figure, hold on;
        plot(F/1e6,10*log10(S_E5A_I));
        plot(F/1e6,10*log10(S_E5A_Q),'r');
        title('1-Watt E5A spectrum ')
        ylabel('PSD (dBW/Hz)');
        xlabel('Frequency (MHz)');
        legend('I','Q')
        grid on;
        ylim([-30 30])           