
pts = [4  4 -1 -1  2  2  1  1  0  0  3  3;
       1  3  3 -1 -1  1  1  0  0  2  2  1;
       1  1  1  1  1  1  1  1  1  1  1  1];
   
axis equal
xlim([-4 4])
ylim([-4 4])
h1 = patch('FaceColor',[0.3010 0.7450 0.9330]);
h1.XData = pts(1,:) ./ pts(3,:);
h1.YData = pts(2,:) ./ pts(3,:);

mrot = [cos(pi/5), -sin(pi/5), 0;
        sin(pi/5),  cos(pi/5), 0;
                0,          0, 1];
            
p2 = mrot*pts;

x = p2(1,:) ./ p2(3,:);
y = p2(2,:) ./ p2(3,:);
h2 = patch('FaceColor',[0.9290 0.6940 0.1250]);
h2.XData = x;
h2.YData = y;