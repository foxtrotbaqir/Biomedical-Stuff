function phi = RSFKD(std_1, std_2, rsf_weight, phi, img, mu, nu, epsilon, timestep, lambda1, lambda2,isExchange, Ksigma, KONE)
% phi = level set function
% img = input image
phi = NeumannBoundaryConditions(phi);
df = (epsilon/pi)./(epsilon^2+phi.^2);
hf = 0.5*(1+(2/pi)*atan(phi./epsilon));
curvature = curv(phi);
length = nu.*df.*curvature;

limiting = mu*(4*del2(phi)-curvature);
% locating mean intensities
ls1=conv2(img.*hf, Ksigma, 'same'); %local intensity 1
b1 = conv2(hf, Ksigma, 'same');
ms1 = ls1./b1; % mean intensity of saliency map 1
ls2 = conv2(img.*(1-hf),Ksigma,'same'); %local intensity 2
b2 = conv2(1-hf, Ksigma, 'same');
ms2 = ls2./b2;

[ms1,ms2]=exchange(ms1,ms2,isExchange);

% Kernel Difference operator
ks1 = fspecial('gaussian', [5 5], std_1);
ks2 = fspecial('gaussian', [5 5], std_2);
ks1 = conv2(img,ks1, 'same');
ks2 = conv2(img, ks2, 'same');
kd = ks1 - ks2;

if rsf_weight~=0
    
    r1 = (lambda1-lambda2)*KONE.*img.*img;
    e1 = imfilter(lambda1.*ms1 - lambda2.*ms2, Ksigma, 'replicate');
    e2 = imfilter(lambda1.*ms1.*ms1 - lambda2.*ms2.*ms2, Ksigma, 'replicate');
    RSF = -rsf_weight*df.*(r1-2.*e1.*img+e2);
else
    RSF = 0;
end
% here in phi, kd operator is going to be added
phi = phi + timestep.*(length + limiting + RSF + kd);


function g = NeumannBoundaryConditions(f)
% Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);

function k = curv(u)
% compute curvature
[ux,uy] = gradient(u);
normDu = sqrt(ux.^2+uy.^2+1e-10);
Nx = ux./normDu;
Ny = uy./normDu;
[nxx,~] = gradient(Nx);
[~,nyy] = gradient(Ny);
k = nxx+nyy;

function [f1,f2]=exchange(f1,f2,isExchange)
%exchange f1 and f2
if isExchange==0
    return;
end
if isExchange==1
    f1=min(f1,f2);
    f2=max(f1,f2);
end
if isExchange==-1
    f1=max(f1,f2);
    f2=min(f1,f2);
end
