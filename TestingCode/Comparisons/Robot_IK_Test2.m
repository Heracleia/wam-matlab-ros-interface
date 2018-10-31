%% Testing the Inverse Kinematic Equations of the Barrett Arm
%% by Michail Theofanidis

%function [rtrn]=RobotIK_Test(q)
    
    clear
    clc

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
    z_e=l2*(r33)+z4*r31+z3*(-s2*c3)+l1*(c2);
    
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
                
    c_2=(z_e-l2*r33-z4*r31+z3*r32)/l1;
    
    c_2=Check(c_2);
          
    s_2=sqrt(1-c_2^2);
    
    theta2(1)=atan2(s_2,c_2);
    theta2(2)=-atan2(s_2,c_2);
            
    %% Finding theta 1
       
    A=c2*c3*s4*dw + s2*c4*dw + c2*c3*a4*c4+s2*a4*s4 + c2*a3*c3 + s2*d3;
    
    B=s3*s4*dw + s3*a4*c4 + a3*s3;
        
    theta1=atan((A*y_e-B*x_e)/(A*x_e+B*y_e));
    
    %% Write down all the solutions
    
    solution(1,:)=[theta1 theta2(1) 0 theta4(1)];
    solution(2,:)=[theta1 theta2(2) 0 theta4(2)];
    solution(3,:)=[theta1 theta2(2) 0 theta4(1)];
    solution(4,:)=[theta1 theta2(2) 0 theta4(2)];
    
    %% Display the angles
    
    disp(['The first solution is: ', num2str(radtodeg(solution(1,:))),])
    disp(['The second solution is: ', num2str(radtodeg(solution(2,:))),])
    disp(['The third solution is: ', num2str(radtodeg(solution(3,:))),])
    disp(['The forth solution is: ', num2str(radtodeg(solution(4,:))),])
    
    % Get the new positions
    p1=RobotFK_Test(radtodeg(solution(1,:)));
    p2=RobotFK_Test(radtodeg(solution(2,:)));
    p3=RobotFK_Test(radtodeg(solution(3,:)));
    p4=RobotFK_Test(radtodeg(solution(4,:)));
    
    %% Display the positions
    
    disp(['The old position was: ', num2str(x_e),' ', num2str(y_e),' ', num2str(z_e)])
    disp(['The new position is: ', num2str(p1(1,4)),' ', num2str(p1(2,4)),' ', num2str(p1(3,4))])
    disp(['The new position is: ', num2str(p2(1,4)),' ', num2str(p2(2,4)),' ', num2str(p2(3,4))])
    disp(['The new position is: ', num2str(p3(1,4)),' ', num2str(p3(2,4)),' ', num2str(p3(3,4))])
    disp(['The new position is: ', num2str(p4(1,4)),' ', num2str(p4(2,4)),' ', num2str(p4(3,4))])

%     %% Display the data
%     disp(['The desired solution is: ', num2str(alpha),' ', num2str(beta),' ', num2str(gamma), ' which provides: ', num2str(xe), num2str(ye), num2str(ze)])
%     
%     for i=1:number
%        T=RobotFK_Test(radtodeg(unique_solutions(accepted(i),:)));
%        [x y z]=MyTransl(T);
%        disp(['Solution: ', num2str(radtodeg(unique_solutions(accepted(i),1))),' ', num2str(radtodeg(unique_solutions(accepted(i),2))),' ', num2str(radtodeg(unique_solutions(accepted(i),4))), ' which provides: ', num2str(x), num2str(y), num2str(z), ]) 
%     end
%     disp('----------------------------------------------------------------------------------------------------------------------------------------------------------')
          
%end