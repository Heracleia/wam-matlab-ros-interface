%% Testing the Inverse Kinematic Equations of the Barrett Arm
%% by Michail Theofanidis

%function [rtrn]=RobotIK_Test(q)

    q=[0 0 0 0];

    %% Input joint angles
    q=degtorad(q);

    %% Get Size of the joint values
    len=size(q);

    %% Some mathematical abriviations

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
    d3=l1;
    dw=l2;
    
    z3=0.045;
    z4=-0.045;
    a3=z3;
    a4=z4;
    
    %% End effector Orientations
    r11=c1*c2*c3*c4-s1*s3*c4-c1*s2*s4;
    r21=s1*c2*c3*c4+c1*s3*c4-s1*s2*s4;
    r31=-s2*c3*c4-c2*s4;

    r12=-c1*c2*s3-s1*c3;
    r22=-s1*c2*s3+c1*c3;
    r32=s2*s3;

    r13=c1*c2*c3*s4-s1*s3*s4+c1*s2*c4;
    r23=s1*c2*c3*s4+c1*s3*s4+s1*s2*c4;
    r33=-s2*c3*s4+c2*c4;

    %% End Effector Positions
    x_e=l2*(r13)+z4*r11+z3*(c1*c2*c3-s1*s3)+l1*(c1*s2);
    y_e=l2*(r23)+z4*r21+z3*(s1*c2*c3+c1*s3)+l1*(s1*s2);
    z_e=l2*(r33)+z4*r31+z3*(-r32)+l1*(c2);
    
    %% Finding Theta 4    
    
    N=(x_e^2+y_e^2+z_e^2-z3^2-z4^2-l1^2-l2^2)/2;
    R=z3*l2-z4*l1;
    T=l1*l2+z3*z4;
    
    a=(N+T)/2;
    
    b=-R;
    
    c=(N-T)/2;
    
    theta4(1)=2*atan((-b+sqrt(b^2-4*a*c))/(2*a));
    theta4(2)=2*atan((-b-sqrt(b^2-4*a*c))/(2*a));
    
    %% Finding Theta 2
    
%     %% Solution 1 (Requires End Effector Orientation)
%     
%     c_2=(z_e-l2*r33-z4*r31+z3*r32)/l1;
%     
%     c_2=Check(c_2);
%           
%     s_2=sqrt(1-c_2^2);
%     
%     theta2(1)=atan2(s_2,c_2);
%     theta2(2)=-atan2(s_2,c_2);
        
    %% Solution 2 (Requires theta 3)
    
    c_2=(z_e + (c3*s4*dw + c3*a4*c4 + a3*c3)*s2)/(c4*dw+a4*s4 + d3);
    c_2=Check(c_2);
    
    s_2=sqrt(1-c_2^2);
    
    theta2(1)=atan2(s_2,c_2);
    theta2(2)=-atan2(s_2,c_2);
    
    B= s3*s4*dw + s3*a4*c4 + a3*s3;
    M = c4*dw-a4*s4+d3;
    P = c3*s4*dw + c3*a4*c4 + a3*c3;
    
    theta2(3)=atan(((sqrt(x_e^2 + y_e^2-B^2)*M - z_e*P))/(sqrt(x_e^2 + y_e^2-B^2)*P + z_e*M));
    theta2(4)=atan(((-sqrt(x_e^2 + y_e^2-B^2)*M - z_e*P))/(-sqrt(x_e^2 + y_e^2-B^2)*P + z_e*M));
    
    %% Finding theta 1
    
    %% Solution 2 (Requires theta 3)
    
    A=c2*c3*s4*dw + s2*c4*dw + c2*c3*a4*c4+s2*a4*s4 + c2*a3*c3 + s2*d3;
    
    theta1(1)=atan((A*y_e-B*x_e)/(A*x_e+B*y_e));
    
    
    
    
%     %% Display the positions and lengths
%     
%     disp(['The position of the end effector is: ', num2str(x_e),' ', num2str(y_e),' ', num2str(z_e)])
%     disp(['The position of frame 4 is: ', num2str(x_4),' ', num2str(y_4),' ', num2str(z_4)])
%     disp(['The position of frame 3 is: ', num2str(x_3),' ', num2str(y_3),' ', num2str(z_3)])
%     disp(['The length l_4 is: ', num2str(l_4)])
%     disp(['The length l_3 is: ', num2str(l_3)])
%     disp(['The length l_e is: ', num2str(l_e)])
%     disp(['The a angle is: ', num2str(radtodeg(a))])
%     disp(['The b angle is: ', num2str(radtodeg(b))])
%     disp(['The g angle is: ', num2str(radtodeg(g))])
%     disp(['The a prime angle is: ', num2str(radtodeg(ap))])
%     disp(['The b prime angle is: ', num2str(radtodeg(bp))])
%     disp(['The g prime angle is: ', num2str(radtodeg(gp))])
%     disp(['The omega 1 angle is: ', num2str(radtodeg(omg1))])
%     disp(['The omega 2 angle is: ', num2str(radtodeg(omg2))])
%     disp(['The theta4 angle is: ', num2str(radtodeg(theta4))])
    
       
%end
















