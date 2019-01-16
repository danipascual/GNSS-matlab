%-------------------------- test_2_cut ------------------------------------
% 	band: L1 (1.57543 GHz)
% 	Known present PRNs: GPS L1 C/A 13
%   baseband 16 bits complex (16 bit I + 16 bit Q)
% 	fs = 20 MSps
% 	duration = 5 ms
% 	data type: signed int16	
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 20e6;
% Coh_time = 1e-3;
% coh_samples = Coh_time*Fs;
% incoh_number = 1;
% % incoh_number = 5;
% incoh_samples = incoh_number*coh_samples;
% N_chips = 1023;
% FREQ_DOPP = linspace(-4e3,4e3,101);
% 
% fid = fopen('test_2_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int16'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% 
% [I, Q] = GNSSsignalgen(13,'L1CA',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%-------------------------- test_4_cut ------------------------------------
% 	band: L5 (1.17645 GHz)
% 	Known present PRNs: GPS L5 30
%   baseband 16 bits complex (16 bit I + 16 bit Q)
% 	fs = 20 MSps
% 	duration = 20 ms
% 	data type: signed int16	
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 20e6;
% FREQ_DOPP = linspace(0,3e3,101);
% 
% % L5
% % Coh_time = 1e-3;
% % incoh_number = 1;
% % % incoh_number = 20;
% % mod = 'L5';
% % N_chips = 10230;
% 
% % L5+
% % Coh_time = 20e-3;
% % incoh_number = 1;
% % mod = 'L5+';
% % N_chips = 10230*20;
% % FREQ_DOPP = linspace(0,3e3,31);
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% 
% 
% fid = fopen('test_4_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int16'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% 
% [I, Q] = GNSSsignalgen(30,mod,Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%-------------------------- test_14_cut ------------------------------------
% 	band: E1 (1.57543 GHz)
% 	Known present PRNs: Galielo E1OS 3
%   baseband 8 bits complex (8 bit I + 8 bit Q)
% 	fs = 50 MSps
% 	duration = 100 ms
% 	data type: signed int8
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 50e6;
% N_chips = 4092;
% FREQ_DOPP = linspace(0,1.5e3,51);
% 
% % E1OS
% % Coh_time = 4e-3;
% % incoh_number = 1;
% % % incoh_number = 25;
% % mod = 'E1OS';
% 
% % E1OS+
% % Coh_time = 100e-3;
% % incoh_number = 1;
% % mod = 'E1OS+';
% % FREQ_DOPP = linspace(0,1.5e3,11);
% 
% % E1OS_C
% % Coh_time = 4e-3;
% % incoh_number = 1;
% % % incoh_number = 25;
% % mod = 'E1OS_C';
% 
% % E1OS_B
% % Coh_time = 4e-3;
% % incoh_number = 1;
% % % incoh_number = 25;
% % mod = 'E1OS_B';
% 
% % E1OS+_C
% % Coh_time = 100e-3;
% % incoh_number = 1;
% % mod = 'E1OS+_C';
% % FREQ_DOPP = linspace(0,1.5e3,11);
% 
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% [I, Q] = GNSSsignalgen(3,mod,Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q
% 
% fid = fopen('test_14_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int8'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);

%-------------------------- test_11_cut ------------------------------------
% 	band: E5 (1.191795 GHz)
% 	Known present PRNs: Galielo E5 3
%   baseband 8 bits complex (8 bit I + 8 bit Q)
% 	fs = 50 MSps
% 	duration = 100 ms
% 	data type: signed int8
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % Fs = 50e6;            % EOO!!
% Fs = 49*1.023e6;
% N_chips = 10230;
% FREQ_DOPP = linspace(-5e3,5e3,51);
% 
% % E5
% % Coh_time = 1e-3;
% % incoh_number = 1;
% % % incoh_number = 100;
% % mod = 'E5';
% 
% % E5+
% Coh_time = 100e-3;
% incoh_number = 1;
% mod = 'E5+';
% FREQ_DOPP = linspace(-1e3,1e3,31);
% 
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% [I, Q] = GNSSsignalgen(3,mod,Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q
% 
% fid = fopen('test_11_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int8'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% signal_bb = resample(signal_bb,3*7^2,2^4);  % EOO!!
% signal_bb = resample(signal_bb,11*31,5^5);

%-------------------------- test_5_cut ------------------------------------
% 	band: E5A (1.176450000 GHz)
% 	Known present PRNs: Galielo E5A 30
%   baseband 16 bits complex (16 bit I + 16 bit Q)
% 	fs = 20 MSps
% 	duration = 5 ms
% 	data type: signed int8
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 20e6;
% N_chips = 10230;
% FREQ_DOPP = linspace(-1e3,1e3,51);
% 
% Coh_time = 1e-3;
% incoh_number = 1;
% % incoh_number = 5;
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% [I, Q] = GNSSsignalgen(30,'E5A',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q
% 
% fid = fopen('test_5_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int16'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% signa_bb = signal_bb(5e-3*Fs:end);


%-------------------------- test_6_cut ------------------------------------
% 	band: E5B (1.20714 GHz)
% 	Known present PRNs: Galielo E5B 7
% 	baseband 16 bits complex (16 bit I + 16 bit Q)
% 	fs = 20 MSps
% 	duration = 5 ms
% 	data type: signed int8	
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 20e6;
% N_chips = 10230;
% FREQ_DOPP = linspace(-1e3,2e3,51);
% 
% Coh_time = 1e-3;
% incoh_number = 1;
% % incoh_number = 5;
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% [I, Q] = GNSSsignalgen(7,'E5B',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q
% 
% fid = fopen('test_6_cut.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'int16'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% signa_bb = signal_bb(5e-3*Fs:end);


%-------------------------- Capture 4 ------------------------------------
% 	I don't remember the bit depth, but most probably was 8 bits
% 	The original sampling frequency as well, it was downcoverted 
%   fs = 2.5 MSps
%   duration = 1.5 s
%   band: L2 (1.2276 GHz)
%   Known present PRNs: GPS L2C 26
%   data type: Matlab complex int16 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Fs = 2.5e6;
% dopp_reference = -1.697660000000000e+03;
% 
% % mod = 'L2CM';
% % Coh_time = 20e-3;
% % incoh_number = 75;
% % N_chips = 10230;
% % FREQ_DOPP = linspace(dopp_reference-10,dopp_reference+10,51);
% 
% % mod = 'L2CL';
% % Coh_time = 1.5;
% % incoh_number = 1;
% % N_chips = 767250;
% % FREQ_DOPP =  linspace(dopp_reference-10, dopp_reference+10, 11);
% 
% mod = 'L2C';
% Coh_time = 1.5;
% incoh_number = 1;
% N_chips = 767250;
% FREQ_DOPP =  linspace(dopp_reference-10, dopp_reference+10, 11);
% 
% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% signal_bb = importdata('capture_04.mat');
% signal_bb = double(signal_bb);
% 
% [I, Q] = GNSSsignalgen(26,mod,Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%% Histogram and spectum

% Histogram
[a,b]=hist(real(signal_bb),1001);
a = 100*a/sum(a);
figure, 
       bar(b,a);
        grid minor
        title('Histogram');
        xlabel('value')
        ylabel('%')
        text(b(1),max(a),['Kurtosis = ' num2str(kurtosis(real(signal_bb))) ],'BackgroundColor','r')
        clear a b
        
% Spectrum
K = Fs*1e-3*0.25;
N = length(signal_bb);
M = floor(N/K);
N = M*K;

S = pow2db(mean(abs(fftshift(fft(reshape(signal_bb(1:N) ,[N/M M])))).^2,2));
S = smooth(S);
F = linspace(-Fs/2,Fs/2,length(S));
 
figure, 
        title('Spectrum');
        plot(F/1e6,S); grid on
        grid minor
        ylabel('Power [dB]')
        xlabel('Frequency [MHz]')
        clear F S

%% Main
    
WAF = zeros(coh_samples,length(FREQ_DOPP));
WAF_coh = zeros(coh_samples,length(FREQ_DOPP));
Coh_vector = linspace(0,Coh_time,coh_samples);

for k=1:incoh_number
    for i=1:length(FREQ_DOPP)
            % Incorrect way
%         aux = exp(1i*2*pi*FREQ_DOPP(i).*Coh_vector);
%         WAF_coh(:,i) = ifft(fft(signal_bb(1+(k-1)*coh_samples:k*coh_samples)).*conj(fft(signal_reference.*aux))); 
        
        aux = exp(-1i*2*pi*FREQ_DOPP(i).*Coh_vector);
        WAF_coh(:,i) = ifft(fft(signal_bb(1+(k-1)*coh_samples:k*coh_samples).*aux).*conj(fft(signal_reference)));         
    end
    WAF = WAF+abs(WAF_coh).^2;
end





%% Plot

[valor,pos_dopp] = max(max(abs(WAF)));
[~,pos_delay] = max(max(abs(WAF')));

% Cross-correlation
figure, 
        plot(Coh_vector*1000,  abs(WAF(:,pos_dopp)));
%         text(0,valor/2,['Incoherent = ' num2str(incoh_number) ],'BackgroundColor','r')
        xlabel('Delay [ms]')
        ylabel('Power (linear) [arbritary units]')
        title('Cross-correlation power at Doppler zero')
        grid minor
        
% Sinc
figure, 
        plot(FREQ_DOPP/1e3,  abs(WAF(pos_delay,:)));
%         text(FREQ_DOPP(1)/1e3,valor/2,['Incoherent = ' num2str(incoh_number) ],'BackgroundColor','r')
        xlabel('Doppler [kHz]')
        ylabel('Power (linear) [arbritary units]')
        title('Cross-correlation power at delay zero')
        grid minor

% WAF
span_samples = round( (100 * (Coh_time/N_chips) * Fs)/2)*2;
pos_delay_up = pos_delay+ span_samples/2;
pos_delay_down =pos_delay- span_samples/2;
figure,
        mesh(FREQ_DOPP/1e3,Coh_vector(pos_delay_down:pos_delay_up)*1000,abs(WAF(pos_delay_down:pos_delay_up,:)))
%         text(FREQ_DOPP(1)/1e3,Coh_vector(pos_delay_down)*1000,valor/2,['Incoherent = ' num2str(incoh_number) ],'BackgroundColor','r')
        ylabel('Delay [ms]')
        xlabel('Doppler [kHz]')
        zlabel('Power (linear) [arbritary units]')
        title('Cross-ambiguity')
        xlim([FREQ_DOPP(1) FREQ_DOPP(end)]/1000);
        ylim([Coh_vector(pos_delay_down) Coh_vector(pos_delay_up)]*1000);
        grid minor
        