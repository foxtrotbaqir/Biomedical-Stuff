close all;
clear all;

path_bold = "bold.nii.gz"; % Path to anatomical NifTi file
Vf = niftiread (path_bold);
Vfm = mean (Vf,4);
whos




figure(1);     %%% Make a new figure
clf; 


set(gcf,'doublebuffer','on');   


for axial_slice_number = 1:64,       


    axial_slice_Tmap_vals = Vfm(:,:,axial_slice_number);

    axial_slice_Tmap_2D = squeeze(axial_slice_Tmap_vals);
    
    Tmap_threshold = 2200;

    True_or_false_map = (axial_slice_Tmap_2D > Tmap_threshold );
    Above_threshold_Tmap  =  True_or_false_map .*axial_slice_Tmap_2D;
    x = axial_slice_Tmap_2D + Above_threshold_Tmap.*2;
          
    
    imagesc(x);
    axis('image');
    colormap gray;
    colorbar;
    
    %caxis([ 0 250 ]); 
 
    


    

    
    xlabel(['Axial slice number ' num2str(axial_slice_number) ]); 

    title('Press any key to show the next slice');
    
    pause;     
    
end;    










figure(2);     %%% Make a new figure
clf; 


set(gcf,'doublebuffer','on');   


for sagittal_slice_number = 1:40,       


    sagittal_slice_vals = Vfm(sagittal_slice_number,:,:);
    


    sagittal_slice_2D = squeeze(sagittal_slice_vals);
    
 
    rotated_sagittal_slice = rot90(sagittal_slice_2D);
    Tmap_threshold = 2200;

    True_or_false_map = (rotated_sagittal_slice > Tmap_threshold );
    Above_threshold_Tmap  =  True_or_false_map .*rotated_sagittal_slice;
    x = rotated_sagittal_slice + Above_threshold_Tmap.*2;
          
    
    imagesc(x);
    axis('image');
    colormap gray;
    colorbar;
    
    %caxis([ 0 250 ]); 
 
    


    

    
    xlabel(['Sagittal slice number ' num2str(sagittal_slice_number) ]); 

    title('Press any key to show the next slice');
    
    pause;     
    
end;    



