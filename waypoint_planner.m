function points2 = waypoint_planner(key_points,xStep,yy,params)
    xmin = min(key_points(1,1),key_points(2,1));
    xmax = max(key_points(1,1),key_points(2,1));
    ymin = min(key_points(1,2),key_points(2,2));
    ymax = max(key_points(1,2),key_points(2,2));
    [way_xs,way_ys,way_xy] = grid_define(xmin,xmax,ymin,ymax,xStep);
    
    %This is a bad way to do this
    way_vel_points = [way_xy(:,1)/yy way_xy(:,2)/yy];
    way_vel = stable_doublegyre(way_vel_points,params);
    way_xyuv = [way_xy way_vel];
    
    E3 = E3_square(way_xs,way_ys,way_xyuv);
    waypoint1 = sub2ind([length(way_xs) length(way_ys)],...
        (key_points(1,1)-(xmin-1)),(key_points(1,2)-(ymin-1)));
    waypoint2 = sub2ind([length(way_xs) length(way_ys)],...
        (key_points(2,1)-(xmin-1)),(key_points(2,2)-(ymin-1)));
    [cost,path] = dijkstra(way_xy,E3,waypoint1,waypoint2);
    points2 = way_xy(path,:);
end