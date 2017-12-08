function [ distance ] = DeltaR( Peaks )
%Funcion para encontrar las distancias entre los picos. Recibe los picos
%encontrados y retorna un arreglo con las distancias.
for i=2:size(Peaks,1)
    distance(i) = Peaks(i)-Peaks(i-1); %Ciclo que va calculando las distancias.
end

distance =  distance(2:end); %Se toma a partir del segundo valor.


end


