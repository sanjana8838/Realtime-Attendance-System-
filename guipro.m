
function varargout = guipro(varargin)
% GUIPRO MATLAB code for guipro.fig
%      GUIPRO, by itself, creates a new GUIPRO or raises the existing
%      singleton*.
%
%      H = GUIPRO returns the handle to a new GUIPRO or the handle to
%      the existing singleton*.
%
%      GUIPRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIPRO.M with the given input arguments.
%
%      GUIPRO('Property','Value',...) creates a new GUIPRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guipro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guipro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guipro

% Last Modified by GUIDE v2.5 22-Aug-2020 11:12:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guipro_OpeningFcn, ...
                   'gui_OutputFcn',  @guipro_OutputFcn, ...
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


% --- Executes just before guipro is made visible.
function guipro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guipro (see VARARGIN)

% Choose default command line output for guipro
handles.output = hObject;
axes(handles.axes1);
imshow('blank.jpg');
axis off;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guipro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guipro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while true
    try
        
handles.vid = videoinput('winvideo' , 1, 'YUY2_320x240');

triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 5;
start(handles.vid);
while(1)
facedetector = vision.CascadeObjectDetector;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(facedetector, handles.im);
%hello = insertObjectAnnotation(handles.im,'rectangle',bbox, 'Face');
hi = insertShape(handles.im,'rectangle',bbox);
imshow(hi);
end 
    catch
        break;
    end
end
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while true
     try
        objects = imaqfind;
        delete(objects);
        handles.vid = videoinput('winvideo' , 1, 'YUY2_320x240');
        set(handles.vid, 'FramesPerTrigger',1);
        
        handles.vid.Timeout = 5;
        start(handles.vid);
        handles.vid.ReturnedColorspace = 'rgb';
        im= getsnapshot(handles.vid);
        imshow(im);
        imwrite(im,'C:\trial.jpg');
        break;
     catch
        break;
       
     end
    objects = imaqfind;
    delete(objects);
end
guidata(hObject, handles);   


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
objects = imaqfind;
delete(objects);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recognition()
