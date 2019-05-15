%John Donnellan
%Condensed Code
close all; clear all; clc
%% Tracker Code
tic
bg = BackgroundImage('Images/Image*.jpg','background.jpg');
figure; imagesc(bg); colormap gray; title('background image');
[vtracks,ntr,lm,lrms] = ...
    PredictiveTracker('Images/Image*.jpg',15,10,'background.jpg',3,1,0);

%% Velocity Information
[u,v,x,y,t]=Velocities(vtracks,[8 inf],1);
vel = [t x y u v]; %Put velocity data in nice matrix

%% Vorticity Stuff
[vort,x,y,t,tr] = Vorticities(vtracks,[0 inf],0);

%% Interpolation
%Count the number of particles in each frame
frames = vel(:,1);
ct = zeros(frames(end),2);
ct(:,1) = 1:frames(end);
for ii = 1:length(frames)
    ct(vel(ii,1),2) = ct(vel(ii,1),2)+1;
end

%Interpolate by frame
c = [550 340];
r = 250;
interpPoints =zeros(1,2);
step = 5;
uv_data = [];
%Define interpolation points
for kk = c(1)-r:step:c(1)+r
    for ii = c(2)-r:step:c(2)+r
        if (c(1)-kk)^2+(c(2)-ii)^2 <r^2
            interpPoints = [interpPoints;[kk,ii]];
        end
    end
end
interpPoints = interpPoints(2:end,:);

%Actual Interpolation
count = 0;
for ii = 1:ct(end,1)
    if ct(ii,2) >= 40 %if there are more than 40 particles in the frame
        count = count+1;
        if mod(count,1) == 0 %get data every frame
            frameMat = vel(find(vel(:,1)==ii,1):find(vel(:,1)==ii+1)-1,:);
            UF = scatteredInterpolant(frameMat(:,2),frameMat(:,3),frameMat(:,4));
            VF = scatteredInterpolant(frameMat(:,2),frameMat(:,3),frameMat(:,5));
            u_vals = UF(interpPoints(:,1),interpPoints(:,2));
            v_vals = VF(interpPoints(:,1),interpPoints(:,2));
            uv_data = [uv_data,[u_vals;v_vals]];%,vel_vals]];
        end
    end
end

%% Singular-Value Decomposition and Eigenvalues
nn = 5; %Look at the first nn modes
frame_num = 5;%Look at u and v for this frame
mean_flow = mean(uv_data,2);

for ii = 1:length(uv_data(1,:))
    fluctuations(:,ii) = uv_data(:,ii)-mean_flow;
end

[Us,Ss,Vs] = svd(fluctuations,'econ');
temp_amp = Ss*Vs';

for n = 1:nn
    A = Us(:,1:n)*Ss(1:n,1:n)*Vs(:,1:n)';
    half = length(A(:,1))/2;
    
    
    % Plotting
    if n == nn %Sum of First nn modes 
        
        %Singular Values and KE's
        figure
        semilogy(diag(Ss.^2/sum(diag(Ss.^2))))
        title('Normalized Eigenvalues')
        xlabel('Singular Value Number')
        ylabel('Normalized Eigenvalue')
        xlim([0,25])
        
        figure
        semilogy(diag(Ss));
        title('Singular Values')
        xlabel('Singular Value Number')
        ylabel('Singular Value')
        xlim([0,25])
        
        % U Velocity Approximation
        figure
        subplot(1,2,1)
        [xi,yi] = meshgrid(300:1:800, 90:1:590);
        zi = griddata(interpPoints(:,1),interpPoints(:,2),...
            A(1:half,frame_num),xi,yi);
        s1 = surf(xi,yi,zi);
        
        title('nn mode approximation')
        xlabel('x')
        ylabel('y')
        zlabel('U-velocity')
        s1.EdgeColor = 'none';
        
        subplot(1,2,2)
        zi = griddata(interpPoints(:,1),interpPoints(:,2),...
            fluctuations(1:half,frame_num),xi,yi);
        s1 = surf(xi,yi,zi);
        title('Frame Data')
        xlabel('x')
        ylabel('y')
        zlabel('U-velocity')
        s1.EdgeColor = 'none';
        
        % V-Velocity Approximation
        figure
        subplot(1,2,1)
        zi = griddata(interpPoints(:,1),interpPoints(:,2),...
            A(half+1:end,frame_num),xi,yi);
        s2 = surf(xi,yi,zi);
        title('nn mode approximation')        
        xlabel('x')
        ylabel('y')
        zlabel('V-velocity')
        s2.EdgeColor = 'none';
        
        subplot(1,2,2)
        zi = griddata(interpPoints(:,1),interpPoints(:,2),...
            fluctuations(half+1:end,frame_num),xi,yi);
        s1 = surf(xi,yi,zi);
        title('Frame Data')        
        xlabel('x')
        ylabel('y')
        zlabel('V-velocity')
        s1.EdgeColor = 'none';
    end
end

