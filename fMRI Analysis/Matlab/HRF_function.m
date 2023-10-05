% load labels.txt into a variable
labels = readtable('labels.txt');

% unique stimulus categories
stimuli = unique(labels.labels);

% create a binary matrix with columns representing each stimulus category
design_matrix = zeros(height(labels), length(stimuli));
for i = 1:length(stimuli)
    design_matrix(:,i) = strcmp(labels.labels, stimuli(i));
end

% Set the rest rows to 0
design_matrix(strcmp(labels.labels, 'rest'),:) = 0;

% load HRF
load('hrf.mat');

% convolve the binary matrix with HRF
design_matrix = conv2(design_matrix, hrf_highres, 'same');

% visualize the design matrix
imagesc(design_matrix);
colormap(jet);
xlabel('Time Points');
ylabel('Stimuli');
