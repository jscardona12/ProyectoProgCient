function [ distance ] = DeltaR( Peaks )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=2:size(Peaks,1)
   
    distance(i) = Peaks(i)-Peaks(i-1);
end



end

