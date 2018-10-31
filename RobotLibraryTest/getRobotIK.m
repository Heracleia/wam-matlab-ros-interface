%% Solving the IK for the Barrett Arm analytically
%% by Michail Theofanidis

%% Has been tested for the following Robot configurations

%% -50<theta4<90
%% -90<theta2<90
%% -150<theta1<150

function [q] = getRobotIK(xe,ye,ze)

    %% Technical Characteristics of the Robot
    l1=0.55;
    l2=0.35;
    
    z3=0.045;
    z4=-0.045;
    
    %% Finding Theta 4
    N=(xe^2+ye^2+ze^2-z3^2-z4^2-l1^2-l2^2)/2;
    R=z3*l2-z4*l1;
    T=l1*l2+z3*z4;
    
    a=(N+T)/2;
    
    b=-R;
    
    c=(N-T)/2;
    
    D=b^2-4*a*c;
    
    % First solution of theta4
    theta4(1)=2*atan((-b+sqrt(b^2-4*a*c))/(2*a));
      
    % Second solution of theta4
    theta4(2)=2*atan((-b-sqrt(b^2-4*a*c))/(2*a));
    
    % Check if the second solution is within the limits
    if radtodeg(theta4(2))<-51
       theta4(2)=theta4(1);
    end
    
    if isnan(theta4(2))
       theta4(2)=theta4(1);
    end
        
    % Check if any angle leans towards -180
    if abs(radtodeg(theta4(2))+180)<1e-3
        theta4(1)=degtorad(180);
        theta4(2)=degtorad(180);
    end
    
    % Check if close to zero
    theta4(1)=CheckZero(theta4(1));
    theta4(2)=CheckZero(theta4(2));
      
           
    %% Finding Theta 2
    
    % Theta 2 solution for the fist solution of theta4
    B = 0;
    M = cos(theta4(1))*l2-z4*sin(theta4(1))+l1;
    P = sin(theta4(1))*l2 + z4*cos(theta4(1)) + z3;
    
    theta2(1,:)=atan(((sqrt(xe^2 + ye^2-B^2)*M - ze*P))/(sqrt(xe^2 + ye^2-B^2)*P + ze*M));
    theta2(2,:)=atan(((-sqrt(xe^2 + ye^2-B^2)*M - ze*P))/(-sqrt(xe^2 + ye^2-B^2)*P + ze*M));
    
    % Theta 2 solution for the second solution of theta4
    
    M = cos(theta4(2))*l2-z4*sin(theta4(2))+l1;
    P = sin(theta4(2))*l2 + z4*cos(theta4(2)) + z3;
    
    theta2(3,:)=atan(((sqrt(xe^2 + ye^2-B^2)*M - ze*P))/(sqrt(xe^2 + ye^2-B^2)*P + ze*M));
    theta2(4,:)=atan(((-sqrt(xe^2 + ye^2-B^2)*M - ze*P))/(-sqrt(xe^2 + ye^2-B^2)*P + ze*M));
    
    %Check if close to zero
    theta2(1)=CheckZero(theta2(1));
    theta2(2)=CheckZero(theta2(2));
    theta2(3)=CheckZero(theta2(3));
    theta2(4)=CheckZero(theta2(4));
    
    theta2(5,:)=0;
    
    % Check also the -90 and 90 angles
    for i=1:4
       
        if abs(radtodeg(theta2(i)))>89 && theta2(i)>0 
            theta2(5,:)=degtorad(-90);
        end
        
        if abs(radtodeg(theta2(i)))>89 && theta2(i)<0 
            theta2(5,:)=degtorad(90);
        end
        
    end
    


        
    %% Finding Theta 1
    theta1(1)=atan2(ye,xe);
    
    %Check if close to zero
    theta1(1)=CheckZero(theta1(1));
    
    if radtodeg(theta1(1))>110
        theta1(1)=degtorad(radtodeg(theta1(1))-180);
    end
    
    if radtodeg(theta1(1))<-110
        theta1(1)=degtorad(radtodeg(theta1(1))+180);
    end
    
    if theta1(1)>0
        theta1(2)=degtorad(radtodeg(theta1(1))-180);
    else
        theta1(2)=degtorad(radtodeg(theta1(1))+180);
    end    
    
    %% LIst all the solutions
    solutions=[theta1(1) theta2(1) 0 theta4(1);
              theta1(1) theta2(2) 0 theta4(2);
              theta1(1) theta2(3) 0 theta4(1);
              theta1(1) theta2(4) 0 theta4(2);
              theta1(1) theta2(5) 0 theta4(1);
              theta1(1) theta2(1) 0 theta4(2);
              theta1(1) theta2(2) 0 theta4(1);
              theta1(1) theta2(3) 0 theta4(2);
              theta1(1) theta2(4) 0 theta4(1);
              theta1(1) theta2(5) 0 theta4(2);            
              theta1(2) theta2(1) 0 theta4(1);
              theta1(2) theta2(2) 0 theta4(2);
              theta1(2) theta2(3) 0 theta4(1);
              theta1(2) theta2(4) 0 theta4(2);
              theta1(2) theta2(5) 0 theta4(1);
              theta1(2) theta2(1) 0 theta4(2);
              theta1(2) theta2(2) 0 theta4(1);
              theta1(2) theta2(3) 0 theta4(2);
              theta1(2) theta2(4) 0 theta4(1);
              theta1(2) theta2(5) 0 theta4(2)];
          
    %% Find unique solutions
    
    unique_solutions=unique(solutions,'rows');
          
    %% Find the best solutions    
    limit=size(unique_solutions);
    
    %Vector of estimations
    v=zeros(limit(1),3);
    
    for i=1:limit(1)
       T=getRobotFK(radtodeg(unique_solutions(i,:)));
       [x y z]=MyTransl(T);
       v(i,:)=[x y z];      
    end
    
    %accepted solutions
    number=0;
    accepted=zeros(1,1);
    
    for i=1:limit(1)
        if Close(v(i,1),xe) && Close(v(i,2),ye) && Close(v(i,3),ze) && abs(radtodeg(unique_solutions(i,1)))<151 && abs(radtodeg(unique_solutions(i,2)))<92 
           number=number+1;
           accepted(number)=i;
         
        end
    end
    
   %% Find the final solutions    
   finalsolutions=radtodeg(unique_solutions(accepted(:),:));
   
   %% Sort the solution from the positive to the negatives
   finalsolutions=sortrows(finalsolutions);
   
   limit=size(finalsolutions);
   
%    if(limit(1)>2)
%     finalsolutions=sortrows(finalsolutions(end-1:end,:),[4]);
%    end
   
   %% Finally Return the final solutions
   
   q=flipud(finalsolutions);


end

