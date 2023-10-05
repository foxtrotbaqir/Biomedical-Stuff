% Red keep part
clc; 
clear all; 
close all;
% setting parameters
sigma = 3;
mu = 2;
nu = 0.002*255*255;
iter = 500;
epsilon = 1.0;
step = 0.05;
lambda1 = 1;
lambda2 = 1;
w = 3.2;
alpha = 1;
std_1 = 3.5;
std_2 = 1.5;
rsf_weight = 0.6;

% reading image
imrgb = imread('75.jpg');

% should be grayscaled, leave if already.
imgray = double(imrgb(:,:,1));

% filter kernel K
Ksigma=fspecial('gaussian',round(2*sigma)*2+1,sigma);
KONE = imfilter(ones(size(imgray)),Ksigma,'replicate');

isExchange = 0; % '1' for bright object and dark backgroud; 
                % '-1' for dark object and bright backgroud;
                % '0' represent original model.

% % Kernel Difference operator
% ks1 = fspecial('gaussian', [5 5], std_1);
% ks2 = fspecial('gaussian', [5 5], std_2);
% ks1 = conv2(imgray,ks1, 'same');
% ks2 = conv2(imgray, ks2, 'same');
% kd = ks1 - ks2;


% Level set function adjusting to image
img_size = size(imgray);
initialphi = ones(size(imgray));
initialphi(30:80, 30:80) = -1;
% initialphi = -initialphi;

figure;
% make a plot of contouring images, contour(initialphi)
imagesc(imgray)
colormap(gray);
hold on;
contour(initialphi, [0 0], 'r');
phi = initialphi;

for i= 1:iter
    phi = RSFKD(std_1, std_2, rsf_weight, phi, imgray, mu, nu, epsilon, step, lambda1, lambda2, isExchange, Ksigma, KONE);
    phi = conv2(phi,Ksigma,'same');
    if mod(i,5) == 0
        % make a plot of contouring images, contour(initialphi)
        pause(0.0001)
        imagesc(imgray, [0, 255])
        colormap(gray);
        hold on;
        axis off
        axis equal
        contour(phi, [0 0], 'r');
        iter_num = [num2str(i), 'iterations'];
        title(iter_num);
        hold off;
    end
end