% Plotting Mean Flow
figure
ui = griddata(interpPoints(:,1),interpPoints(:,2),...
    mean_flow(1:half),xi,yi);
s1 = surf(xi,yi,ui);
title('U-Vel Mean Flow')        
xlabel('x')
ylabel('y')
zlabel('U-velocity')
s1.EdgeColor = 'none';

figure
vi = griddata(interpPoints(:,1),interpPoints(:,2),...
    mean_flow(half+1:end),xi,yi);
s2 = surf(xi,yi,vi);
title('V-Vel Mean Flow')        
xlabel('x')
ylabel('y')
zlabel('V-velocity')
s2.EdgeColor = 'none';

% %% Plot First 3 Modes
% mode_num = 3;
% loops = length(A(1,:));
% ii = 1;
% u_avi = VideoWriter('test.avi');
% v_avi = VideoWriter('test.avi');
% u_avi.FrameRate = 10;
% v_avi.FrameRate = 10;
% open(u_avi)
% open(v_avi)
% figure
% for ii = 1:mode_num
%     PPP = Us(:,ii)*Ss(ii,ii)*Vs(:,ii)';
%     F(loops) = struct('cdata',[],'colormap',[]);
%     figure('visible','off')
%     for j = 1:loops
%         zi = griddata(interpPoints(:,1),interpPoints(:,2),...
%             PPP(1:half,j),xi,yi);
% %         zii = griddata(interpPoints(:,1),interpPoints(:,2),...
% %             mean_flow(1:half),xi,yi);
% %         zi = zi + zii;
%         s = surf(xi,yi,zi);
%         title('1st Mode')        
%         xlabel('x')
%         ylabel('y')
%         zlabel('U-velocity')
%         s.EdgeColor = 'none';
%         view(2)
%         colormap(jet(256))
%         zlim([-8 8])
%         caxis([-8 8]);
%         F(j) = getframe;
%         writeVideo(u_avi,F(j));
%     end
%     figure
%     movie(F,1,10)
%     
%     G(loops) = struct('cdata',[],'colormap',[]);
%     figure('visible','off')
%     for j = 1:loops
%         zi = griddata(interpPoints(:,1),interpPoints(:,2),...
%             PPP(half+1:end,j),xi,yi);
% %         zii = griddata(interpPoints(:,1),interpPoints(:,2),...
% %             mean_flow(half+1:end),xi,yi);
% %         zi = zi + zii;
%         s1 = surf(xi,yi,zi);
%         title('1st Mode')        
%         xlabel('x')
%         ylabel('y')
%         zlabel('V-velocity')
%         s1.EdgeColor = 'none';
%         view(2)
%         colormap(jet(256))
%         zlim([-8 8])
%         caxis([-8 8]);
%         G(j) = getframe;
%         writeVideo(v_avi,G(j));
%     end
%     figure
%     movie(G,1,10)
% end 
%    
% close(u_avi);
% close(v_avi);

%% Particle Moving in Mean Flow (massless)
%Setup
part_pos = zeros(1,2)
part_vel = zeros(1,2);
dt = 1/15; %s (1/15 is every frame)
run_time = 25; %s

%Initial conditions
part_ip = [550 450];
part_iv = [0 0];
part_pos(1,:) = part_ip;
part_vel(1,:) = part_iv;

%Movement Loop
for ii = 2:(run_time/dt)
    xd = int16(part_pos(ii-1,1));
    yd = int16(part_pos(ii-1,2));
    [r,c] = find((s1.XData==xd) & (s1.YData==yd));
    [r2,c2] = find((s2.XData==xd) & (s2.YData==yd));
    pos_vel = [s1.ZData(r,c) s2.ZData(r2,c2)];
    part_vel(ii,:) = pos_vel;
    part_pos(ii,:) = part_pos(ii-1,:) + part_vel(ii,:);
end
figure
plot(part_pos(:,1),part_pos(:,2),'o')
xlim([300 800])
ylim([0 600])
hold on

figure
plot(part_pos(:,1),'b')
hold on

plot(part_pos(:,2),'r')

%% Particle Moving in Flow Data (massless)
%Setup
part_pos_2 = zeros(1,2)
part_vel_2 = zeros(1,2);

%Initial conditions
part_ip_2 = [550 450];
part_iv_2 = [0 0];
part_pos_2(1,:) = part_ip_2;
part_vel_2(1,:) = part_iv_2;

%Movement Loop
for ii = 2:(run_time/dt)
    xd = part_pos_2(ii-1,1);
    yd = part_pos_2(ii-1,2);
    k = dsearchn(vel(:,2:3),[xd yd]);
    pos_vel_2 = vel(k,4:5);
    part_vel_2(ii,:) = pos_vel_2;
    part_pos_2(ii,:) = part_pos_2(ii-1,:) + part_vel_2(ii,:);
end
figure
plot(part_pos_2(:,1),part_pos_2(:,2),'o')
xlim([300 800])
ylim([0 600])

figure
plot(part_pos_2(:,1),'b')
hold on
plot(part_pos_2(:,2),'r')

%%
toc