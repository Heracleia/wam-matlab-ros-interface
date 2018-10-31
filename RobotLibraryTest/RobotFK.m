%% Plot the Barrett Arm Robot
%% by Michail Theofanidis

function RobotFK(q)


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
    
    %% Transformation of the End Effector
    T_e=T(:,:,1);

    for i=1:(len(2))

        T_e=T_e*T(:,:,i+1);

    end
    
    %% Frames Options

    len=[0.3 0.3 0.3 0.3 0.3];
    colors=['k' 'b' 'r' 'c' 'm'];
    font=5;

    %% Define the world frame

    % World Options
    world.limit = 1.3;
    world.axis=['X' 'Y' 'Z'];

    % Axis limits
    limits = [-world.limit world.limit -world.limit world.limit -world.limit world.limit];
    axis(limits);

    % Axis labels
    xlabel(world.axis(1))
    ylabel(world.axis(2))
    zlabel(world.axis(3))

    % Graph options
    cla
    grid on
    hold on

    % World frame
    world = gca;

    %% Assign the frames to the equivalent joints

    % Find the number of iterations
    s=size(T);

    % Array to store the frame objects
    h=zeros(1,s(3));

    for i=1:s(3)

        % In the first iteration the frame is the world
        if i==1
            frame=world;
        else    
            frame=h(i-1);
        end

        % Frame transformation
        h(i) = hgtransform('Parent', frame);    

        % Draw the Frame
        MyFrame(h(i),'length',len(i),'color',colors(i),'font',font);

        % Set the frame Parent relationship
        set(h(i),'Matrix', T(:,:,i));

    end

    %% Attach the links to the world frame

    % Initialize the Matrix Containing the position of each Joint
    xx=zeros(s(3),1);
    yy=zeros(s(3),1);
    zz=zeros(s(3),1);

    for i=1:s(3)

        % get the position of the joint
        if i==1
            Tran=T(:,:,i);
            [x,y,z]=MyTransl(Tran);
        else 
            Tran=Tran*T(:,:,i);
            [x,y,z]=MyTransl(Tran);
        end

        xx(i+1,1)=x;
        yy(i+1,1)=y;
        zz(i+1,1)=z;

    end    

    % Set the links Parent relationship
    plot3(xx,yy,zz,'ko-','Linewidth',1.5,'Parent',world)
    
    % Set the environment of the Robot
    % MyEnvironment(world)
    
    % Plot now
    drawnow

end
