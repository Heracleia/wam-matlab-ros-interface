%% Getting the Forward Kinematic Equations of the Barrett Arm
%% by Michail Theofanidis

function [T_ce,T_e]=RobotFK_Test(q)

    %% Input joint angles
    q=degtorad(q);

    %% Get Size of the joint values
    len=size(q);

    %% Barrett DH Table
    DH_Table=[0 -pi/2 0 q(1);
        0 pi/2 0 q(2);
        0.045 -pi/2 0.55 q(3);
        -0.045 pi/2 0 q(4);
        0 0 0.35 0];


    %% Initialize the transformations
    T=zeros(4,4,len(2)+1);

    %% Create the Homogeneous matrixes of the Barrett Arm
    for i=1:(len(2)+1)

        if i==(len(2)+1)

            % This is for the end effector
            T(:,:,i)=DH_matrix(DH_Table(i,1),DH_Table(i,2),DH_Table(i,3),DH_Table(i,4));

        else

            % This is for the res of the body
            T(:,:,i)=DH_matrix(DH_Table(i,1),DH_Table(i,2),DH_Table(i,3),DH_Table(i,4));

        end

    end

    %% Find the Homogeneous Transformation matrix of the End Effector

    %Here we multiply the matrices to find the ht of the end effector

    %initialize the matrix
    T_e=T(:,:,1);

    for i=1:(len(2))

        T_e=T_e*T(:,:,i+1);

    end

    %Here we wrire the ht according to our calculations to check whereas they are correct

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
       0 0 0 1];
   
end
