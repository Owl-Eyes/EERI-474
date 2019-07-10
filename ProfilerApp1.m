function varargout = ProfilerApp1(varargin)
% PROFILERAPP1 MATLAB code for ProfilerApp1.fig
%      PROFILERAPP1, by itself, creates a new PROFILERAPP1 or raises the existing
%      singleton*.
%
%      H = PROFILERAPP1 returns the handle to a new PROFILERAPP1 or the handle to
%      the existing singleton*.
%
%      PROFILERAPP1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROFILERAPP1.M with the given input arguments.
%
%      PROFILERAPP1('Property','Value',...) creates a new PROFILERAPP1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProfilerApp1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProfilerApp1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProfilerApp1

% Last Modified by GUIDE v2.5 04-Jul-2019 18:40:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProfilerApp1_OpeningFcn, ...
                   'gui_OutputFcn',  @ProfilerApp1_OutputFcn, ...
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


% --- Executes just before ProfilerApp1 is made visible.
function ProfilerApp1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProfilerApp1 (see VARARGIN)

% Choose default command line output for ProfilerApp1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProfilerApp1 wait for user response (see UIRESUME)
% uiwait(handles.ProfilerApp);

% My Own Variables
%flagSave = 0;


% --- Outputs from this function are returned to the command line.
function varargout = ProfilerApp1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnDEMSelect.
function btnDEMSelect_Callback(hObject, eventdata, handles)
% hObject    handle to btnDEMSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open file dialog with DEM file types
[filename, pathname] = uigetfile({
 '*.tif','TIF Files (*.tif)'; ...
 '*.ddf','SDTS Files (*.ddf)'; ...
 '*.hgt','SRTM Files (*.hgt)'; ...
 '*.dem','DEM Files (*.dem)'; ...
 '*.*','All Files (*.*)'}, ...
   'Pick a tile file');

% Tell user which file they're busy with
handles.lblDEMFile.String = filename;

% API file path
handles.lblDEMFile.UserData = pathname;


ProfileExtractionCode
% copyobj(tileFig,axDEM);

% DEM and points not confirmed
dem_select_flag = 0;
point_select_flag = 0;

% --- Executes on button press in btnConfirm.
function btnConfirmDEM_Callback(hObject, eventdata, handles)
% hObject    handle to btnConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Continue main program
dem_select_flag = 0;
uiresume(ProfilerApp1);
%handles.btnConfirmDEM.UserData = 1;
fprintf('Received DEM \n')

function edALat_Callback(hObject, eventdata, handles)
% hObject    handle to edALat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edALat as text
%        str2double(get(hObject,'String')) returns contents of edALat as a double


% --- Executes during object creation, after setting all properties.
function edALat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edALat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edALong_Callback(hObject, eventdata, handles)
% hObject    handle to edALong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edALong as text
%        str2double(get(hObject,'String')) returns contents of edALong as a double


% --- Executes during object creation, after setting all properties.
function edALong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edALong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnHelp.
function btnHelp_Callback(hObject, eventdata, handles)
% hObject    handle to btnHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Message = {'Welcome to the DEM Profile Extraction Application!' ' ' ...
          'Select a DEM file using the ''Select DEM'' button.' ' ' ...
          'Enter your latitude and longitue coordinates in the edit boxes'...
          'for point A and B (start and end point respectively).' ' ' ...
          'To save a complete profile, type a save file name into the'...
          'edit box, and click the save button.'};
Title = 'DEM Profiler Help';
help = msgbox(Message,Title);
set(help,'position',[500,350,250,130]);

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% flag variable, set = 1
flagSave = 1;

inputfname = handles.edSave.String;
fname = sprintf('%s.mat',inputfname);
save(fname) % Save in main instead!!!!

% API saving:
handles.edSave.UserData = fname;

% --- Executes on button press in btnAdd.
function btnAdd_Callback(hObject, eventdata, handles)
% hObject    handle to btnAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edBLong_Callback(hObject, eventdata, handles)
% hObject    handle to edBLong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edBLong as text
%        str2double(get(hObject,'String')) returns contents of edBLong as a double


% --- Executes during object creation, after setting all properties.
function edBLong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBLong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edBLat_Callback(hObject, eventdata, handles)
% hObject    handle to edBLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edBLat as text
%        str2double(get(hObject,'String')) returns contents of edBLat as a double


% --- Executes during object creation, after setting all properties.
function edBLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btnDEMSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edSave_Callback(hObject, eventdata, handles)
% hObject    handle to edSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSave as text
%        str2double(get(hObject,'String')) returns contents of edSave as a double


% --- Executes during object creation, after setting all properties.
function edSave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnConfirmPoints.
function btnConfirmPoints_Callback(hObject, eventdata, handles)
% hObject    handle to btnConfirmPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

point_select_flag = 0;
uiresume(ProfilerApp1)
%handles.btnConfirmPoints.UserData = 1;
fprintf('Received coordinates \n')


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnConfirmDEM.
function btnConfirmDEM_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnConfirmDEM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
