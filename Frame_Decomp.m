%%
vid=VideoReader('4-27.mp4');
numFrames = vid.NumberOfFrames;
n=numFrames;
mkdir('Images3')
cd('Images3')
 for i = 1:9
     frames = read(vid,i);
     [imind,cm] = rgb2ind(frames,256); 
     imwrite(frames,['Image000' int2str(i), '.jpg']);
     im(i)=image(frames);
 end
  for i = 10:99
     frames = read(vid,i);
     imwrite(frames,['Image00' int2str(i), '.jpg']);
     im(i)=image(frames);
  end
  for i = 100:999
     frames = read(vid,i);
     imwrite(frames,['Image0' int2str(i), '.jpg']);
     im(i)=image(frames);
  end
  for i = 1000:n
     frames = read(vid,i);
     imwrite(frames,['Image' int2str(i), '.jpg']);
     im(i)=image(frames);
  end
  cd('..')