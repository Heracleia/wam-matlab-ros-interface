%% Function to move the Barrett Arm while ROS is running
%% by Michail Theofanidis

function JointMove(q)


         q_string=['["' num2str(q(1)) ', ' num2str(q(2)) ', ' num2str(q(3)) ', ' num2str(q(4)) '"]'];

        command=['rosservice call /wam/joint_move ' q_string]

        s = system(command);
        
           
end

