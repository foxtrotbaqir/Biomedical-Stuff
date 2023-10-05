load design_matrix;

V = niftiread('bold.nii.gz'); % Load NiFTI file

% GLM computation

x = 40;
y = 40;
z = 40;

Vp = reshape(V(x,y,z,:),[1 size(V,4)]);
[B, DEV, stats] = glmfit(design_matrix(1:end,1:9),double(Vp),'normal','constant','off');

% Data visualization

figure;
t = 1:size(Vp,2);
plot(t,Vp);
hold on

y = B'.*design_matrix;
plot(t,y(1:size(Vp,2)));
title("Parameter estimate maps")