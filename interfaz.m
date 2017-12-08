function varargout = interfaz(varargin)
% INTERFAZ MATLAB code for interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz

% Last Modified by GUIDE v2.5 07-Dec-2017 13:50:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
fileName = '';
% --- Executes just before interfaz is made visible.
function interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz (see VARARGIN)

% Choose default command line output for interfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using interfaz.
if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
end

% UIWAIT makes interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Se crea un arreglo con los nombres de los archivos.
a = ["100-ECG__.bin";"105-ECG__.bin"; "109-ECG__.bin"; "116-ECG__.bin"; "118-ECG__.bin"; "119-ECG__.bin"]
axes(handles.axes3); %Se selecciona la grafica 3.
index = get(handles.popupmenu1, 'Value') %Se obtiene el indice del archivo seleccionado por el usuario.
path = a(index); %El path es la posición index en el arreglo a.
C = strsplit(path,'-'); %Se hace un split por el guion para obtener el numero del archivo seleccionado.
numeroArchivo = C{1}; %Se obtiene el numero de archivo seleccionado.
stringTime = strcat(numeroArchivo,'-Time__.bin'); %Se genera el path para los datos de tiempo.
stringTxt = strcat(numeroArchivo,'-Ann__.txt'); %Se genera el path para los datos de anotaciones.

Y = ReadECGFile(strcat('Work_Data/',path)); %Se carga el EGC data.
X = ReadTimeFile(strcat('Work_Data/',stringTime)); %Se cargan los tiempos asociados.
plot(X,Y) %Se realiza la grafica inicial.
%Se establecen los umbrales para cada paciente.
switch index
    case 1
        media = 0.9;
        desv = 0.3;
        x1 = media + desv;
        x2 = media - desv;
        %Se filtran los picos a partir de una altura minima de 0.5 y una
        %distancia minima entre ellos de 0.12
        [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.12);
    case 2
        media = 0.9;
        desv = 0.3;
        x1 = media + desv;
        x2 = media - desv;
        [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.12);
    case 3
        media = 0.9;
        desv = 0.3;
        x1 = media + desv;
        x2 = media - desv;
         [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.12);
    case 4
        media = 0.9;
        desv = 0.3;
        x1 = media + desv;
        x2 = media - desv;
        [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.12);
    case 5
        media = 0.9;
        desv = 0.3;
        x1 = 1.8;
        x2 = 0.4;
       [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.2);
    case 6
        media = 0.9;
        desv = 0.3;
        x1 = media + desv;
        x2 = media - desv
       [PKS,LOCS] = findpeaks(Y,X,'MinPeakHeight',0.5,'MinPeakDistance',0.7);
       %COMMIT
end


anotaciones = ReadTxt(strcat('Work_Data/',stringTxt)); %Se cargan los datos de las anotaciones.
annTime = anotaciones{1,1}; %Se obtiene cada una de las columnas del archivo de anotaciones.
annCode = anotaciones{1,2};

%El siguiente ciclo cuenta el numero de arritmias que se deben encontrar
%segun el archivo de anotaciones. Se considero arritmia a los tipos ente 5
%y 9. Adicional, se guardaron los tiempos en los que ocurren dichas
%arritmias, esto con el fin de validar posteriormente.
count = 0;
for i=1:size(annCode,1)
    if annCode(i) >= 5 && annCode(i) <=9
        count = count+1;
        arrs(count) = annTime(i);
    end
end
axes(handles.axes4); %Se selecciono la grafica 4 en interfaz.
distances = DeltaR(LOCS); %Se calcularon las distancias entre los R.
plot(LOCS(2:end),distances); %Se grafico el tacograma.
%Se agregan titulos.
title("Tacograma")
xlabel("tiempo(s)");
ylabel("R-Rinterval(s)")

%El siguiente ciclo realiza la validacion de las distancias para determinar
%las posibles arritmiar, una vez encontrada se guardan datos de la misma en
%los arreglos arritmias, distancias y tiempos.
k = 1;
for i=1:size(distances,2)
    if distances(1,i) >= x1 ||  distances(1,i) <= 0.6
        arritmias(k) = PKS(i);
        distancias(k) = distances(1,i);
        tiempos(k) = LOCS(i);
        k = k+1;
    end
end

axes(handles.axes3); %Se selecciona el grafico 3.
plot(X,Y) %Se grafica el inicial.
hold on
%Se marcan las arritmias sobre la grafica del electrocardiograma.
plot(tiempos,arritmias,'rv','MarkerFaceColor','r');
hold off
%Se ponen los titulos.
title("ECG VS TIEMPO")
legend("ECG","Arritmias");
xlabel("tiempo(s)");
ylabel("ECG")
%Se calcula el bpm
bpm = 60./(distances(1:end));
axes(handles.axes5); %Se selecciona la grafica 5 y se grafica el bpm
plot(LOCS(2:end),bpm);
title("BPM VS TIEMPO")
xlabel("tiempo(s)");
ylabel("BPM")

%Se calcula la sensibilidad y las prediccines positivas y se actualizan los
%labels en la interfaz.
[ sensitivity, prediccion] = Validacion(tiempos,arrs);
set(handles.text3,'String',num2str(sensitivity));
set(handles.text4,'String',num2str(prediccion));


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
disp(hObject);
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 contents = get(hObject,'String'); %returns popupmenu1 contents as cell array
disp(contents{get(hObject,'Value')}) %returns selected item from popupmenu1
handles.fileName = contents{get(hObject,'Value')};



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end
fileName = '100-ECG__.bin';
set(hObject, 'String', {'100-ECG__.bin', '105-ECG__.bin', '109-ECG__.bin', '116-ECG__.bin', '118-ECG__.bin','119-ECG__.bin'});


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, ~, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
