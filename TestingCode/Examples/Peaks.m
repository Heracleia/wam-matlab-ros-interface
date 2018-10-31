figure
bar3(peaks(15))
ax = gca;
ax.Projection='perspective';
ax.CameraViewAngle = 50;
ax.CameraPosition=[16 14 2];
ax.CameraTarget = [7 7 0];
light('Position',[6 -5 8])