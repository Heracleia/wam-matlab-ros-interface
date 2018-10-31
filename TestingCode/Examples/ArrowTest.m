%% Playing with arrows

clc
clear 

%% Create a Transformation
drawline = @(x,y,z) line(x,y,z);

x=[0 1];
y=[0 0];
z=[0 0];

drawline(x,y,z);

x=[0 0];
y=[0 1];
z=[0 0];

drawline(x,y,z);

x=[0 0];
y=[0 0];
z=[0 1];

drawline(x,y,z);