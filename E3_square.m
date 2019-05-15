function E3 = E3_square(xs,ys,xyuv)
    E3 = ones(1,3);
     for ii = 1:(length(xs)*length(ys))
        [x,y] = ind2sub([length(xs) length(ys)],ii);
        uv = xyuv(ii,3:4)./norm(xyuv(ii,3:4));
        if x<length(xs) %Moving to the Right
            ind = sub2ind([length(xs) length(ys)],x+1,y);
            cst = dot([uv(1) uv(2)],[1 0]);
            E3 = [E3;ii,ind,cst];
        end
        if x>1 %Moving to the Left
            ind = sub2ind([length(xs) length(ys)],x-1,y);
            cst = dot([uv(1) uv(2)],[-1 0]);
            E3 = [E3;ii,ind,cst];
        end
        if y<length(ys) %Moving Up
            ind = sub2ind([length(xs) length(ys)],x,y+1);
            cst = dot([uv(1) uv(2)],[0 1]);
            E3 = [E3;ii,ind,cst];
        end
        if y>1 %Moving Down
            ind = sub2ind([length(xs) length(ys)],x,y-1);
            cst = dot([uv(1) uv(2)],[0 -1]);
            E3 = [E3;ii,ind,cst];
        end
        if (x<length(xs) && y<length(ys)) %Moving Up and to the Right
            ind = sub2ind([length(xs) length(ys)],x+1,y+1);
            vec = [1 1]./sqrt(2);
            cst = dot([uv(1) uv(2)],vec)*sqrt(2);
            E3 = [E3;ii,ind,cst];
        end
        if (x>1 && y<length(ys)) %Moving Up and to the Left
            ind = sub2ind([length(xs) length(ys)],x-1,y+1);
            vec = [-1 1]./sqrt(2);
            cst = dot([uv(1) uv(2)],vec)*sqrt(2);
            E3 = [E3;ii,ind,cst];
        end
        if (x>1 && y>1) %Moving Down and to the Left
            ind = sub2ind([length(xs) length(ys)],x-1,y-1);
            vec = [-1 -1]./sqrt(2);
            cst = dot([uv(1) uv(2)],vec)*sqrt(2);
            E3 = [E3;ii,ind,cst];
        end
        if (x<length(xs) && y>1) %Moving Down and to the Right
            ind = sub2ind([length(xs) length(ys)],x+1,y-1);
            vec = [1 -1]./sqrt(2);
            cst = dot([uv(1) uv(2)],vec)*sqrt(2);
            E3 = [E3;ii,ind,cst];
        end
    end
    E3 = E3(2:end,:);
    E3(:,3) = acos(E3(:,3));
end