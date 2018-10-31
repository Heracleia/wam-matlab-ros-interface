%% World Frame Script

%Homogeneous Matrix
T=[1 0 0 1;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];

%Translation
c = T(1:3,4);

%Axis limits
d = 1.2;
limits = [c(1)-d c(1)+d c(2)-d c(2)+d c(3)-d c(3)+d];
axis(limits);
hold on
grid on

xlabel( 'X')
ylabel( 'Y')
zlabel( 'Z')

%World frame
hax = gca;

%% Attach the frame to the world frame
hg = hgtransform('Parent', hax);

%% Create the frame
MakeFrame(hg);

%% Set them to coresponding Transformation Matrix
set(hg,'Matrix', T);