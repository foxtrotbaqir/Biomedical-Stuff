function curvature = curv(phi)
[bdx, bdy] = gradient(phi);
mag_bg = sqrt(bdx.^2 + bdy.^2) + 1e-10;
nx = bdx./mag_bg;
ny = bdy./mag_bg;
[nxx, nxy] = gradient(nx);
[nyx, nyy] = gradient(ny);
curvature = nxy + nyx; 
