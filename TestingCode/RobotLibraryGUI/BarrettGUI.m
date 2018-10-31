%% Initialize the GUI
function varargout = BarrettGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BarrettGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BarrettGUI_OutputFcn, ...
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

%% Here is the Opening Function
function BarrettGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

h=figure(handles.figure1);
rotate3d(h);
set(h,'toolbar','figure');
set(h,'menubar','figure');

% get the joint position from the slider
j1 = get(handles.Joint1,'Value');
j2 = get(handles.Joint2,'Value');
j3 = get(handles.Joint3,'Value');
j4 = get(handles.Joint4,'Value');

q=[degtorad(j1) degtorad(j2) degtorad(j3) degtorad(j4)];

RobotFK(q);

%Updates
Y_text_Callback(handles)
X_text_Callback(handles)
Z_text_Callback(handles)


% Update handles structure
guidata(hObject, handles);
function varargout = BarrettGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%% Here are the Silder Callbacks
function Joint1_Callback(hObject, eventdata, handles)

sliderValue = get(handles.Joint1,'Value');

set(handles.Joint1_Text,'String', num2str(sliderValue));

guidata(hObject, handles);

% Function Update 
update(handles)
Y_text_Callback(handles)
X_text_Callback(handles)
Z_text_Callback(handles)
function Joint1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Joint2_Callback(hObject, eventdata, handles)

sliderValue = get(handles.Joint2,'Value');

set(handles.Joint2_Text,'String', num2str(sliderValue));

guidata(hObject, handles);

update(handles)
Y_text_Callback(handles)
X_text_Callback(handles)
Z_text_Callback(handles)
function Joint2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Joint3_Callback(hObject, eventdata, handles)

sliderValue = get(handles.Joint3,'Value');

set(handles.Joint3_Text,'String', num2str(sliderValue));

guidata(hObject, handles);

update(handles)
Y_text_Callback(handles)
X_text_Callback(handles)
Z_text_Callback(handles)
function Joint3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Joint4_Callback(hObject, eventdata, handles)

sliderValue = get(handles.Joint4,'Value');

set(handles.Joint4_Text,'String', num2str(sliderValue));

guidata(hObject, handles);

update(handles)
Y_text_Callback(handles)
X_text_Callback(handles)
Z_text_Callback(handles)
function Joint4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% Here are the Text Callbacks
function Joint1_Text_Callback(hObject, eventdata, handles)

    sliderValue = get(handles.Joint1_Text,'String')

    sliderValue = str2num(sliderValue);

    if (isempty(sliderValue) || sliderValue < -180 || sliderValue > 180)
        set(handles.Joint1,'Value',0);
        set(handles.Joint1_Text,'String','0');
    else
        set(handles.Joint1,'Value',sliderValue);
    end
    
    % Function Update 
    update(handles)
    Y_text_Callback(handles)
    X_text_Callback(handles)
    Z_text_Callback(handles)    
function Joint1_Text_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint2_Text_Callback(hObject, eventdata, handles)

    sliderValue = get(handles.Joint2_Text,'String');

    sliderValue = str2num(sliderValue);

    if (isempty(sliderValue) || sliderValue < -180 || sliderValue > 180)
        set(handles.Joint2,'Value',0);
        set(handles.Joint2_Text,'String','0');
    else
        set(handles.Joint2,'Value',sliderValue);
    end
    % Function Update 
    update(handles)
    Y_text_Callback(handles)
    X_text_Callback(handles)
    Z_text_Callback(handles)
function Joint2_Text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint3_Text_Callback(hObject, eventdata, handles)

    sliderValue = get(handles.Joint3_Text,'String');

    sliderValue = str2num(sliderValue);

    if (isempty(sliderValue) || sliderValue < -180 || sliderValue > 180)
        set(handles.Joint3,'Value',0);
        set(handles.Joint3_Text,'String','0');
    else
        set(handles.Joint3,'Value',sliderValue);
    end
    % Function Update 
    update(handles)
    Y_text_Callback(handles)
    X_text_Callback(handles)
    Z_text_Callback(handles)
function Joint3_Text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint4_Text_Callback(hObject, eventdata, handles)

    sliderValue = get(handles.Joint4_Text,'String');

    sliderValue = str2num(sliderValue);

    if (isempty(sliderValue) || sliderValue < -180 || sliderValue > 180)
        set(handles.Joint4,'Value',0);
        set(handles.Joint4_Text,'String','0');
    else
        set(handles.Joint4,'Value',sliderValue);
    end
    % Function Update 
    update(handles)
    Y_text_Callback(handles)
    X_text_Callback(handles)
    Z_text_Callback(handles)
function Joint4_Text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Update Plot
function update(handles)
    
    % get the joint position from the slider
    j1 = get(handles.Joint1,'Value');
    j2 = get(handles.Joint2,'Value');
    j3 = get(handles.Joint3,'Value');
    j4 = get(handles.Joint4,'Value');
    
    q=[degtorad(j1) degtorad(j2) degtorad(j3) degtorad(j4)];
    
    RobotFK(q);

    
%% Push Button

function MoveRobotButton_Callback(hObject, eventdata, handles)

    % get the joint position from the slider
    j1 = get(handles.Joint1,'Value');
    j2 = get(handles.Joint2,'Value');
    j3 = get(handles.Joint3,'Value');
    j4 = get(handles.Joint4,'Value');
    
    q=[degtorad(j1) degtorad(j2) degtorad(j3) degtorad(j4)];
    
    JointMove(q);

