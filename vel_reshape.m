clc
count = sum(ct(9:end,2));
ii = 9;
while ii > 8 && ii <= length(ct(:,1))
    jj = 1;
    for kk = 1:count
      if vel(kk,1) == ii
          vel_res(jj,:,ii) = vel(kk,2:5);
          jj = jj+1;
      end
    end
    ii = ii+1;
end
