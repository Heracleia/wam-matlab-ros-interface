%% Plot the Barrett Arm Robot
%% by Michail Theofanidis

clear
clc

%% Define the Barrett Arm frames

%% Define the joints
j1=degtorad(0);
j2=degtorad(0);
j3=degtorad(0);
j4=degtorad(0);

%% Create the Homogeneous matrixes of the Barrett Arm
[T_01]=DH_matrix(0,-pi/2,0,j1);
[T_12]=DH_matrix(0,pi/2,0,j2);
[T_23]=DH_matrix(0.045,-pi/2,0.55,j3);
[T_34]=DH_matrix(-0.045,pi/2,0,j4);
[T_45]=DH_matrix(0,0,0.35,0);

%% Frames Options

length=[0.3 0.3 0.3 0.3 0.3];
colors=['k' 'b' 'r' 'c' 'm'];
font=5;


%% Define the world frame

%Axis limits
d = 1.3;
limits = [-d d -d d -d d];
axis(limits);
hold on
grid on

xlabel('X')
ylabel('Y')
zlabel('Z')



%World frame
world = gca;



%% Attach the first frame to the world frame
h1 = hgtransform('Parent', world);

% create unit vectors
plot3([0 1]*length(1),[0 0],[0 0],colors(1),'Parent', h1);
plot3([0 0],[0 1]*length(1),[0 0],colors(1),'Parent', h1);
plot3([0 0],[0 0],[0 1]*length(1),colors(1),'Parent', h1);

% label the unit vector
text(1*length(1), 0, 0,'X1','Color',colors(1),'FontSize',font,'Parent', h1);           
text(0, 1*length(1), 0,'Y1','Color',colors(1),'FontSize',font,'Parent', h1);
text(0, 0, 1*length(1),'Z1','Color',colors(1),'FontSize',font,'Parent', h1);

% Set them to coresponding Transformation Matrix
set(h1,'Matrix', T_01);



%% Attach the second frame to the world frame
h2 = hgtransform('Parent', h1);

% create unit vectors
plot3([0 1]*length(2),[0 0],[0 0],colors(2),'Parent', h2);
plot3([0 0],[0 1]*length(2),[0 0],colors(2),'Parent', h2);
plot3([0 0],[0 0],[0 1]*length(2),colors(2),'Parent', h2);

% label the unit vector
text(1*length(2), 0, 0,'X2','Color',colors(2),'FontSize',font,'Parent', h2);           
text(0, 1*length(2), 0,'Y2','Color',colors(2),'FontSize',font,'Parent', h2);
text(0, 0, 1*length(2),'Z2','Color',colors(2),'FontSize',font,'Parent', h2);

% Set them to coresponding Transformation Matrix
set(h2,'Matrix', T_12);



%% Attach the third frame to the world frame
h3 = hgtransform('Parent', h2);

% create unit vectors
plot3([0 1]*length(3),[0 0],[0 0],colors(3),'Parent', h3);
plot3([0 0],[0 1]*length(3),[0 0],colors(3),'Parent', h3);
plot3([0 0],[0 0],[0 1]*length(3),colors(3),'Parent', h3);

% label the unit vector
text(1*length(3), 0, 0,'X3','Color',colors(3),'FontSize',font,'Parent', h3);           
text(0, 1*length(3), 0,'Y3','Color',colors(3),'FontSize',font,'Parent', h3);
text(0, 0, 1*length(3),'Z3','Color',colors(3),'FontSize',font,'Parent', h3);

% Set them to coresponding Transformation Matrix
set(h3,'Matrix', T_23);



%% Attach the forth frame to the world frame
h4 = hgtransform('Parent', h3);

% create unit vectors
plot3([0 1]*length(4),[0 0],[0 0],colors(4),'Parent', h4);
plot3([0 0],[0 1]*length(4),[0 0],colors(4),'Parent', h4);
plot3([0 0],[0 0],[0 1]*length(4),colors(4),'Parent', h4);

% label the unit vector
text(1*length(4), 0, 0,'X4','Color',colors(4),'FontSize',font,'Parent', h4);           
text(0, 1*length(4), 0,'Y4','Color',colors(4),'FontSize',font,'Parent', h4);
text(0, 0, 1*length(4),'Z4','Color',colors(4),'FontSize',font,'Parent', h4);

% Set them to coresponding Transformation Matrix
set(h4,'Matrix', T_34);



%% Attach the fifth frame to the world frame
h5 = hgtransform('Parent', h4);

% create unit vectors
plot3([0 1]*length(5),[0 0],[0 0],colors(5),'Parent', h5);
plot3([0 0],[0 1]*length(5),[0 0],colors(5),'Parent', h5);
plot3([0 0],[0 0],[0 1]*length(5),colors(5),'Parent', h5);

% label the unit vector
text(1*length(5), 0, 0,'X5','Color',colors(5),'FontSize',font,'Parent', h5);           
text(0, 1*length(5), 0,'Y5','Color',colors(5),'FontSize',font,'Parent', h5);
text(0, 0, 1*length(5),'Z5','Color',colors(5),'FontSize',font,'Parent', h5);

% Set them to coresponding Transformation Matrix
set(h5,'Matrix', T_45);


%% Attach the links to the world frame

%position of word frame
x_0=0;
y_0=0;
z_0=0;

%position of joint1
x_1=T_01(1,4);
y_1=T_01(2,4);
z_1=T_01(3,4);

%position of joint2
T_02=T_01*T_12;

x_2=T_02(1,4);
y_2=T_02(2,4);
z_2=T_02(3,4);

%position of joint3
T_03=T_02*T_23;

x_3=T_03(1,4);
y_3=T_03(2,4);
z_3=T_03(3,4);

%position of joint4
T_04=T_03*T_34;

x_4=T_04(1,4);
y_4=T_04(2,4);
z_4=T_04(3,4);

%position of joint5
T_05=T_04*T_45;

x_5=T_05(1,4);
y_5=T_05(2,4);
z_5=T_05(3,4);

%%Matrix Containing the position of each Joint
xx=[x_0;x_1;x_2;x_3;x_4;x_5];
yy=[y_0;y_1;y_2;y_3;y_4;y_5];
zz=[z_0;z_1;z_2;z_3;z_4;z_5];

plot3(xx,yy,zz,'ko-','Linewidth',1.5,'Parent',world)


