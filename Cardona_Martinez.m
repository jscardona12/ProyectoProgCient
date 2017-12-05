clear; clc; close all;


ZeroVal=1024;
Gain=200;

path = '109-ECG__.bin';

C = strsplit(path,'-');
numeroArchivo = C{1};
stringTime = strcat(numeroArchivo,'-Time__.bin');
stringTxt = strcat(numeroArchivo,'-Ann__.txt');

Y = ReadECGFile(strcat('Work_Data/',path)); %Se carga el EGC data.
X = ReadTimeFile(strcat('Work_Data/',stringTime)); %Se carga el tiempo para dicho archivo.

%Notas: Arritmias entre 5 y 9. El primer valor de las anotaciones no sale
%porque es el inicio, donde el pico es negativo. tHRESHOLD MAS GENERAL,
%SACAR MEDIA Y SI ESTA POR ENCIMA DE LA MEDIA + DESV ESTANDAR, ES ARRITMIA
figure;
plot(X,Y); %Se grafica el electrocardiograma.

[PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.09);

[PKS2,LOC2] = findpeaks(PKS,LOCS,'Threshold',0.1);

[PKS3,LOC3] = findpeaks(PKS,LOCS,'MinPeakProminence',0.5);

anotaciones = ReadTxt(strcat('Work_Data/',stringTxt));
annTime = anotaciones{1,1};
annCode = anotaciones{1,2};

count = 0;
for i=1:size(annCode,1)
    if annCode(i) >= 5 && annCode(i) <=9
        count = count+1;
    end
end
figure(2);
distances = DeltaR(LOCS);
plot(LOCS,distances);

media = mean(distances);
desv = std(distances);
x = media + desv/2;
k = 1;
for i=1:size(distances,2)
    if distances(1,i) >= x 
        arritmias(k) = distances(1,i);
        tiempos(k) = LOCS(i)
        k = k+1;
    end
end


