%% Function that returns the properties of a frame

function MakeFrame(handle)

%% create unit vectors
plot3([0 1],[0 0],[0 0],'b','Parent',handle);
plot3([0 0],[0 1],[0 0],'b','Parent',handle);
plot3([0 0],[0 0],[0 1],'b','Parent',handle);

%% label the unit vector
text(1, 0, 0, 'X','Color','b','Parent',handle);           
text(0, 1, 0, 'Y','Color','b','Parent',handle);
text(0, 0, 1, 'Z','Color','b','Parent',handle);

end

