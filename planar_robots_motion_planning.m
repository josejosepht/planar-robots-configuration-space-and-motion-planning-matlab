close all
%Define the center obstacle as polyshape object
obstacle=polyshape([5 8 8 5],[4 4 5 5])
%Define the path traversed by robots A and B along x and y axes as
%discrete points (14 points in 2D cartesian space)
pathx =[1 2 3 4 4 4 5 6 7 8 9 9 9 10 11 12]
pathy1=[4 4 4 4 3.5 3 3 3 3 3 3 3.5 4 4 4 4]
pathy2=(pathy1*-1)+9
%Initialize the configuration space
cspaceAB=zeros(length(pathx));
for i=1:length(pathx)
    % iterate through the robots paths along x and y axes
    robotBx=pathx(i);
    robotBy=pathy1(i);
    for j=1:length(pathy1)
        figure
        plot(obstacle);
        hold on
        plot(pathx,pathy1);
        plot(pathx,pathy2);
        robotAx= pathx(j);
        robotAy=pathy2(j);
        %define vertices of robots A and B based on points on discrete 
        %paths along x and y axes
        pa=polyshape([robotAx-1 robotAx+1 robotAx+1 robotAx-1],[robotAy-1 robotAy-1 robotAy+1 robotAy+1]);
        pb=polyshape([robotBx-1 robotBx+1 robotBx+1 robotBx-1],[robotBy-1 robotBy-1 robotBy+1 robotBy+1]);
        plot(pa,'FaceColor','r');
        plot(pb,'FaceColor','b');
        plot(robotAx, robotAy, 'k.', 'MarkerSize', 10);
        plot(robotBx, robotBy, 'k.', 'MarkerSize', 10);
        hold off
        xlim([-1 13]);
        ylim([-1 13]);
        legend('Obstacle','Path of Robot B','Path of Robot A','Robot A','Robot B');
        %Check for collision
        %   Between Robots A and B
        colab=intersect(pa,pb);
        %   Between Robot A and center obstacle
        colaObs=intersect(pa,obstacle);
        %   Between Robot B and center obstacle
        colbObs=intersect(pb,obstacle);
        v_colab=colab.Vertices
        v_colaObs=colaObs.Vertices
        v_colbObs=colbObs.Vertices
        if(~isempty(v_colab) || ~isempty(v_colaObs) || ~isempty(v_colbObs))
            cspaceAB(i,j) = 1;
            %displaying separate collision figures only till half of configuration space collissions
            if((j<=(length(pathy1)/2))) 
            %figure
            hold on
            plot(obstacle);
            plot(pathx,pathy1);
            plot(pathx,pathy2);
            plot(pa,'FaceColor','r');
            plot(pb,'FaceColor','b');
            plot(robotAx, robotAy, 'k.', 'MarkerSize', 10);
            plot(robotBx, robotBy, 'k.', 'MarkerSize', 10);
            hold off
            legend('Obstacle','Path of Robot B','Path of Robot A','Robot A','Robot B');
            xlim([-1 13]);
            ylim([-1 13]);
            end
        end
        pause(0.125);
    end
end

%Display configuration space
imshow(1 - cspaceAB');
set(gca, 'YDir', 'normal');