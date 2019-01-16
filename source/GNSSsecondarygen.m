function code = GNSSsecondarygen(svnum, code_primary)
% GNSSsignalgen GNSSsecondarygen a secodondary code.
%   code = GNSSsignalgen(svnum, modulation,fs,n_periods) returns the
%   secondary codes with values 1/0.
%
%   Inputs
%       svnum --> Satellite number. GPS: [1-32], Galileo: [1-50].
%       code_primary --> L5I, L5Q, E1C, E5aI, E5aQ, E5bI, E5bQ
%
%   Observations
%       # L5I, L5Q, E1C, E5aI, E5bI are the same for all svnum. 
%       # chipping rates --> L5I/L5Q/E5aI/E5aQ/E5bI/E5bQ: 1 kHz, 
%       E1C: 250 Hz
%       # Period lenght --> L5I: 10 ms, L5Q: 20ms, E1C: 100ms,
%       E5aI: 20ms, E5aQ/E5bQ: 100ms, E5bI: 4ms.
%       # This code have been tested satisfactorily to acquire real L5, 
%       E1OS and E5 signals.
%   
%   References
%       # L5: GPS Interface Control Document IS-GPS-705
%       # Galileo: Galileo Open Service Signal In Space Interface Control
%       Document (OS SIS ICD)
%--------------------------------------------------------------------------
% Version log (main changes)
%   17/11/2017 --> Log started
%   16/1/2019 --> E5bQ and E5aQ were not generated properly. Fixed.
%--------------------------------------------------------------------------
% Author: Daniel Pascual (daniel.pascual at protonmail.com) 
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

    for i=1:length(svnum)

         switch(code_primary)

            case 'L5I'  % 10 Neumann-Hoffman code            
                code = [0 0 0 0 1 1 0 1 0 1];                              

            case 'L5Q'  % 20 Neumann-Hoffman code   
                code =  [0 0 0 0 0 1 0 0 1 1 0 1 0 1 0 0 1 1 1 0];

            case 'E1C'  % CS25_1           
                code = dec2bin(hex2dec('380AD90'),28);
                code = code(1:25);
                code = str2num(code')';

            case 'E5aI'   % CS20_1
                code = dec2bin(hex2dec('842E9'));
                code = str2num(code')';

            case 'E5aQ' % CS100_1 to CS100_50
                switch(svnum(i))
                    case 1
                        code_hex = '83F6F69D8F6E15411FB8C9B1C';
                    case 2
                        code_hex = '66558BD3CE0C7792E83350525';
                    case 3
                        code_hex = '59A025A9C1AF0651B779A8381';
                    case 4
                        code_hex = 'D3A32640782F7B18E4DF754B7';
                    case 5
                        code_hex = 'B91FCAD7760C218FA59348A93';
                    case 6
                        code_hex = 'BAC77E933A779140F094FBF98';
                    case 7  
                        code_hex = '537785DE280927C6B58BA6776';
                    case 8
                        code_hex = 'EFCAB4B65F38531ECA22257E2';
                    case 9
                        code_hex = '79F8CAE838475EA5584BEFC9B';
                    case 10
                        code_hex = 'CA5170FEA3A810EC606B66494';
                    case 11
                        code_hex = '1FC32410652A2C49BD845E567';
                    case 12
                        code_hex = 'FE0A9A7AFDAC44E42CB95D261';
                    case 13
                        code_hex = 'B03062DC2B71995D5AD8B7DBE';
                    case 14
                        code_hex = 'F6C398993F598E2DF4235D3D5';
                    case 15
                        code_hex = '1BB2FB8B5BF24395C2EF3C5A1';
                    case 16
                        code_hex = '2F920687D238CC7046EF6AFC9';
                    case 17
                        code_hex = '34163886FC4ED7F2A92EFDBB8';
                    case 18
                        code_hex = '66A872CE47833FB2DFD5625AD';
                    case 19
                        code_hex = '99D5A70162C920A4BB9DE1CA8';
                    case 20
                        code_hex = '81D71BD6E069A7ACCBEDC66CA';
                    case 21
                        code_hex = 'A654524074A9E6780DB9D3EC6';
                    case 22
                        code_hex = 'C3396A101BEDAF623CFC5BB37';
                    case 23
                        code_hex = 'C3D4AB211DF36F2111F2141CD';
                    case 24
                        code_hex = '3DFF25EAE761739265AF145C1';
                    case 25
                        code_hex = '994909E0757D70CDE389102B5';
                    case 26
                        code_hex = 'B938535522D119F40C25FDAEC';
                    case 27
                        code_hex = 'C71AB549C0491537026B390B7';
                    case 28
                        code_hex = '0CDB8C9E7B53F55F5B0A0597B';
                    case 29
                        code_hex = '61C5FA252F1AF81144766494F';
                    case 30
                        code_hex = '626027778FD3C6BB4BAA7A59D';
                    case 31
                        code_hex = 'E745412FF53DEBD03F1C9A633';
                    case 32
                        code_hex = '3592AC083F3175FA724639098';
                    case 33
                        code_hex = '52284D941C3DCAF2721DDB1FD';
                    case 34
                        code_hex = '73B3D8F0AD55DF4FE814ED890';
                    case 35
                        code_hex = '94BF16C83BD7462F6498E0282';
                    case 36
                        code_hex = 'A8C3DE1AC668089B0B45B3579';
                    % No assignments between 37 and 39
                    case 40
                        code_hex = '22D6E2A768E5F35FFC8E01796';
                    case 41
                        code_hex = '25310A06675EB271F2A09EA1D';
                    case 42
                        code_hex = '9F7993C621D4BEC81A0535703';
                    case 43
                        code_hex = 'D62999EACF1C99083C0B4A417';
                    case 44
                        code_hex = 'F665A7EA441BAA4EA0D01078C';
                    case 45
                        code_hex = '46F3D3043F24CDEABD6F79543';
                    case 46
                        code_hex = 'E2E3E8254616BD96CEFCA651A';
                    case 47
                        code_hex = 'E548231A82F9A01A19DB5E1B2';
                    case 48
                        code_hex = '265C7F90A16F49EDE2AA706C8';
                    case 49
                        code_hex = '364A3A9EB0F0481DA0199D7EA';
                    case 50
                        code_hex = '9810A7A898961263A0F749F56';
                end

%                 code = dec2bin(hex2dec(code_hex));
%                 code = str2num(code')';       

                for k=1:length(code_hex)
                    code_dec(k) = (hex2dec(code_hex(k)));
                end

                code = dec2bin(code_dec,4);
                code = code';
                code = code(:);
                code = str2num(code)';

            case 'E5bI' % CS4_1
                code = dec2bin(hex2dec('E'));
                code = str2num(code')';          

            case 'E5bQ'  % CS100_51 to CS100_100
                switch(svnum(i))
                    case 1
                        code_hex = 'CFF914EE3C6126A49FD5E5C94';
                    case 2
                        code_hex = 'FC317C9A9BF8C6038B5CADAB3';
                    case 3
                        code_hex = 'A2EAD74B6F9866E414393F239';
                    case 4
                        code_hex = '72F2B1180FA6B802CB84DF997';
                    case 5
                        code_hex = '13E3AE93BC52391D09E84A982';
                    case 6
                        code_hex = '77C04202B91B22C6D3469768E';
                    case 7
                        code_hex = 'FEBC592DD7C69AB103D0BB29C';
                    case 8
                        code_hex = '0B494077E7C66FB6C51942A77';
                    case 9
                        code_hex = 'DD0E321837A3D52169B7B577C';
                    case 10
                        code_hex = '43DEA90EA6C483E7990C3223F';
                    case 11
                        code_hex = '0366AB33F0167B6FA979DAE18';
                    case 12
                        code_hex = '99CCBBFAB1242CBE31E1BD52D';
                    case 13
                        code_hex = 'A3466923CEFDF451EC0FCED22';
                    case 14
                        code_hex = '1A5271F22A6F9A8D76E79B7F0';
                    case 15
                        code_hex = '3204A6BB91B49D1A2D3857960';
                    case 16
                        code_hex = '32F83ADD43B599CBFB8628E5B';
                    case 17
                        code_hex = '3871FB0D89DB77553EB613CC1';
                    case 18
                        code_hex = '6A3CBDFF2D64D17E02773C645';
                    case 19
                        code_hex = '2BCD09889A1D7FC219F2EDE3B';
                    case 20
                        code_hex = '3E49467F4D4280B9942CD6F8C';
                    case 21
                        code_hex = '658E336DCFD9809F86D54A501';
                    case 22
                        code_hex = 'ED4284F345170CF77268C8584';
                    case 23
                        code_hex = '29ECCE910D832CAF15E3DF5D1';
                    case 24
                        code_hex = '456CCF7FE9353D50E87A708FA';
                    case 25
                        code_hex = 'FB757CC9E18CBC02BF1B84B9A';
                    case 26
                        code_hex = '5686229A8D98224BC426BC7FC';
                    case 27
                        code_hex = '700A2D325EA14C4B7B7AA8338';
                    case 28
                        code_hex = '1210A330B4D3B507D854CBA3F';
                    case 29
                        code_hex = '438EE410BD2F7DBCDD85565BA';
                    case 30
                        code_hex = '4B9764CC455AE1F61F7DA432B';
                    case 31
                        code_hex = 'BF1F45FDDA3594ACF3C4CC806';
                    case 32
                        code_hex = 'DA425440FE8F6E2C11B8EC1A4';
                    case 33
                        code_hex = 'EE2C8057A7C16999AFA33FED1';
                    case 34
                        code_hex = '2C8BD7D8395C61DFA96243491';
                    case 35
                        code_hex = '391E4BB6BC43E98150CDDCADA';
                    case 36
                        code_hex = '399F72A9EADB42C90C3ECF7F0';
                    case 37
                        code_hex = '93031FDEA588F88E83951270C';
                    case 38
                        code_hex = 'BA8061462D873705E95D5CB37';
                    case 39
                        code_hex = 'D24188F88544EB121E963FD34';
                    case 40
                        code_hex = 'D5F6A8BB081D8F383825A4DCA';
                    case 41
                        code_hex = '0FA4A205F0D76088D08EAF267';
                    case 42
                        code_hex = '272E909FAEBC65215E263E258';
                    case 43
                        code_hex = '3370F35A674922828465FC816';
                    case 44
                        code_hex = '54EF96116D4A0C8DB0E07101F';
                    case 45
                        code_hex = 'DE347C7B27FADC48EF1826A2B';
                    case 46
                        code_hex = '01B16ECA6FC343AE08C5B8944';
                    case 47
                        code_hex = '1854DB743500EE94D8FC768ED';
                    case 48
                        code_hex = '28E40C684C87370CD0597FAB4';
                    case 49
                        code_hex = '5E42C19717093353BCAAF4033';
                    case 50
                        code_hex = '64310BAD8EB5B36E38646AF01';
                end

%                 code = dec2bin(hex2dec(code_hex));
%                 code = str2num(code')';       

                for k=1:length(code_hex)
                    code_dec(k) = (hex2dec(code_hex(k)));
                end

                code = dec2bin(code_dec,4);
                code = code';
                code = code(:);
                code = str2num(code)';              
         end
        code2(i,:) = code;
    end
    code = code2;    
end
