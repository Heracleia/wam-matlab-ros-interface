clear
clc

%% Technical Characteristics of the Robot
l1=0.55;
l2=0.35;

z3=0.045;
z4=-0.045;

plane=zeros(1,24);
location=linspace(-1,1,24);
plot(location,plane,'r')
hold on

for gamma=-50:10:80
    
    alpha=0;
    beta=0;
    
    q=[alpha beta 0 gamma];
        
    %% Solve the Forward Kineamtics to get the IK input
    Te=RobotFK_Test(q);
    [xe,ye,ze]=MyTransl(Te);
    
        
    cA=(xe^2+ye^2+ze^2-l1^2-l2^2)/(-2*l1*l2);
    cA=Check(cA);
    sA=sqrt(1-cA^2);
    
    A=atan2(sA,cA);
    
    N=(xe^2+ye^2+ze^2-z3^2-z4^2-l1^2-l2^2)/2;
    R=z3*l2-z4*l1;
    T=l1*l2+z3*z4;
    
    a=(N+T)/2;
    
    b=-R;
    
    c=(N-T)/2;
      
    x=[-1:0.01:1];
    
    y=a*x.^2+b*x+c;
    
    minimum=radtodeg(2*atan(min(y)));
    sol1=radtodeg(2*atan((-b+sqrt(b^2-4*a*c))/(2*a)));
    sol2=radtodeg(2*atan((-b-sqrt(b^2-4*a*c))/(2*a)));
    
    disp(['The desired angle is : ', num2str(gamma),])
    disp(['The desired min is : ', num2str(minimum),])
    disp(['The 1rst solution is : ', num2str(sol1),])
    disp(['The 2nd solution is : ', num2str(sol2),])
    disp(['The posture is : ', num2str(radtodeg(A)),])
    disp('------------------------------------------------')
    if gamma<20
        plot(x,y,'r')
    else
        plot(x,y,'b')
    end
    pause
    
    
end