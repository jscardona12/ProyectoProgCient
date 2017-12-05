% f_SendTCPIPData.m

clc
% addpath('data/data');

s_DataType = 1; 
% 1 - File 100-ECG
% 2 - File 101-ECG
% 3 - File 102-ECG
% 4 - File 103-ECG
% 5 - File 104-ECG
% 6 - File 105-ECG

s_SRate = 360;
switch s_DataType
    case 1
        s_FileID = fopen('100-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    case 2
        s_FileID = fopen('101-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    case 3
        s_FileID = fopen('102-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    case 4
        s_FileID = fopen('103-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    case 5
        s_FileID = fopen('104-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    case 6
        s_FileID = fopen('105-ECG.bin');
        m_Data = fread(s_FileID, 'uint16');
    otherwise
        
end

% figure;
% plot(v_Time, m_Data)

str_IPServer = 'localhost';
s_IPPort = 8800;

s_Conn = tcpip(str_IPServer, s_IPPort, 'NetworkRole', 'client');
fopen(s_Conn);

s_TimeSendSec = 0.125;
s_SamNum = s_TimeSendSec * s_SRate;
s_PauseTimerSendSec = s_TimeSendSec * 0.9;

s_FirstInd = 1;
s_PointCounter  = 0;


fprintf('[f_SendTCPIPData] - Press a key to start simulation\n')
pause

fprintf('[f_SendTCPIPData] - Starting simulation\n')

while 1
    s_LastInd = s_FirstInd + s_SamNum - 1;
    if s_LastInd > numel(m_Data)
        break;
    end
        
    v_DataAux = m_Data(s_FirstInd:s_LastInd);
    fwrite(s_Conn, v_DataAux(:), 'float32');
    
    pause(s_PauseTimerSendSec);
    
    fprintf('.')
    s_PointCounter = s_PointCounter + 1;
    
    if s_PointCounter > 100
        fprintf('\n')
        s_PointCounter = 0;
    end
        
    s_FirstInd = s_LastInd + 1;    
end

fprintf('\n[f_SendTCPIPData] - Simulation finished\n')


