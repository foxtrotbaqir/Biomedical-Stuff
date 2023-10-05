% Import the labels data
labels_data = readtable('labels.txt');

% Extract the labels and chunks from the table
labels = labels_data.labels;
chunks = labels_data.chunks;

% Define the number of time points and conditions
num_timepoints = length(labels);
num_conditions = length(unique(labels));

% Initialize the design matrix
design_matrix = zeros(num_timepoints, num_conditions);

% Fill in the design matrix with 1s for each condition
for i = 1:num_timepoints
    condition_index = find(strcmp(unique(labels), labels(i)));
    design_matrix(i, condition_index) = 1;
end

% Plot the design matrix
save design_matrix;
imagesc(design_matrix)
colormap(gray)