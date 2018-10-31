%% Function to make the Barrett Arm follow a trajectory while ROS is running
%% by Michail Theofanidis

function Trajectory(q)

    s=size(q);
       
    for i=1:1:s(1)
        
        JointMove(q(i,:))
        
        pause(1)
        
    end    

    JointMove(degtorad([-130 60 0 76]))
    
end


