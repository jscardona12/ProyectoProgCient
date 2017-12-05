% f_RecTCPIPData.m

clc

str_IPServer = 'localhost';
s_IPPort = 8800;

s_ChannNum = 1;
s_SRate = 360;
s_BuffSizeSec = 10;
s_BuffSizeSam = s_BuffSizeSec * s_SRate;
m_DataBuff = zeros(s_ChannNum, s_BuffSizeSam);
s_PlotTimerSec = 0.2;


s_Conn = tcpip('0.0.0.0' , s_IPPort, 'NetworkRole', 'server');
s_Conn.InputBufferSize = s_BuffSizeSam * 4;
fopen(s_Conn);
pause(0.5);

s_PlotTimer = tic;
s_LastIndBuff = 0;

s_Fig = figure;
v_Axes = zeros(1, 1);
v_Axes(1) = subplot(1,1,1);
while 1
    if s_Conn.BytesAvailable <= 0
        pause(0.010);
        continue;
    end
    
    m_DataAux = fread(s_Conn, s_Conn.BytesAvailable / 4, 'float32');
    m_DataAux = reshape(m_DataAux, s_ChannNum, []);
    
    s_IniIndBuff = s_LastIndBuff + 1;
    if s_IniIndBuff > s_BuffSizeSam
        s_IniIndBuff = 1;
    end
    s_LastIndBuff = s_IniIndBuff + size(m_DataAux, 2) - 1;
    
    if s_LastIndBuff <= s_BuffSizeSam
        v_Ind = s_IniIndBuff:s_LastIndBuff;
    else
        s_LastIndBuff = s_LastIndBuff - s_BuffSizeSam;
        v_Ind = [s_IniIndBuff:s_BuffSizeSam 1:s_BuffSizeSam];
    end

    m_DataBuff(:, s_IniIndBuff:s_LastIndBuff) = m_DataAux;
    
    if toc(s_PlotTimer) >= s_PlotTimerSec
        s_PlotTimer = tic;
        
        plot(v_Axes(1), m_DataBuff')
        xlim(v_Axes(1), [1 size(m_DataBuff, 2)]);
        v_Lims = get(v_Axes(1), 'YLim');
        hold(v_Axes(1), 'on');
        plot(v_Axes(1), [s_LastIndBuff s_LastIndBuff], v_Lims, 'r');
        hold(v_Axes(1), 'off');
        set(v_Axes(1), 'XTick', []);
    end
end

