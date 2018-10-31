function matlab_server()

%%  Matlab Server that waits for client request
%%  in order to execute the Dynamic Time Warping
%% (DTW)algorithm in real time.

output_port = 12345;
number_of_retries = 100000;
time = 1;
import java.net.ServerSocket
import java.io.*

if (nargin < 3)
    number_of_retries = -1; % set to -1 for infinite
end

retry = 0;

server_socket  = [];
output_socket  = [];

counter=1;

while true
    
    retry = retry + 1;
    
    try
        if ((number_of_retries > 0) && (retry > number_of_retries))
            fprintf(1, 'Too many retries\n');
            break;
        end
        
        fprintf(1, ['Try %d waiting for client to connect to this ' ...
            'host on port : %d\n'], retry, output_port);
        
        % wait for 1 second for client to connect server socket
        server_socket = ServerSocket(output_port);
        server_socket.setSoTimeout(1000);
        
        output_socket = server_socket.accept;
        
        %% UNITY CONNECTED
        fprintf(1, 'Client connected\n');
        
        input_stream   = output_socket.getInputStream;
        d_input_stream = DataInputStream(input_stream);
        
        
        % read data from the socket - wait a short time first       
        pause(time); % IT IS REQUIRED - DONT DELETE IT
        bytes_available = input_stream.available;
        fprintf(1, 'Reading %d bytes\n', bytes_available);
        
        message = zeros(1, bytes_available, 'uint8');
        for i = 1:bytes_available
            message(i) = d_input_stream.readByte;
        end
               
        message = char(message)
        
%         if strcmp(message,'OK')
%             
%             disp('OK!')
%             Trajectory(trajectory);
%             trajectory=[]
%             
%         end
        
        jointangles=(strsplit(message,'/'))
        s=length(jointangles(2:end-1))
        theta_angles=zeros(1,s)
        temp_angles =jointangles(2:end-1)
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
                      
        Trajectory(trajectory);
       
%         jointangles=(strsplit(message,'/'))
%         
%         theta_angles=str2num(cell2mat(jointangles(2:end-1)))
%         
%         theta_angles=vec2mat(theta_angles,3)
%         
%         theta_size=size(theta_angles)
%         
%         trajectory=zeros(theta_size(1),4)
%         
%         trajectory=[-theta_angles(1,:) theta_angles(2,:) 0 theta_angles(3,:)]
        
%        theta1=str2num(cell2mat(jointangles(1)));
%        theta2=str2num(cell2mat(jointangles(2)));
%        theta3=str2num(cell2mat(jointangles(3)));
%         
%         trajectory(counter,:)=[-theta1 theta2 0 theta3]
                          
        %% TO DO MATLAB SERVER
        
        pause(time); % IT IS REQUIRED - DONT DELETE IT
        
        server_socket.close;
        output_socket.close;

        
    catch
        if ~isempty(server_socket)
            server_socket.close
        end
        
        if ~isempty(output_socket)
            output_socket.close
        end
        
    end
end
end