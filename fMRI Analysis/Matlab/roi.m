clc, clear

load design_matrix;
addpath('subj2');
DataFolder = 'subj2\';
bol = 'bold.nii';
mask = 'mask4_vt.nii'; % change to test all ROIs

inputdata = load_nii([DataFolder,bol]);
AllClassMaskData = load_nii([DataFolder,mask]);
X = double(inputdata.img);
mask = double(AllClassMaskData.img);

%% ROI focused fMRI data
xdata = mask4d(X,mask);
% Pre-Process data
xdata = zscore(xdata,0,2);
%% getting beta values of roi focused data
[beta,dev,stats] = glmfit(design_matrix(1:464,:),xdata(:,1),'normal','constant','off');
for j=1:size(beta,1)
    %Average across all voxels of beta values within an ROI
    beta(j,1) = mean(beta(j,1));
end
%% average time courses within ROIs
figure;
t = 1:size(mean(xdata),2);
plot(t,mean(xdata),'r');
title("Average time courses")
%% average beta estimates as bar plots
figure;
bar(beta)
title("Average beta estimates")
%2nd category gave the largest response