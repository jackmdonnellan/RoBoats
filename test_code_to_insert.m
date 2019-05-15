test_vec_x = [380:5:720];
test_vec_y = [170:5:510];
test_mat = combvec(test_vec_x,test_vec_y);
test_mat = test_mat';
test_x = ones(length(test_vec_y)).*test_vec_x;
test_y = test_vec_y'.*ones(length(test_vec_y));