%% Subscribe
sub = rossubscriber('/wam/joint_states');

while(1)
    
    %% Receive Data
    data=receive(sub);
    
    %% Assign the Joints
    q=[data.Position(1) data.Position(2) data.Position(3) data.Position(4)];
    
    %% Plot the Robot
    RobotFK(q);

end