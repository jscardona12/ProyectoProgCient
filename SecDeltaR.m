function [ distance, tiempos ] = SecDeltaR( distances )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
count = 0;
k = 1;
j =1;
distance = [];
for i=1:size(distances,2)
    count = count + distances(i);
    prom(j) = distances(i);
    a = floor(count/30) ;
    if  count >= 30
        distance(k) = mean(prom);
        prom =[];
        k = k +1;
        j = 0;
        count = 0;
    end
    if k == 20 && i == size(distances,2)
        distance(k) = mean(prom);
        prom =[];
        k = k +1;
        j = 0;
        count = 0;
    end
end


end

