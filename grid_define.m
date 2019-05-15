function [xs,ys,xy] = grid_define(xmin,xmax,ymin,ymax,step)
    xs = xmin:step:xmax;
    ys = ymin:step:ymax;
    xy = combvec(xs,ys)';
end