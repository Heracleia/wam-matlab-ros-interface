%% Getting the Forward Kinematic Equations of the Barrett Arm
%% by Michail Theofanidis

function [Te] = getRobotFK(q)

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
    Te=T(:,:,1);

    for i=1:(len(2))

        Te=Te*T(:,:,i+1);

    end


end

