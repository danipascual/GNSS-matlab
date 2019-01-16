%% GPS
% for i = 1:32
%     codes_L1CA(:,i) = GNSScodegen(i,'L1CA',0); 
%     codes_L2CM(:,i) = GNSScodegen(i,'L2CM',0); 
%     codes_L2CL(:,i) = GNSScodegen(i,'L2CL',0);
%     codes_L5I(:,i) = GNSScodegen(i,'L5I',0);
%     codes_L5Q(:,i) = GNSScodegen(i,'L5Q',0);
% end

% save('codes_L1CA.mat','codes_L1CA');
% save('codes_L2CM.mat','codes_L2CM');
% save('codes_L2CL.mat','codes_L2CL');
% save('codes_L5I.mat','codes_L5I');
% save('codes_L5Q.mat','codes_L5Q');

%% Galileo
% for i = 1:50
%     codes_E5aI(:,i) = GNSScodegen(i,'E5aI',0);
%     codes_E5aQ(:,i) = GNSScodegen(i,'E5aQ',0);
%     codes_E5bI(:,i) = GNSScodegen(i,'E5bI',0);
%     codes_E5bQ(:,i) = GNSScodegen(i,'E5bQ',0);      
%     codes_E1B(:,i) = GNSScodegen(i,'E1B',0);      
%     codes_E1C(:,i) = GNSScodegen(i,'E1C',0);   
% end
% 
% save('codes_E5aI.mat','codes_E5aI');
% save('codes_E5aQ.mat','codes_E5aQ');
% save('codes_E5bI.mat','codes_E5bI');
% save('codes_E5bQ.mat','codes_E5bQ');
% save('codes_E1B.mat','codes_E1B');
% save('codes_E1C.mat','codes_E1C');

%% BeiDou
% for i = 1:37
%     codes_B1I(:,i) = GNSScodegen(i,'B1I',0);
% end
% 
% save('codes_B1I.mat','codes_B1I');