%% Data retrieval - Anatomical image %

path_anat = "anat.nii.gz"; % Path to anatomical NifTi file
Va = niftiread (path_anat); 
whos



figure(1);      
clf;            

for loop_counter = 1:25,    

    axial_slice_number = 10*loop_counter;
    axial_slice_vals = Va(:,axial_slice_number,:);
    axial_slice_2D = squeeze(axial_slice_vals);
    
         
    imagesc(axial_slice_2D); 
    colormap gray;                 
    caxis([ 0 250 ]); 
    title('Axial Slice')
    axis('image');   
    title('An axial slice of the brain');
    xlabel('Coronal slice number');
    ylabel('Sagittal slice number');
    pause;
    
end;   


figure(2);      
clf;            

for loop_counter = 1:12,    

    sagittal_slice_number = 10*loop_counter;
    sagittal_slice_vals = Va(sagittal_slice_number,:,:);
    sagittal_slice_2D = squeeze(sagittal_slice_vals);
    rotated_sagittal_slice = rot90(sagittal_slice_2D);
         
    imagesc(rotated_sagittal_slice); 
    colormap gray;                 
    caxis([ 0 250 ]); 
    title('Sagittal Slice')
    axis('image');  
    axis('off'); 
    pause;
    
end;    


for loop_counter = 1:25,    

    coronal_slice_number = 10*loop_counter;
    coronal_slice_vals = Va(:,coronal_slice_number,:);
    coronal_slice_2D = squeeze(coronal_slice_vals);
    rotated_coronal_slice = rot90(coronal_slice_2D);
         
    imagesc(rotated_coronal_slice); 
    colormap gray;                 
    caxis([ 0 250 ]); 
    title('Coronal Slice')
    axis('image');  
    axis('off'); 
    pause;
    
end;    

 
