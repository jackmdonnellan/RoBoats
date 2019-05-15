close all; clear all; clc
tic
%% Set Up Images
imageSizeX = 900;
imageSizeY = floor(imageSizeX/2);
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);

numFrames = 1200;

%% Initialize Particles
radius = 3;
particleStepX = 80;
particleStepY = floor(particleStepX/2);

xInit = 0:particleStepX:imageSizeX;
yInit = 0:particleStepY:imageSizeY;

numParts = length(xInit)*length(yInit);
pos = zeros(2,numParts,numFrames);
pos(:,:,1) = combvec(xInit,yInit);
X0 = (pos(:,:,1).')./imageSizeY;
Xe(:,:,1) = X0;

% %% Movement
% t0 = 0;
% h = 1;
% n = 100;
% params.A = 1;
% for ii = 1:numFrames
%     Xe(:,:,ii+1) = rk4t(@(t,x) stable_doublegyre(x,params),...
%         Xe(:,:,ii),h,n,t0);
% end
% % Xe = Xe.*imageSizeY

%% Movement
for ii = 1:numFrames
    v =  pi * [-sin(pi*Xe(:,1,ii)) .* cos(pi*Xe(:,2,ii)), ...
             cos(pi*Xe(:,1,ii)) .* sin(pi*Xe(:,2,ii))]./imageSizeY;
    Xe(:,:,ii+1) = Xe(:,:,ii) + v;
end
Xe = Xe.*imageSizeY;
%% Plotting
mkdir('Double_Gyre_Sim')
cd('Double_Gyre_Sim')
for ii = 1:numFrames
    circlePixels = false(imageSizeY, imageSizeX); 
    for kk = 1:numParts
            centerX = Xe(kk,1,ii);
            centerY = Xe(kk,2,ii);
            circlePixels = or(circlePixels,((rowsInImage - centerY).^2 ...
                + (columnsInImage - centerX).^2 <= radius.^2));
    end
    filename = strcat('Image',sprintf('%04d',ii)); 
    f = figure('visible', 'off');
    image(circlePixels) ;
    colormap([0 0 0; 1 1 1]);
    axis off;
    print(filename,'-djpeg')
    close(f)
end
toc