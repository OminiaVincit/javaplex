% Exercise 5.4.5

clc; clear; close all;

max_dimension = 3;
num_points = 1000;
num_landmark_points = 50;
nu = 1;
num_divisions = 100;

% select points from the square [0,1] x [0,1] and then compute the distance
% matrix for these points under the induced metric on the flat Klein bottle
distances = flatKleinDistanceMatrix(num_points);

% create an explicit metric space from this distance matrix
m_space = metric.impl.ExplicitMetricSpace(distances);

% create a sequential maxmin landmark selector
landmark_selector = api.Plex4. createMaxMinSelector(m_space, num_landmark_points);
R = landmark_selector.getMaxDistanceFromPointsToLandmarks()
max_filtration_value = R;

% create a lazy witness stream
stream = streams.impl.LazyWitnessStream(landmark_selector.getUnderlyingMetricSpace(), landmark_selector, max_dimension, max_filtration_value, nu, num_divisions);
stream.finalizeStream();

% print out the size of the stream
num_simplices = stream.getSize()

% get persistence algorithm over Z/2Z
Z2_persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);

% compute the intervals
Z2_intervals = Z2_persistence.computeIntervals(stream);

% create the barcode plots
options = struct;
options.filename = 'lazyWitnessFlatKlein_Z2';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(Z2_intervals, options);

% get persistence algorithm over Z/3Z
Z3_persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 3);

% compute the intervals
Z3_intervals = Z3_persistence.computeIntervals(stream);

% create the barcode plots
options = struct;
options.filename = 'lazyWitnessFlatKlein_Z3';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(Z3_intervals, options);