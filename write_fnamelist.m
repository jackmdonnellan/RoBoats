function list = write_fnamelist(dname, fname, start_index, final_index, step)

if nargin == 4, step = 1; end
% For reverse ordered sequence
if start_index > final_index
    step = -abs(step);
end

num_snapshots = floor(abs((final_index - start_index)/step) + 1);
list = cell(num_snapshots,1);
index = start_index;
for i = 1:num_snapshots
    list{i} = [dname, fname, sprintf('%04d',index)];
	index = index + step;
end

end