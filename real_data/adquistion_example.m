%-------------------------- Capture 1 ------------------------------------
% Fs = 10e6;
% Coh_time = 1e-3;
% coh_samples = Coh_time*Fs;
% incoh_number = 10;
% incoh_samples = incoh_number*coh_samples;
% FREQ_DOPP = linspace(-4e3,-1e3,101);
% 
% fid = fopen('capture_01.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'double'); fclose(fid);   
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% 
% [I Q] = GNSSsignalgen(5,'L1CA',Fs,1);
% % [I Q] = GNSSsignalgen(9,'L1CA',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%-------------------------- Capture 2 ------------------------------------
% Fs = 25e6;
% Coh_time = 4e-3;
% coh_samples = Coh_time*Fs;
% incoh_number = 4;
% incoh_samples = incoh_number*coh_samples;
% FREQ_DOPP = linspace(0,4e3,201);
% 
% fid = fopen('capture_02.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'double'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
% 
% [I Q] = GNSSsignalgen(12,'E1OS',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%-------------------------- Capture 3 ------------------------------------
% Fs = 10e6;
% Coh_time = 1e-3;
% coh_samples = Coh_time*Fs;
% incoh_number = 20;
% incoh_samples = incoh_number*coh_samples;
% FREQ_DOPP = linspace(-3e3,0,101);
%
% fid = fopen('capture_03.dat','rb');
% fseek(fid,0,'bof');
% signal_bb = fread(fid, [2 incoh_samples], 'double'); fclose(fid); 
% signal_bb = signal_bb(1,:) + 1i*signal_bb(2,:);
%
% [I Q] = GNSSsignalgen(1,'L5',Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%-------------------------- Capture 4 ------------------------------------
Fs = 2.5e6;

mod = 'L2CM';
Coh_time = 20e-3;
incoh_number = 75;
polla =   -1.697660000000000e+03;
FREQ_DOPP = linspace(polla-10,polla+10,51);

% mod = 'L2CL';
% Coh_time = 1.5;
% incoh_number = 1;
% aux = -1.697660000000000e+03;
% FREQ_DOPP =  linspace(aux-1, aux+1, 3);

% mod = 'L2C';
% Coh_time = 1.5;
% incoh_number = 1;
% aux = -1.697660000000000e+03;
% FREQ_DOPP =  linspace(aux-1, aux+1, 3);


% coh_samples = Coh_time*Fs;
% incoh_samples = incoh_number*coh_samples;
% signal_bb = importdata('capture_04.mat');
% 
% [I Q] = GNSSsignalgen(26,mod,Fs,1);
% signal_reference = (I+1j*Q)'; clear I Q

%--------------------------------------------------------------------------

WAF = zeros(coh_samples,length(FREQ_DOPP));
Coh_vector = linspace(0,Coh_time,coh_samples);


for k=1:incoh_number
    WAF_coh = zeros(coh_samples,length(FREQ_DOPP));
    for i=1:length(FREQ_DOPP)
        aux = exp(-1i*2*pi*FREQ_DOPP(i).*Coh_vector);
        WAF_coh(:,i) = abs(fftshift(ifft(fft(signal_bb(1+(k-1)*coh_samples:k*coh_samples).*aux).*conj(fft(signal_reference))))); 
    end
    WAF = WAF+WAF_coh;
end

[~,pos] = max(max(abs(WAF)));
figure, plot(abs(WAF(:,pos)));

[~,pos] = max(max(abs(WAF')));
figure, mesh(abs(WAF(pos-400:pos+400,:)))