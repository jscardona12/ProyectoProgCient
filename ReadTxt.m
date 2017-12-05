function [ data ] = ReadTxt( path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(path,'r');
header = textscan(fileID,'%s',2);
data = textscan(fileID,'%f %d');
fclose(fileID);

end

