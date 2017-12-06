function [ arritmias,tiempos ] = Umbral( distances,PKS,LOCS )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
k=1;
arritmias = [];
tiempos = [];
i = 2;
while i <= size(distances,2)-1
    R1 = distances(i-1);
    R2 = distances(i);
    R3 = distances(i+1);
    if R2 >0.6 && (R3 < R2)
        %
        if R1< 0.8 && R2 < 0.8 && R3 <0.8 && ((R1 + R2 + R3) < 1.8)
            arritmias(k) = PKS(i);
            tiempos(k) = LOCS(i);
             k = k+1;
        end
    else
        arritmias(k) = PKS(i);
        tiempos(k) = LOCS(i);
        k = k+1;
    end
    i = i + 3;
end
end

