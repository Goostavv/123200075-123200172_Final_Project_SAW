function varargout = CPU_Recomendation_with_SAW(varargin)
% CPU_RECOMENDATION_WITH_SAW MATLAB code for CPU_Recomendation_with_SAW.fig
%      CPU_RECOMENDATION_WITH_SAW, by itself, creates a new CPU_RECOMENDATION_WITH_SAW or raises the existing
%      singleton*.
%
%      H = CPU_RECOMENDATION_WITH_SAW returns the handle to a new CPU_RECOMENDATION_WITH_SAW or the handle to
%      the existing singleton*.
%
%      CPU_RECOMENDATION_WITH_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CPU_RECOMENDATION_WITH_SAW.M with the given input arguments.
%
%      CPU_RECOMENDATION_WITH_SAW('Property','Value',...) creates a new CPU_RECOMENDATION_WITH_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CPU_Recomendation_with_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CPU_Recomendation_with_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CPU_Recomendation_with_SAW

% Last Modified by GUIDE v2.5 25-May-2022 12:12:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CPU_Recomendation_with_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @CPU_Recomendation_with_SAW_OutputFcn, ...
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


% --- Executes just before CPU_Recomendation_with_SAW is made visible.
function CPU_Recomendation_with_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CPU_Recomendation_with_SAW (see VARARGIN)

% Choose default command line output for CPU_Recomendation_with_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CPU_Recomendation_with_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CPU_Recomendation_with_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in btnShowResult.
function btnShowResult_Callback(hObject, eventdata, handles)
% hObject    handle to btnShowResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
W1 = str2double(get(handles.pricew, 'string'));
W2 = str2double(get(handles.cpuw, 'string'));
W3 = str2double(get(handles.tmw, 'string'));
W4 = str2double(get(handles.tdpw, 'string'));
W5 = str2double(get(handles.ppw, 'string'));
total = W1 + W2 + W3 + W4 + W5;

if total == 100
filename = 'Data_CPU_Benchmark.xlsx';
sheet = 1;
range = 'C2:G202';
mydata = xlsread(filename,sheet,range);%pembacaan isi excel
range = 'A2:A202';
data = xlsread(filename,sheet,range);%pembacaan isi excel
range = 'B2:B202';
[~,text] = xlsread(filename,sheet,range);%pembacaan isi excel
range = 'A2:G202';
[~,~,ReadData] = xlsread(filename,sheet,range);%pembacaan isi excel

    W1 = W1/100;
    W2 = W2/100;
    W3 = W3/100;
    W4 = W4/100;
    W5 = W5/100;
    
 switch get(get(handles.uibgprice,'SelectedObject'),'Tag')
        case 'rbprice1'
            C1 = 1;
        case 'rbprice2'
            C1 = 0;
    end

    switch get(get(handles.uibgcpu,'SelectedObject'),'Tag')
        case 'rbcpu1'
            C2 = 1;
        case 'rbcpu2'
            C2 = 0;
    end

    switch get(get(handles.uibgtm,'SelectedObject'),'Tag')
        case 'rbtm1'
            C3 = 1;
        case 'rbtm2'
            C3 = 0;
    end

    switch get(get(handles.uibgtdp,'SelectedObject'),'Tag')
        case 'rbtdp1'
            C4 = 1;
        case 'rbtdp2'
            C4 = 0;
    end
    
    switch get(get(handles.uibgpp,'SelectedObject'),'Tag')
        case 'rbpp1'
            C5 = 1;
        case 'rbpp2'
            C5 = 0;
    end
    
 [m, n]=size (mydata);
 c = [C1,C2,C3,C4,C5]; 
 w=[W1,W2,W3,W4,W5];
 
 A=zeros (m,n);
 for j=1:n
     if c(j)==1 
         A(:,j)=mydata(:,j)./max(mydata(:,j));
     else
         A(:,j)=min(mydata(:,j))./mydata(:,j);
     end
 end
 for i=1:m
     V(i)= sum(w.*A(i,:));
 end
 for i=1:m
     if max(V)==V(i)
         data1 = data(i);
         data2 = text(i);
         data3 = V(i);
     end 
 end
 char = int2str(data1);%merubah int to string
 result= transpose(V);%membuat menjadi baris
 xlswrite('PriorityValue.xlsx', result);%isi excel
 ReadData2 = xlsread('PriorityValue.xlsx');%pembacaan isi excel
 %isi rekomendasi
 set(handles.Num,'string',char); 
 set(handles.CPUName,'string',data2);
 set(handles.PriorityValue,'string',data3);
 set(handles.uitable1,'Data',ReadData);
 set(handles.uitable2,'Data',ReadData2);
 else
    set(handles.Emsg, 'string', 'Total of Weight Value is not exactly 100, Please input Weight Value Properly');
end



function pricew_Callback(hObject, eventdata, handles)
% hObject    handle to pricew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pricew as text
%        str2double(get(hObject,'String')) returns contents of pricew as a double


% --- Executes during object creation, after setting all properties.
function pricew_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pricew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cpuw_Callback(hObject, eventdata, handles)
% hObject    handle to cpuw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cpuw as text
%        str2double(get(hObject,'String')) returns contents of cpuw as a double


% --- Executes during object creation, after setting all properties.
function cpuw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cpuw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tmw_Callback(hObject, eventdata, handles)
% hObject    handle to tmw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tmw as text
%        str2double(get(hObject,'String')) returns contents of tmw as a double


% --- Executes during object creation, after setting all properties.
function tmw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tdpw_Callback(hObject, eventdata, handles)
% hObject    handle to tdpw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tdpw as text
%        str2double(get(hObject,'String')) returns contents of tdpw as a double


% --- Executes during object creation, after setting all properties.
function tdpw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tdpw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ppw_Callback(hObject, eventdata, handles)
% hObject    handle to ppw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ppw as text
%        str2double(get(hObject,'String')) returns contents of ppw as a double


% --- Executes during object creation, after setting all properties.
function ppw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
