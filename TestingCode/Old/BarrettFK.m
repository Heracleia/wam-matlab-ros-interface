function BarrettFK(j1,j2,j3,j4)
%% Barrett Arm

%% Create the Homogeneous matrixes of the Barrett Arm
[T_01]=DH_matrix(0,-pi/2,0,j1);
[T_12]=DH_matrix(0,pi/2,0,j2);
[T_23]=DH_matrix(0.045,-pi/2,0.55,j3);
[T_34]=DH_matrix(-0.045,pi/2,0,j4);
[T_45]=DH_matrix(0,0,0.35,0);

%% Solve the forward Kinematics and obtain the joints positions

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

%Plot the robot according to Forward Kinematics
figure (1)
plot3(xx,yy,zz,'ko-','Linewidth',2)
zlabel('z (cm)');
ylabel('y (cm)');
xlabel('x (cm)');
axis ([-1 1 -1 1 -1 1])
grid on


