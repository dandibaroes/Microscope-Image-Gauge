function varargout = projek_dosen(varargin)
% PROJEK_DOSEN MATLAB code for projek_dosen.fig
%      PROJEK_DOSEN, by itself, creates a new PROJEK_DOSEN or raises the existing
%      singleton*.
%
%      H = PROJEK_DOSEN returns the handle to a new PROJEK_DOSEN or the handle to
%      the existing singleton*.
%
%      PROJEK_DOSEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEK_DOSEN.M with the given input arguments.
%
%      PROJEK_DOSEN('Property','Value',...) creates a new PROJEK_DOSEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projek_dosen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projek_dosen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projek_dosen

% Last Modified by GUIDE v2.5 28-Mar-2019 17:19:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projek_dosen_OpeningFcn, ...
                   'gui_OutputFcn',  @projek_dosen_OutputFcn, ...
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

% --- Executes just before projek_dosen is made visible.
function projek_dosen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projek_dosen (see VARARGIN)
% Choose default command line output for projek_dosen
imaqreset;
cla reset;
global vid
global hImage;
vid = videoinput('winvideo',1,'YUY2_640x480');
hImage = image(zeros(480, 640, 3),'Parent',handles.axes1);
axes(handles.axes1);
preview(vid, hImage);

% UIWAIT makes projek_dosen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projek_dosen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.axes1;

% --- Executes on button press in tangkap.
function tangkap_Callback(hObject, eventdata, handles)
% hObject    handle to tangkap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
global data
set(vid, 'ReturnedColorSpace', 'RGB');
data=getsnapshot(vid);
axes(handles.axes3);
imshow(data);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[file,path] = uigetfile('*.jpg','*.bmp');
data = imread([path file]);
guidata(hObject,handles);
axes(handles.axes3);
imshow(data);


% --- Executes on button press in rset.
function rset_Callback(hObject, eventdata, handles)
% hObject    handle to rset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear mentah
clear xx
clear data
clear xx_px
clear grey
clear tepi
clc
set(handles.edit1,'String','');
set(handles.Panjang, 'String', '');
cla(handles.axes3,'reset');

% --- Executes on button press in keluar.
function keluar_Callback(hObject, eventdata, handles)
% hObject    handle to keluar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in edge.
function edge_Callback(hObject, eventdata, handles)
% hObject    handle to edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
global tepi
global grey
grey = rgb2gray(data);
tepi = edge(grey,'canny');
guidata(hObject,handles);
axes(handles.axes3);
imshow(tepi);


% --- Executes on button press in plt.
function plt_Callback(hObject, eventdata, handles)
% hObject    handle to plt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear mentah
clear xx
clear data
clear xx_px
clear grey
clear tepi
global mentah
global tepi
global grey

if (isempty(tepi) || isempty(grey))
  msgbox("Pilih Citra Grayscale atau Citra Biner!")
else
[cx,cy,f]=improfile;
assignin('base','cx',cx);
assignin('base','cy',cy);
xx_px = sqrt((cx).^2+(cy).^2);
assignin('base','xx_px',xx_px);


yy = f;
assignin('base','yy',yy);
px = (mentah);
xx = xx_px.*px;

assignin('base','xx',xx);
first_valuepx = xx_px(1);
assignin('base','first_valuepx',first_valuepx);
last_valuepx = xx_px(end);
assignin('base','last_valuepx',last_valuepx);

first_valuemm = xx(1);
assignin('base','first_valuemm',first_valuemm);
last_valuemm = xx(end);
assignin('base','last_valuemm',last_valuemm);

panjang_px = abs(last_valuepx - first_valuepx);
assignin('base','panjang_px',panjang_px);
panjang_mm = abs(last_valuemm - first_valuemm);
assignin('base','panjang_mm',panjang_mm);

xx_px0 = abs(xx_px - first_valuepx);
assignin('base','xx_px0',xx_px0);

xx0 = abs(xx - first_valuemm);
assignin('base','xx0',xx0);

set(handles.edit1,'string',num2str(panjang_px));
set(handles.Panjang,'string',num2str(panjang_mm));

figure
subplot(2,1,1)
plot(xx_px0,yy); legend('Grafik intensitas terhadap dimensi sample')
xlabel('dimensi sample (pixel)') 
ylabel('Intensity')

subplot(2,1,2)
plot(xx0,yy); legend('Grafik intensitas terhadap dimensi sample')
xlabel('dimensi sample (mm)') 
ylabel('Intensity')
end

% --- Executes on selection change in list_perbesaran.
function list_perbesaran_Callback(hObject, eventdata, handles)
% hObject    handle to list_perbesaran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_perbesaran contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_perbesaran
global mentah
format long
konten = cellstr(get(hObject,'String'));
ukuran = konten(get(hObject,'Value'));
if (strcmp(ukuran,'Pilih Perbesaran'))
    msgbox("pilih salah satu perbesaran")
elseif(strcmp(ukuran,'Perbesaran 1x'))
    mentah = 0.0068796;
elseif(strcmp(ukuran,'Perbesaran 2x'))
    mentah = 0.0034374;
elseif(strcmp(ukuran,'Perbesaran 3x'))
    mentah = 0.0022921;
elseif(strcmp(ukuran,'Perbesaran 4x'))
    mentah = 0.0017063;
elseif(strcmp(ukuran,'Perbesaran 10x'))
    mentah = 0.00095476513732387;
elseif(strcmp(ukuran,'Perbesaran 16x'))
    mentah = 0.000034874279;
end
assignin('base','mentah',mentah);



% --- Executes during object creation, after setting all properties.
function list_perbesaran_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_perbesaran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in grey_img.
function grey_img_Callback(hObject, eventdata, handles)
% hObject    handle to grey_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grey
global data
grey = rgb2gray(data);
axes(handles.axes3);
imshow(grey);
