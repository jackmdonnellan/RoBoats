%%
mkdir('dg_data')
cd('dg_data')
mat_size = [220,136];
x_mat = ones(mat_size(1),mat_size(2));
y_mat = ones(mat_size(1),mat_size(2));
u_mat = zeros(mat_size(1),mat_size(2));
v_mat = zeros(mat_size(1),mat_size(2));
u_mat_even = zeros(mat_size(1),mat_size(2));
u_mat_odd = zeros(mat_size(1),mat_size(2));
%% Create Position Matricies to Save
for ii = 1:mat_size(2) %x
    x_mat(:,ii) = 5*ii.*x_mat(:,ii);
end
for ii = 1:mat_size(1) %y
    y_mat(ii,:) = 5*ii.*y_mat(ii,:); %may need 680-ii
end
%% Save Data
for ii = 1:9
    str = strcat('cir_000',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
    for kk = 1:length(interpPoints(:,1))
        u_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(kk,ii);
        v_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(...
            kk+length(interpPoints(:,1)),ii);
    end
    
    if mod(ii,2) == 1
        u_mat_odd = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    if mod(ii,2) == 0
        u_mat_even = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    
    obj.u = u_mat;
    obj.v = v_mat;
end
for ii = 10:99
    str = strcat('cir_00',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
        for kk = 1:length(interpPoints(:,1))
        u_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(kk,ii);
        v_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(...
            kk+length(interpPoints(:,1)),ii);
        end
    
    if mod(ii,2) == 1
        u_mat_odd = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    if mod(ii,2) == 0
        u_mat_even = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
        
    obj.u = u_mat;
    obj.v = v_mat;
end
for ii = 100:999
    str = strcat('cir_0',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
        for kk = 1:length(interpPoints(:,1))
        u_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(kk,ii);
        v_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(...
            kk+length(interpPoints(:,1)),ii);
        end
    
    if mod(ii,2) == 1
        u_mat_odd = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    if mod(ii,2) == 0
        u_mat_even = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    
    obj.u = u_mat;
    obj.v = v_mat;
end
for ii = 1000:length(uv_data(1,:))
    str = strcat('cir_',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
        for kk = 1:length(interpPoints(:,1))
        u_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(kk,ii);
        v_mat(interpPoints(kk,1)/5,interpPoints(kk,2)/5) = uv_data(...
            kk+length(interpPoints(:,1)),ii);
        end
    
    if mod(ii,2) == 1
        u_mat_odd = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    if mod(ii,2) == 0
        u_mat_even = u_mat;
        equality(ii) = isequal(u_mat_even, u_mat_odd);
    end
    
    obj.u = u_mat;
    obj.v = v_mat;
end

