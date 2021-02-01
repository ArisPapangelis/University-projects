clear;
% constants
error = 0.03;
v = 0.05;
xd = 15;
yd = 7.2;
% initial values
x(1) = 9.1;
y(1) = 4.3;
dh(1) = 10 - x(1); %Initial horizontal distance from obstacle
dv(1) = y(1);      %Initial vertical distance from obstacle (out of bounds)

% read model
%car = readfis('Car_Control_G_8883.fis');
car = readfis('Car_Control_G_8883_optimized.fis'); %Input either the initial or optimized FIS
for i = [0 45 90]
    theta(1) = i;
    j = 1;
    while ((x(j) < xd - error || x(j) > xd+error)) 
        % limit inputs to acceptable range
        dh(j) = min(1, dh(j));
        dh(j) = max(0, dh(j));
        dv(j) = min(1, dv(j));
        dv(j) = max(0, dv(j));
        % evaluate new ?
        dtheta = evalfis([dv(j) dh(j) theta(j)], car);
        theta(j+1) = dtheta + theta(j);
        % evaluate new x,y
        x(j+1) = x(j) + cosd(theta(j))*v;  
        y(j+1) = y(j) - sind(theta(j))*v;
        % calculate new parameters
        if y(j+1)<=5 
            dh(j+1) = 10 - x(j+1);
            dv(j+1) = y(j+1);
            
        elseif y(j+1)<=6
            dh(j+1) = 11 - x(j+1);
            if dh(j+1)<=1
                dv(j+1) = y(j+1)-5;
            else
                dv(j+1) = y(j+1);
            end
                
        elseif  y(j+1)<=7
            dh(j+1) = 12 - x(j+1);
            if dh(j+1)<=1
                dv(j+1) = y(j+1)-6;
            else
                dv(j+1) = y(j+1)-5;
            end
        else
            dh(j+1) = 1;
            if x(j+1)>=12
                dv(j+1) = y(j+1)-7;
            else
                dv(j+1) = y(j+1)-6;
            end
        end
        j=j+1;
    end
    disp([x(j), y(j)])

    %Plot the results to maintain the trajectory
    figure()
    axis ij %Reverse y axis
    hold on
    rectangle('Position',[10,0,5,5],'FaceColor',[0.5 .5 .5], 'EdgeColor', 'none')
    rectangle('Position',[11,0,4,6],'FaceColor',[0.5 .5 .5], 'EdgeColor', 'none')
    rectangle('Position',[12,0,3,7],'FaceColor',[0.5 .5 .5], 'EdgeColor', 'none')
    plot(x,y, 'r')
    plot(xd,yd,'g*')
    plot(x(j),y(j),'r*')
    hold off
end
