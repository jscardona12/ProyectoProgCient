clear; clc; close all;
ZeroVal=1024;
Gain=200;

path = '105-ECG__.bin';

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

%[peack,locs_Rwave] = findpeaks(Y,X,'MinPeakHeight',0.5,...
                                   % 'MinPeakDistance',0.);
[PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5);

%[PKS2,LOC2] = findpeaks(PKS,LOCS,'Threshold',0.1);

%[PKS3,LOC3] = findpeaks(PKS,LOCS,'MinPeakProminence',0.5);

anotaciones = ReadTxt(strcat('Work_Data/',stringTxt));
annTime = anotaciones{1,1};
annCode = anotaciones{1,2};

count = 0;
for i=1:size(annCode,1)
    if annCode(i) >= 5 && annCode(i) <=9
        count = count+1;
        arrs(count) = annTime(i);
    end
end
figure(2);
distances = DeltaR(LOCS);
plot(LOCS(2:end),distances);

media = 0.9;
desv = 0.3;
x1 = media + desv;
x2 = media - desv;
k = 1;
for i=1:size(distances,2)
    if distances(1,i) >= x1 ||  distances(1,i) <= x2
        arritmias(k) = PKS(i);
        distancias(k) = distances(1,i);
        tiempos(k) = LOCS(i);
        k = k+1;
    end
end

%[arritmias,tiempos] = Umbral(distances,PKS,LOCS);

figure(3)
plot(X,Y)
hold on
plot(tiempos,arritmias,'rv','MarkerFaceColor','r');
hold off
bpm = 60./(distances(1:end));
figure(4)
plot(LOCS(2:end),bpm);


[ sensitivity, prediccion] = Validacion(tiempos,arrs);





