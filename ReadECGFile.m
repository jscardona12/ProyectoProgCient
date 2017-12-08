function [ data ] = ReadECGFile( path )
%Función que se utiliza para leer el archivo que contiene los datos del
%ECG. Recibe el path al archivo y retorna un arreglo data.
ZeroVal=1024; %Valor de zeroVal para realizar la conversion de los datos.
Gain=200; %Valor de ganancia usado en la conversion de los datos.
disp(path);
fileID = fopen(path,'r'); %Se obtiene el fileID
data = fread(fileID,inf,'uint16'); %Se lee el data.
data = (data(:,1)-ZeroVal)/Gain; %Se realiza la conversion de los datos.
fclose(fileID);
end

