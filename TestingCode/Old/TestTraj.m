
        jointangles=(strsplit(message,'/'));
        s=length(jointangles(2:end-1));
        theta_angles=zeros(1,s);
        temp_angles =jointangles(2:end-1);
         for i=1:s
            
            theta_angles(1,i)=str2num(cell2mat(temp_angles(i)));
            
            
         end
        rows = s /3;
        trajectory = zeros(rows, 4);
        theta_angles_mat = zeros(rows,3);
        for i =1:rows
            for k =1:3
                theta_angles_mat(i,k) = theta_angles(((i-1)*3)+k);
            end
        end
        
        trajectory(:,1) = -theta_angles_mat(:,1);
        trajectory(:,2) = theta_angles_mat(:,2);
        trajectory(:,4) = theta_angles_mat(:,3);