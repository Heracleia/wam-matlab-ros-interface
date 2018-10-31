%% Testing the Jacobian Equation of the Barrett Arm
%% by Michail Theofanidis

%input joint positions

q=[0 0 0 0]
t=[0 0 0 0]

%Some mathematical abriviations
s1=sin(q(1));
s2=sin(q(2));
s3=sin(q(3));
s4=sin(q(4));

c1=cos(q(1));
c2=cos(q(2));
c3=cos(q(3));
c4=cos(q(4));

l1=0.55;
l2=0.35;
z3=0.045;
z4=-0.045;

%Details for the forward kinematic of the robot
r11=c1*c2*c3*c4-s1*s3*c4-c1*s2*s4;
r21=s1*c2*c3*c4+c1*s3*c4-s1*s2*s4;
r31=-s2*c3*c4-c2*s4;

r12=-c1*c2*s3-s1*c3;
r22=-s1*c2*s3+c1*c3;
r32=s2*s3;

r13=c1*c2*c3*s4-s1*s3*s4+c1*s2*c4;
r23=s1*c2*c3*s4+c1*s3*s4+s1*s2*c4;
r33=-s2*c3*s4+c2*c4;

x_e=l2*(r13)+z4*(c1*c2*c3*c4-s1*s3*c4-c1*s2*s4)+z3*(c1*c2*c3-s1*s3)+l1*(c1*s2);

y_e=l2*(r23)+z4*(s1*c2*c3*c4+c1*s3*c4-s1*s2*s4)+z3*(s1*c2*c3+c1*s3)+l1*(s1*s2);
z_e=l2*(r33)+z4*(-s2*c3*c4-c2*s4)+z3*(-s2*c3)+l1*(c2);

T_ce=[r11 r12 r13 x_e;
    r21 r22 r23 y_e;
    r31 r32 r33 z_e;
    0 0 0 1]

% Parameters of the jacobian
j11=(-s1*c2*c3*s4*l2-c1*s3*s4*l2-s1*s2*c3*l2-s1*c2*c3*c4*z4-c1*s3*c4*z4+s1*s2*s4*z4-s1*c2*c3*z3-c1*s3*z3-s1*c2*l1);
j12=(-c1*s2*c3*s4*l2-c1*c2*c4*l2-c1*s2*c3*c4*z4-c1*c2*s4*z4-c1*s2*c3*z3-c1*s2*l1);
j13=(-c1*c2*s3*s4*l2-s1*c3*s4*l2-c1*c3*c4*z4-c1*c2*s3*z3-s1*c3*z3);
j14=(c1*c2*c3*c4*l2-s1*s3*c4*l2-c1*s2*s4*l2-c1*c2*c3*s4*z4+s1*s3*c4*z4-c1*s2*c4*z4);

j21=(c1*s2*l1+c1*c2*c3*z3-s1*s3*z3-c1*s2*s4*z4-s1*s3*c4*z4+c1*c2*c3*c4*z4+c1*c2*c3*s4*l2-s1*s3*s4*l2+c1*s2*c3*l2);
j22=(s1*c2*l1-s1*s2*c3*z3-s1*c3*s4*z4-s1*s2*c3*c4*z4-s1*s2*c3*s4*l2+s1*c2*c3*l2);
j23=(-s1*c2*s3*z3+c1*c3*z3+c1*c3*c4*z4-s1*c2*s3*c4*z4-s1*c2*s3*s4*l2+c1*s3*s4*l2-s1*s3*s3*l2);
j24=(-c1*s3*s4*z4-s1*c2*c3*s4*z4+s1*c2*c3*c4*l2+c1*s3*c4);

j31=0;
j32=(-s2*l1-c2*c3*z3-s2*c4*l2-c2*c3*s4*l2-c2*c3*c4*z4+s2*s4*z4);
j33=(s2*s3*z3+s2*s3*s4*l2+s2*s3*c4*z4);
j34=(-c2*s4*l2-s2*c3*c4*l2+s2*c3*s4*z4-c2*c4*z4);

Jcb=[j11 j12 j13 j14;
     j21 j22 j23 j24;
     j31 j32 j33 j34;]
      
F_c=Jcb*t'

% plot the Robot
RobotFK(q)

      
