function [ sensitivity, prediccion] = Validacion( tiempos, arrs  )
%Función utilizada para la validacion de los resultados. Recibe un vector
%con los tiempos obtenidos por el algoritmo y otro con los tiempos de las
%anotaciones.
%Se inicializan los contadores:
i = 1;
j = 1;
tp = 0;
fp = 0;
fn = 0
while i <= size(tiempos,2) && j<=size(arrs,2) %Mientras queden datos en los arreglos continua.
    tiempo = tiempos(i); %Tiempo encontrado en la iteraion i
    ann = arrs(j); %Tiempo de las anotaciones en la iteracion j
    if tiempo <= ann +0.55 && tiempo >= ann - 0.55  %Si estos tiempos varian son iguales con un margen de eror de 0.55 se considera positivo el resultado.
        tp = tp + 1; %Se aumentan los verdaderos positivos.
        i = i + 1; %se aumenta el contador i.
    end
    if(tiempo + 0.55 < ann )
        i = i + 1; %Como se sabe que los datos stan en orden. Se puede avanzar en i cuando se cumple esta condicion.
    else
        j = j + 1;%Caso contrario avanza j.
    end
end
fn = size(arrs,2) - tp; %Los falsos negativos son el numero de datos correctos menos los verdaderos positivos.
fp = size(tiempos,2) - tp; %Falsos positivos son el numero de datos encontrados y marcados como arritmias, menos el numero correcto.
sensitivity = tp/(tp+fn); %Se calcula la sensibilidad.
prediccion = tp/(tp+fp); %Se calcula las predicciones positivas.
end

