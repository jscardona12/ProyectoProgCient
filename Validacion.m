function [ sensitivity, prediccion] = Validacion( tiempos, arrs  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
i = 1;
j = 1;
tp = 0;
fp = 0;
fn = 0
while i <= size(tiempos,2) && j<=size(arrs,2)
    tiempo = tiempos(i); 
    ann = arrs(j);
    if tiempo <= ann +0.55 && tiempo >= ann - 0.55 
        tp = tp + 1;
        i = i + 1;
    end
    if(tiempo + 0.55 < ann )
        i = i + 1;
    else
        j = j + 1;
    end
end
fn = size(arrs,2) - tp;
fp = size(tiempos,2) - tp;
sensitivity = tp/(tp+fn);
prediccion = tp/(tp+fp);
end

