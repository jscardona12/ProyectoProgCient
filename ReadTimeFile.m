function [ data ] = ReadTimeFile( path )
%Esta funcion se utiliza para leer los datos del archivo tiempo asociado a
%cada uno de los electrocardiogramas.
fileID = fopen(path,'r'); %Se obtiene el fileID
data = fread(fileID,inf,'double'); %Se lee el data.
fclose(fileID);
end

