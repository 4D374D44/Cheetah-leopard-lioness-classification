clear all
format long
for i=1:40
filename = sprintf('Cheetah/Cheetah_%d.jpg', i);
imdata = imread(filename);
imdata = imdata(:,:,1);
dataP(i,:) = imdata(:);
end
for i=1:40
filename = sprintf('Leopard/Leopard_%d.jpg', i);
imdata = imread(filename);
imdata = imdata(:,:,1);
dataP(i+40,:) = imdata(:);
end
for i=1:40
filename = sprintf('Lioness/Lioness_%d.jpg', i);
imdata = imread(filename);
imdata = imdata(:,:,1);
dataP(i+80,:) = imdata(:);
end
dataN = double(dataP);
dataN(:,:) = double(dataN(:,:)/255.0);
for i=1:120
if (i<41)
dataN(i,1601)=0;
end
if (i>40 && i<81)
dataN(i,1601)=0.5;
end
if (i>80)
dataN(i,1601)=1;
end
end
save("Out.mat","dataN");