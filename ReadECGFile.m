function [ data ] = ReadECGFile( path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(path,'r'); %Se obtiene el fileID
data = fread(fileID,inf,'uint16'); %Se lee el data.
fclose(fileID);
end

