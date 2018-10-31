function goHome()

command=['rosservice call /wam/go_home '];
    
s = system(command);

end

