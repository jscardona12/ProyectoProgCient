function [ data ] = ReadECGFile( path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ZeroVal=1024;
Gain=200;
disp(path);
fileID = fopen(path,'r'); %Se obtiene el fileID
data = fread(fileID,inf,'uint16'); %Se lee el data.
data = (data(:,1)-ZeroVal)/Gain;
fclose(fileID);
end

