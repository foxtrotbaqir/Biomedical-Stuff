clc 
clear 


load design_matrix;

% Fit a GLM for each design matrix

% Load fMRI data
fmri_data = niftiread('bold.nii.gz');
% Perform preprocessing
% fmri_data = realign(fmri_data); % th1s funct1on 1s not ava1lable where d1d
% you tooc 1t from?
%  = smooth(fmri_datah);
x = 40;
y = 40;
z = 40;
fmri_datah = double(reshape(fmri_data(x,y,z,:),[1 size(fmri_data,4)]));
% Fit GLM
[parameter_estimates,DEV,STATS] = glmfit(design_matrix,fmri_datah,'normal','constant','off');
    
for x=1:size(parameter_estimates,1)
    parameter_estimates_1(x,1) = parameter_estimates{x,1}(1,1);
    parameter_estimates_2(x,1) = parameter_estimates{x,1}(2,1);
end

% Visualize parameter estimates
%p = cellfun(@plot,design_matrices,parameter_estimates);
figure;
t = 1:size(fmri_datah,2);
plot(t,fmri_datah,'r');
hold on

% task 2.
Tmap = STATS.t;
Bmap = STATS.beta;
VARmap = STATS.resid;


y = design_matrix*parameter_estimates_1; % chnge the parameter estimate to see onset and offset 
plot(t,y(1:size(fmri_datah,2)));
imagesc(fmri_data)
title("Parameter estimate maps")

% c = contrast of interest; here between the first and second stimulus categories; linear combination of parameter estimates
c = [-1 1 zeros(1,7)];
cov = c*(design_matrix'*design_matrix)^-1*c';

% Cmap = t value for the conditions (contrast c) of interest in voxel [ind1 ind2 ind3] =
% contrast of estimated parameters / sqrt(variance estimate)
Cmap=(c'.*squeeze(Bmap))'./(sqrt(VARmap.^2*cov));

plot(t,Cmap);

% tbc please see roianalysis.m