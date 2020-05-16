function varargout = GUI(varargin)
% figureGUI MATLAB code for figureGUI.fig
%      figureGUI, by itself, creates a new figureGUI or raises the existing
%      singleton*.
%
%      H = figureGUI returns the handle to a new figureGUI or the handle to
%      the existing singleton*.
%
%      figureGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in figureGUI.M with the given input arguments.
%
%      figureGUI('Property','Value',...) creates a new figureGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the figureGUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See figureGUI Options on GUIDE's Tools menu.  Choose "figureGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figureGUI

% Last Modified by GUIDE v2.5 29-Jun-2019 16:36:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before figureGUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figureGUI (see VARARGIN)

% Choose default command line output for figureGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes figureGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in setImageLocation.
function setImageLocation_Callback(hObject, eventdata, handles)
% hObject    handle to setImageLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function enterLocation_Callback(hObject, eventdata, handles)
% hObject    handle to enterLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enterLocation as text
%        str2double(get(hObject,'String')) returns contents of enterLocation as a double
location = get(handles.enterLocation,'String');
setappdata(0,'loc',location);

% ------------------------------------------------------------------------------
% To save image location in a txt file, change special charecter '\' to '\\' 
% in the image location. As it can't save the link because of '\' charecter.
%-------------------------------------------------------------------------------
fid = fopen('imageLoc.txt','wt');
newImageLocation = strrep(location,'\','\\'); %formate newStr = strrep(str,old,new) 
fprintf(fid, newImageLocation);
fclose(fid);

% --- Executes during object creation, after setting all properties.
function enterLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enterLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showImage.
function showImage_Callback(hObject, eventdata, handles)
% hObject    handle to showImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageLocation = getappdata(0,'loc');
i = imread(imageLocation);
axes(handles.axes1);
imshow(i);



% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%------------------------------------------------

axes(handles.axes1);
imshow('blankBackground.jpg');

fid = fopen('imageLoc.txt','wt');
fprintf(fid,'%s','');
set(handles.enterLocation,'String','');
fclose(fid);

fid = fopen('verdict.txt','wt');
fprintf(fid,'%s','No result');
set(handles.resultText,'String','No result');
fclose(fid);


% --- Executes on button press in resultButton.
function resultButton_Callback(hObject, eventdata, handles)
% hObject    handle to resultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

finalProject

fid = fopen('verdict.txt','r');
Data = fgetl(fid);
set(handles.resultText,'String',Data);
fprintf(fid,'%s','No result');
fclose(fid);




function resultText_Callback(hObject, eventdata, handles)
% hObject    handle to resultText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resultText as text
%        str2double(get(hObject,'String')) returns contents of resultText as a double


% --- Executes during object creation, after setting all properties.
function resultText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popUpMenu.
function popUpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popUpMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popUpMenu

contents = cellstr(get(hObject, 'String'));
item = contents{get(hObject,'Value')};

fid = fopen('noteType','wt');
fprintf(fid, item);
fclose(fid);

    

% --- Executes during object creation, after setting all properties.
function popUpMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% clear the variables
clearStr = 'clear all';
evalin('base',clearStr);

% Delete the figure
delete(handles.figureGUI);

clear all;
close all;