%% Position Callbacks
function Y_text_Callback(handles)

    j1 = get(handles.Joint1,'Value');
    j2 = get(handles.Joint2,'Value');
    j3 = get(handles.Joint3,'Value');
    j4 = get(handles.Joint4,'Value');
    
    q=[j1 j2 j3 j4];
    
    T=getRobotFK(q);
    
    [dummy, y, dummy] = MyTransl(T);
    
    set(handles.Y_text,'String', num2str(y));
function Y_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function X_text_Callback(handles)

    j1 = get(handles.Joint1,'Value');
    j2 = get(handles.Joint2,'Value');
    j3 = get(handles.Joint3,'Value');
    j4 = get(handles.Joint4,'Value');
    
    q=[j1 j2 j3 j4];
    
    T=getRobotFK(q);
    
    [x, dummy, dummy] = MyTransl(T);
      
    set(handles.X_text,'String', num2str(x));
function X_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_text_Callback(handles)

    j1 = get(handles.Joint1,'Value');
    j2 = get(handles.Joint2,'Value');
    j3 = get(handles.Joint3,'Value');
    j4 = get(handles.Joint4,'Value');
    
    q=[j1 j2 j3 j4];
    
    T=getRobotFK(q);
    
    [dummy, dummy, z] = MyTransl(T);
    
    set(handles.Z_text,'String', num2str(z));
function Z_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Inverse Kinematics positions
function Y_inv_Callback(hObject, eventdata, handles)

    textValue = get(handles.Y_inv,'String');

    textValue = str2num(textValue);

    if (isempty(textValue) || textValue < -0.9 || textValue > 0.9)
        set(handles.Y_inv,'String','0');
    else
        set(handles.Y_inv,'Value',textValue);
    end
function Y_inv_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function X_inv_Callback(hObject, eventdata, handles)

    textValue = get(handles.X_inv,'String');

    textValue = str2num(textValue);

    if (isempty(textValue) || textValue < -0.9 || textValue > 0.9)
        set(handles.X_inv,'String','0');
    else
        set(handles.X_inv,'Value',textValue);
    end
function X_inv_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_inv_Callback(hObject, eventdata, handles)

    textValue = get(handles.Z_inv,'String');

    textValue = str2num(textValue);

    if (isempty(textValue) || textValue < -0.9 || textValue > 0.9)
        set(handles.Z_inv,'String','0');
    else
        set(handles.Z_inv,'Value',textValue);
    end
function Z_inv_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Button for the Solution of the Inverse Kinematics
function SolveButton_Callback(hObject, eventdata, handles)

    % Clear the box
    set(handles.Solutions,'String',[]);

    % Get the cartesian positions from the text callbacks
    xe = get(handles.X_inv,'Value')
    ye = get(handles.Y_inv,'Value')
    ze = get(handles.Z_inv,'Value')
    
    [q] = getRobotIK(xe,ye,ze)
    
    limit=size(q);
    
    for i=1:1:limit(1)
        
        str_part=[num2str(q(i,1)) '  ' num2str(q(i,2)) '  ' num2str(q(i,3)) '  ' num2str(q(i,4))]
        old_str=get(handles.Solutions,'String')
        new_str=strvcat(old_str,str_part)
        set(handles.Solutions, 'String', new_str)
        
    end

%% Solutions List
function Solutions_Callback(hObject, eventdata, handles)

function Solutions_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Select this particular configuration for the robot
function SelectConfig_Callback(hObject, eventdata, handles)

    id=get(handles.Solutions,'Value');
    
    % get the cartesian positions from the text callbacks
    xe = get(handles.X_inv,'Value');
    ye = get(handles.Y_inv,'Value');
    ze = get(handles.Z_inv,'Value');
    
    [q] = getRobotIK(xe,ye,ze);
    
    % get the desirable solution
    configuration=q(id,:);
    
    % change the virtual robot according to the selected solution
    set(handles.Joint1,'Value',q(id,1));
    set(handles.Joint2,'Value',q(id,2));
    set(handles.Joint3,'Value',q(id,3));
    set(handles.Joint4,'Value',q(id,4));
    
    set(handles.Joint1_Text,'String', num2str(q(id,1)));
    set(handles.Joint2_Text,'String', num2str(q(id,2)));
    set(handles.Joint3_Text,'String', num2str(q(id,3)));
    set(handles.Joint4_Text,'String', num2str(q(id,4)));
    
    update(handles)

%% Reset Button    
function ResetButton_Callback(hObject, eventdata, handles)

    set(handles.Solutions, 'String',[]);
    
    set(handles.Joint1,'Value',0);
    set(handles.Joint2,'Value',0);
    set(handles.Joint3,'Value',0);
    set(handles.Joint4,'Value',0);
    
    set(handles.Joint1_Text,'String', num2str(0));
    set(handles.Joint2_Text,'String', num2str(0));
    set(handles.Joint3_Text,'String', num2str(0));
    set(handles.Joint4_Text,'String', num2str(0));
    
    update(handles)
    set(handles.X_text,'String', num2str(0));
    set(handles.Y_text,'String', num2str(0));
    set(handles.Z_text,'String', num2str(0.9));
    
    set(handles.X_inv,'String', num2str(0));
    set(handles.Y_inv,'String', num2str(0));
    set(handles.Z_inv,'String', num2str(0));
    

function StoreButton_Callback(hObject, eventdata, handles)


function PlaybackButton_Callback(hObject, eventdata, handles)


function goHomeButton_Callback(hObject, eventdata, handles)

    goHome

