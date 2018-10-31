%% Arrow Parent Transform

clear
clc

% Axis of the world
ax = axes('XLim',[-3 3],'YLim',[-3 3],'ZLim',[-3 3]);
view(3)
grid on

% Arrow function
drawline = @(x,y,z) line(x,y,z);

% Arrow Objects
zero=[0 0];
one=[0 1];

h(1) = drawline(one,zero,zero);
h(2) = drawline(zero,one,zero); 
h(3) = drawline(zero,zero,one);

t = hgtransform('Parent',ax);
set(h,'Parent',t);

Rz = eye(4);
Sxy = Rz;

for r = 0:.01:2*pi
    % Z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    set(t,'Matrix',Rz*Sxy)
    drawnow
end
