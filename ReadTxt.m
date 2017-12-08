function [ data ] = ReadTxt( path )
%Esta funci�n se utiliza para leer el archivo de anotaciones. Recibe el
%path y retorna un arreglo data.
fileID = fopen(path,'r'); %Se obtiene el fileid.
header = textscan(fileID,'%s',2); %Se quita el header del archivo.
data = textscan(fileID,'%f %d'); %Se leen los datos.
fclose(fileID);

end